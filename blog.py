from flask import Flask,render_template,flash,redirect,url_for,session,logging,request
#formlardan bilgi alamaya yarayan requesti de dahil ediyoruz.
from flask_mysqldb import MySQL
#mysql bağlanmak için bu modül import edildi
from wtforms import Form,StringField,TextAreaField,PasswordField,validators
from wtforms.fields.html5 import EmailField
#form işlemleri için gerekli olarak gerekli modül
import email_validator
from passlib.handlers.sha2_crypt import sha256_crypt
# parola görünümü için gerekli modül
from functools import wraps
# bu modül ile decorator kullanarak kullanıcının giriş yapmadan girmemesi gereken yerler sınırlandırılacak

# Decarator
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:
            return f(*args, **kwargs)
        else:
            flash("Bu sayfayı görüntülemek için lütfen giriş yapınız...","danger")
            return redirect(url_for("login"))
    return decorated_function


class RegisterForm(Form):
    name = StringField("Name Surname",validators=[validators.length(min=5,max=25),validators.DataRequired(message="Bu alan boş bırakılamaz..")])
    username = StringField("User Name",validators=[validators.length(min=5,max=15),validators.DataRequired(message="Bu alan boş bırakılamaz..")])
    email = EmailField("E-mail Adress",validators=[validators.Email(message="Lütfen geçerli bir email giriniz.."),validators.DataRequired(message="Bu alan boş bırakılamaz..")])
    password = PasswordField("Password",validators=[
        validators.DataRequired(message="Bu kısım boş bırakılamaz.."),
        validators.EqualTo(fieldname="confirm",message="Parola uyuşmuyor.. Lütfen kontrol ediniz..")
    ])
    confirm = PasswordField("Verify Password")
    
class LoginForm(Form):
    username = StringField("Kullanıcı Adı")
    password = PasswordField("Parola")
    
app = Flask (__name__)
app.secret_key = "msblog"

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "msblog"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
# mysql bilgilerini flask ile bağlamamız için yazmamız gerekenler
database = MySQL(app)
#flask içerisindeki app'i mysql ile bağlamaya yarayan kod.

# Anasayfa
@app.route("/") # flask işlevinin hangi URL de tetiklenmesini söylemek için route dekoratörü kullanılır. böylelikle "localhost:5000/" üzerinde bir host kurulur.
def index():
    return render_template("index.html")

@app.route("/about")
def about():
    return render_template("about.html")

# Dashboard
@app.route("/dashboard")
@login_required
def dashboard():
    cursor = database.connection.cursor()
    
    sorgu = "Select * from articles where author = %s"
    result = cursor.execute(sorgu,(session["username"],))
    
    if result > 0:
        articles = cursor.fetchall()
        return render_template("dashboard.html",articles = articles)
    else:
        return render_template("dashboard.html")

# Articles Page
@app.route("/articles")
def articles():
    cursor = database.connection.cursor()
    
    sorgu = "Select * from articles"
    result = cursor.execute(sorgu)
    
    if result > 0:
        articles = cursor.fetchall()
        return render_template("articles.html",articles = articles)
    else:
        return render_template("articles.html")

#Detay page
@app.route("/article/<string:id>")
def article(id):
    cursor = database.connection.cursor()
    
    sorgu = "Select * from articles where id = %s"
    result = cursor.execute(sorgu,(id,))

    if result > 0:
        article = cursor.fetchone()
        return render_template("article.html",article=article)
    else:
        return render_template("article.html")

# Register
@app.route("/register",methods= ["GET","POST"])
def register():
    form = RegisterForm(request.form)

    if request.method == "POST" and form.validate():
        name = form.name.data
        username = form.username.data
        email = form.email.data
        password = form.password.data
        password = sha256_crypt.encrypt(form.password.data)
        
        cursor = database.connection.cursor()
        
        
        sorgu = "Insert into users(name,email,username,password) VALUES(%s,%s,%s,%s)"
        cursor.execute(sorgu,(name,email,username,password))
        database.connection.commit()
        cursor.close()

        flash("Başarıyla kayıt oldunuz...","success")
        return redirect(url_for("login"))
            
    else:
        return render_template("register.html",form=form)
        

# Login
@app.route("/login",methods=["GET","POST"])
def login():
    form = LoginForm(request.form)
    
    if request.method == "POST":
        username = form.username.data
        password_entered = form.password.data
        
        cursor = database.connection.cursor()
        
        sorgu = "Select * from users where username = %s"
        result = cursor.execute(sorgu,(username,))
        
        if result > 0:
            data = cursor.fetchone()
            real_password = data["password"]
            
            if sha256_crypt.verify(password_entered,real_password):
                flash("Başarıyla giriş yaptınız...","success")
                
                session["logged_in"] = True
                session["username"] = username
                
                return redirect(url_for("index"))
            
            else:
                flash("Parolanız uyuşmuyor.. Lütfen Kontrol Ediniz..","danger")
                return redirect(url_for("login"))
        else:
            flash("Böyle bir kullanıcı bulunmuyor...","warning")
            return redirect(url_for("login"))
        
    return render_template("login.html",form=form)

#Logout
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))

# Add Article
@app.route("/addarticle",methods=["GET","POST"])
@login_required
def addarticle():
    form = ArticleForm(request.form)
    if request.method == "POST" and form.validate():
        title = form.title.data
        content = form.content.data
        
        cursor = database.connection.cursor()
        
        sorgu = "Insert into articles(title,author,content) VALUES(%s,%s,%s)"
        cursor.execute(sorgu,(title,session["username"],content))
        database.connection.commit()
        cursor.close()
    
        flash("Makale başarıyla eklendi...","success")
        return redirect(url_for("dashboard"))
    
    else:
        return render_template("addarticle.html",form=form)

# Article Delete
@app.route("/delete/<string:id>")
@login_required
def delete(id):
    cursor = database.connection.cursor()
    
    sorgu = "Select * from articles where author = %s and id = %s"
    result = cursor.execute(sorgu,(session["username"],id))

    if result > 0:
        sorgu2 = "Delete from articles where id = %s"
        cursor.execute(sorgu2,(id,))
        database.connection.commit()
        
        return redirect(url_for("dashboard"))
    else:
        flash("Böyle bir makale yok veya bu işleme yetkiniz bulunmuyor..","danger")
        return redirect(url_for("index"))
    
#Article Update
@app.route("/edit/<string:id>",methods=["GET","POST"])
@login_required
def update(id):
    
    if request.method == "GET":
        cursor = database.connection.cursor()
        
        sorgu = "Select * from articles where author = %s and id = %s"
        result = cursor.execute(sorgu,(session["username"],id))
        
        if result == 0:
            flash("Böyle bir makale yok veya bu işlemi yapmaya yetkiniz bulunmuyor..","danger")
            return redirect(url_for("index"))
        else:
            article = cursor.fetchone()
            form = ArticleForm()
            
            form.title.data = article["title"]
            form.content.data = article["content"]
            
            return render_template("update.html",form=form)
    
    else:
        form = ArticleForm(request.form)
        
        newTitle = form.title.data
        newContent = form.content.data
        
        sorgu2 = "Update articles Set title = %s,content = %s where id = %s"
        cursor = database.connection.cursor()
        cursor.execute(sorgu2,(newTitle,newContent,id))
        
        database.connection.commit()
        
        flash("Makale Başarıyla Güncellendi..","success")
        return redirect(url_for("dashboard"))
    
# Artickle Form
class ArticleForm(Form):
    title = StringField("Article Title",validators=[validators.length(min=5,max=100)])
    content = TextAreaField("Article Content",validators=[validators.length(min=10)])
    

# Search URL
@app.route("/search",methods=["GET","POST"])
def search():
    if request.method == "GET":
        return redirect(url_for("index"))
    
    else:
        keyword = request.form.get("keyword")
        
        cursor = database.connection.cursor()
        
        sorgu = "Select * from articles where title Like '%" + keyword + "%'"
        result = cursor.execute(sorgu)
        
        if result == 0:
            flash("Aranan kelimeye uygun bir makale bulunmamaktadır..","warning")
            return redirect(url_for("articles"))
        else:
            articles = cursor.fetchall()
            return render_template("articles.html",articles=articles)
    

if __name__ == "__main__":
    app.run(debug=True)