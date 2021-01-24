-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 24 Oca 2021, 13:34:05
-- Sunucu sürümü: 10.4.17-MariaDB
-- PHP Sürümü: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `msblog`
--
CREATE DATABASE IF NOT EXISTS `msblog` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `msblog`;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `author` text NOT NULL,
  `content` text NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `articles`
--

INSERT INTO `articles` (`id`, `title`, `author`, `content`, `created_date`) VALUES
(6, 'Stack vs Heap: Farkları Nedir?', 'm1usty', '<h2>Bellek Segmentleri Nelerdir?</h2>\r\n\r\n<p>İlk olarak programımız başlatıldığında programa verilen bellek(RAM), segment adındaki farklı alanlara ayrılır, Stack ve Heap de bu alanlar arasından en &ouml;nemli olanları, elbette bu alanlar Stack ve heap ile kalmıyor, Stack ve Heap dışındaki alanları basit&ccedil;e &ouml;zet ge&ccedil;elim:</p>\r\n\r\n<ul>\r\n	<li><strong>Text/Code segment</strong>: Derlenmiş programımızın talimatlarının &ccedil;alıştırılmak &uuml;zere kopyalanıldığı ve saklanıldığı yerdir.</li>\r\n	<li><strong>Bss segment</strong>(&ldquo;block started by symbol.&rdquo;): veri atanmamış veya sıfır ile başlatılmış global ve statik değişkenlerin saklanıldığı yerdir. bu segmentin bulunma sebepi programın boyutu ile ilgili optimizasyonlardır, sonu&ccedil;ta başlatılmasa da o değişkenlerin değeri &ldquo;0&rdquo;(sıfır) dır, bu y&uuml;zden binary&rsquo;de bu segment i&ccedil;in sadece boyutunun ne kadar olduğu gereklidir.</li>\r\n	<li><strong>Data segment</strong>: değeri verilip başlatılmış statik ve global değişkenlerin saklandığı yerdir.</li>\r\n</ul>\r\n\r\n<h3>Heap segmenti nedir?</h3>\r\n\r\n<p>Heap segmenti (&ldquo;free store&rdquo; olarak da bilinir) boyutu b&uuml;y&uuml;k veya belli olmayan verileri saklamak i&ccedil;in kullanılan segment&rsquo;dir (B&uuml;y&uuml;k boyutlu arrayler, objeler&hellip;) &ccedil;&uuml;nk&uuml; Heap segmenti, Stack segmentinin aksine belirli bir boyutu yoktur yani boyutu genişleyebilir, değişebilir. ayrıca sakladığımız verinin yaşam s&uuml;resini kontrol etmek istediğimiz zamanlarda kullanırız.</p>\r\n\r\n<p>Heap de Stack&rsquo;ın aksine ayırdığınız yer manuel olarak boşaltılması yani silinmesi gerek aksi taktirde<strong>&nbsp;memory leak</strong>&nbsp;durumu oluşur,&nbsp;<strong>memory leak</strong>&lsquo;i bir kiracının evinizde kalıp eşyalarını bırakıp gitmesi gibi d&uuml;ş&uuml;nebilirsiniz, bu &ouml;rnekte ev: bellek, eşya: veri.</p>\r\n\r\n<h4>&nbsp;</h4>\r\n\r\n<h4>Heap Segmenti Avantajları</h4>\r\n\r\n<ul>\r\n	<li>Boyut olarak sizi sınırlamaz.</li>\r\n	<li>Heap de ayırdığın veriye erişim kısıtlı değildir yani veriyi silmediğiniz taktirde istediğiniz yerde ayırılan verinin saklanıldığı yerin adresi bulunduğu s&uuml;rece o veriye erişebilirsiniz.</li>\r\n</ul>\r\n\r\n<h4>Heap Segmenti Dezavantajları</h4>\r\n\r\n<ul>\r\n	<li>Y&ouml;netimi nispeten zordur.</li>\r\n	<li>Heap &uuml;zerinde yer ayırtmak Stack &uuml;zerinde yer ayırtmaktan nispeten yavaştır.</li>\r\n	<li>C++ i&ccedil;in konuşursak Heap&rsquo;deki alana erişmek i&ccedil;in pointer kullanmalıyız ve dereferance yapmak direk değişkene erişmekten daha yavaş &ccedil;alışır.</li>\r\n</ul>\r\n\r\n<h3>Stack Veri Yapısı Nedir?</h3>\r\n\r\n<p>Stack segmenti verileri d&uuml;zenlemek i&ccedil;in ismini de aldığı Stack adındaki veri yapısını kullanır , bu y&uuml;zden Stack segmentini anlamadan ve &ouml;ğrenmeden &ouml;nce bu veri yapısını anlamak ve &ouml;ğrenmek gerek.</p>\r\n\r\n<p>Stack veri yapısı isminden de anlaşılacağı &uuml;zere (ENG stack -&gt; TR yığın) yığın halinde kullanılır</p>\r\n\r\n<p><img alt=\"\" src=\"https://siberci.com/wp-content/uploads/2020/11/depositphotos_61843197-stock-photo-stack-of-books-200x300.jpg\" style=\"float: left; width: 200px; height: 300px;\" />&nbsp; &nbsp; &nbsp;Stack veri yapısını &uuml;st &uuml;ste yığılmış kitaplar &ouml;rneği ile d&uuml;ş&uuml;nebilirsiniz sonu&ccedil;ta kitap yığınında istediğiniz bir kitabı d&uuml;zg&uuml;nce almak istiyorsanız o kitapın &uuml;st&uuml;ndeki kitapları da indirmeniz gerekir aynı stack veri yapısındaki gibi</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img alt=\"\" src=\"https://siberci.com/wp-content/uploads/2020/11/clip_image0031.gif\" style=\"width: 405px; height: 111px;\" /></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Stack veri yapısı &ccedil;alışma şekli</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Stack benzetmesi</p>\r\n\r\n<h3>Stack Segmenti Nedir?</h3>\r\n\r\n<p>Stack segmenti (&ldquo;Call stack&rdquo; da denir) programdaki aktif fonksiyonların&nbsp;<strong>Stack frame</strong>&lsquo;lerini &uuml;st &uuml;ste&nbsp;<strong>yığın</strong>&nbsp;halinde saklar, fonksiyon bitince de o fonksiyonun&nbsp;<strong>Stack frame</strong>&lsquo;i Stack segmentinden &ccedil;ıkarılır (pop),&nbsp;<strong>Stack frame</strong>&lsquo;i Fonksiyonun parametrelerinin ve local(yerel) değişkenlerinin t&uuml;m&uuml;n&uuml; i&ccedil;erir.</p>\r\n\r\n<p>&ouml;rneğimize d&ouml;necek olursak Stack segmentini&nbsp;<strong>yığın</strong>&nbsp;halindeki Kitapların t&uuml;m&uuml; olarak,&nbsp;<strong>Stack frame</strong>&lsquo;ini kitap olarak, Kitapın i&ccedil;indeki sayfaları da Fonksiyonun parametreleri, local değişkenleri&hellip;şeklinde d&uuml;ş&uuml;nebiliriz.</p>\r\n\r\n<p>Stack segmentinin kullanım boyutu aktif fonksiyonların(&ccedil;ağrılmış ve bitirilmemiş) sayısı arttık&ccedil;a b&uuml;y&uuml;r ayrıca Stack segmentinin alanı Heap segmentin&rsquo;e kıyasla farklı şekilde otomatik olarak&nbsp;CPU tarafından verimli bir şekilde y&ouml;netilir.</p>\r\n\r\n<h4>Stackoverflow nedir?</h4>\r\n\r\n<p>İlk duyuşunuzda aklınıza&nbsp;<a href=\"https://www.stackoverflow.com/\" rel=\"noreferrer noopener\" target=\"_blank\">https://www.stackoverflow.com</a>&nbsp;sitesi gelmiş olabilir ki sitenin ismi zaten buradan geliyor.</p>\r\n\r\n<p>Stack&rsquo;ın Heap&rsquo;den bir farkı da &ouml;nceden belirlenmiş bir boyutu olmasıdır, yani belirli miktarda veriyi tutabilir. Bu boyut windows&rsquo;ta default olarak 1mb&rsquo;dır, fakat bazı Unix sistemlerinde bu boyut 8mb&rsquo;a kadar &ccedil;ıkabilir.</p>\r\n\r\n<p>Eğer program Stack&rsquo;a bu boyutun kaldırabileceğinden fazla veri koymaya &ccedil;alışırsa&nbsp;<strong>Stackoverflow</strong>&nbsp;durumuyla karşılaşınır, bunu deneyebileceğiniz bir &ouml;rnek kodla g&ouml;sterelim, bu kodu &ccedil;alıştırdığınız zaman programın &ccedil;&ouml;kmesi gerekmekte verilen Stack boyutunu aştığımız i&ccedil;in</p>\r\n\r\n<pre class=\"prettyprint\">\r\nint main()\r\n{\r\n    int stack[10000000];\r\n}\r\n</pre>\r\n\r\n<h4>Stack Avantajları</h4>\r\n\r\n<ul>\r\n	<li>Stack &uuml;zerinde yer ayırtmak Heap &uuml;zerinde yer ayırtmaktan nispeten hızlıdır.</li>\r\n	<li>Y&ouml;netimi nispeten kolaydır</li>\r\n</ul>\r\n\r\n<h4>Stack Dezavantajları</h4>\r\n\r\n<ul>\r\n	<li>Boyutunun belirli bir sınırı olduğu i&ccedil;in sizi sınırlar.</li>\r\n	<li>O anki Stack frame&rsquo;sinde ayırdığın yer o Stack frame&rsquo;sinin i&ccedil;inden ve Stack de kaldığı s&uuml;re boyunca kullanılabilir</li>\r\n</ul>\r\n\r\n<h2>C++ Stack ve Heap &ouml;rnekleri</h2>\r\n\r\n<pre class=\"prettyprint\">\r\nint main()\r\n{ // Stack da main i&ccedil;in bir frame push&#39;landı\r\n   int stackArr[10];// main&#39;in Stack Frame&#39;sinde 10x4 byte lık bir alan ayırttık\r\n} // main&#39;in stack frame&#39;si fonksiyon scope dışına &ccedil;ıktığından dolayı silindi (pop)\r\n</pre>\r\n\r\n<pre class=\"prettyprint\">\r\nint main()\r\n{ \r\n   int* stackArr = new int[10];// Heap de 10x4 bytelık bir alan ayırttık\r\n   // Ayrıc heap de oluşturduğumuz alana erişebilmek i&ccedil;in de Stack da bir pointer oluşturduk\r\n} // Heap de oluşturduğumuz alan silinmedi manuel olarak silmek i&ccedil;in C++ da delete keywordunu kullanmalıyız\r\n</pre>\r\n\r\n<h2>&Ouml;zet:</h2>\r\n\r\n<p>Boyutunun belli ve nispeten k&uuml;&ccedil;&uuml;k olduğu verileri stack da, Boyutunun belli olmadığı ve nispeten b&uuml;y&uuml;k olduğu verileri de heap de saklamaya &ouml;zen g&ouml;sterin.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2021-01-17 13:23:07'),
(7, 'Sızma Testi Nedir? Sızma Testinin Faydaları Nelerdir?', 'm1usty', '<p>Sızma testi, g&uuml;venli değerlendirme i&ccedil;in bir bilgisayar sisteminde ger&ccedil;ekleştirilen yetkilendirilmiş sim&uuml;le edilmiş saldırıdır.&nbsp;<strong><a href=\"https://secromix.com/sizma-testi-nedir.html\" rel=\"noreferrer noopener sponsored\" target=\"_blank\">Sızma testi&nbsp;</a></strong>uzmanları, sistemlerinizdeki zayıflıkların ticari etkilerini bulmak ve g&ouml;stermek i&ccedil;in saldırganlarla aynı ara&ccedil;ları, teknikleri ve s&uuml;re&ccedil;leri kullanır.</p>\r\n\r\n<p><strong><a href=\"https://secromix.com/sizma-testi-nedir.html\" rel=\"noreferrer noopener sponsored\" target=\"_blank\">Sızma testleri</a></strong>&nbsp;genellikle işletmenizi tehdit edebilecek &ccedil;eşitli farklı saldırıları sim&uuml;le eder.&nbsp;<strong>Sızma testi</strong>, bir sistemin kimliği doğrulanmış ve kimliği doğrulanmamış konumların yanı sıra bir dizi sistem rol&uuml;nden gelen saldırılara direnecek kadar sağlam olup olmadığını incelemektedir.&nbsp;</p>\r\n\r\n<h2>Sızma Testinin Faydaları Nelerdir?</h2>\r\n\r\n<p>İdeal bir g&ouml;r&uuml;ş olarak, kuruluşunuz yazılımını ve sistemlerini en başından tehlikeli g&uuml;venlik a&ccedil;ıklarını ortadan kaldırmak amacıyla tasarlamıştır.&nbsp;<strong>Sızma testi</strong>, bu amaca ne kadar iyi ulaştığınıza dair fikir verir.&nbsp;<strong>Sızma testi</strong>,&nbsp;aşağıdaki g&uuml;venlik etkinliklerini destekler&nbsp;&nbsp;:</p>\r\n\r\n<ul>\r\n	<li>Sistemlerdeki zayıflıkları bulmak</li>\r\n	<li>Kontrollerin sağlamlığının belirlenmesi</li>\r\n	<li>Veri gizliliği ve g&uuml;venlik d&uuml;zenlemelerine uyumu desteklemek (&ouml;r.&nbsp;&nbsp;<em>PCI</em>&nbsp;<em>DSS</em>&nbsp;,&nbsp;&nbsp;<em>HIPAA</em>&nbsp;,&nbsp;&nbsp;<em>GDPR</em>&nbsp;)</li>\r\n	<li>Y&ouml;netim i&ccedil;in mevcut g&uuml;venlik durumu ve b&uuml;t&ccedil;e &ouml;nceliklerinin niteliksel ve niceliksel &ouml;rneklerinin sağlanması</li>\r\n</ul>\r\n\r\n<h2>Sızma Testi T&uuml;rleri Nelerdir?</h2>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img alt=\"\" src=\"https://siberci.com/wp-content/uploads/2020/12/sizma-testi-avantajlari.jpg\" style=\"width: 512px; height: 219px;\" /></p>\r\n\r\n<p>Bir&nbsp;<strong>sızma testinin</strong>&nbsp;hedeflerine bağlı olarak, kuruluş test uzmanlarına hedef sistem hakkında &ccedil;eşitli derecelerde bilgi veya erişim sağlar.&nbsp;Bazı durumlarda, sızma testi ekibi başlangı&ccedil;ta bir yaklaşım belirler ve ona bağlı kalır.&nbsp;Diğer zamanlarda, test ekibi,&nbsp;<strong>sızma testi</strong>&nbsp;sırasında sistem hakkındaki farkındalıkları arttık&ccedil;a stratejilerini geliştirir.&nbsp;Sekt&ouml;rde &uuml;&ccedil; t&uuml;r sızma testi vardır. Bunlar:</p>\r\n\r\n<ul>\r\n	<li><strong>Siyah kutu.&nbsp;</strong>&nbsp;Ekip, hedef sistemin i&ccedil; yapısı hakkında hi&ccedil;bir şey bilmez.&nbsp;Bilgisayar korsanlarının yapacağı gibi hareket ederek, dışarıdan istismar edilebilecek herhangi bir zayıflığı araştırırlar.</li>\r\n	<li><strong>Gri kutu.&nbsp;</strong>&nbsp;Ekip, bir veya daha fazla kimlik bilgisi seti hakkında biraz bilgi sahibidir.&nbsp;Ayrıca hedefin dahili veri yapılarını, kodunu ve algoritmalarını da bilirler.&nbsp;Sızma test uzmanları, hedef sistemin mimari diyagramları gibi ayrıntılı tasarım belgelerine dayanarak test senaryoları oluşturabilir.</li>\r\n	<li><strong>Beyaz kutu.&nbsp;</strong>&nbsp;Beyaz kutu testi i&ccedil;in, sızma testi uzmanları sistemlere ve sistem yapılarına erişebilir: kaynak kodu, ikili dosyalar, kapsayıcılar ve hatta bazen sistemi &ccedil;alıştıran sunucular.&nbsp;Beyaz kutu yaklaşımları, en kısa s&uuml;rede en y&uuml;ksek d&uuml;zeyde g&uuml;vence sağlar.</li>\r\n</ul>\r\n\r\n<h3>Sızma Testinin Aşamaları Nedir?</h3>\r\n\r\n<p>Sızma Testi uzmanları, motive olmuş d&uuml;şmanlar tarafından ger&ccedil;ekleştirilen saldırıları sim&uuml;le etmeyi ama&ccedil;lar.&nbsp;Bunu yapmak i&ccedil;in, genellikle&nbsp;aşağıdaki adımları&nbsp;i&ccedil;eren bir planı takip ederler&nbsp;&nbsp;:</p>\r\n\r\n<ul>\r\n	<li><strong>Keşif&nbsp;</strong>&nbsp;Saldırı stratejisini belirlemek i&ccedil;in kamu ve &ouml;zel kaynaklardan hedef hakkında olabildiğince fazla bilgi toplanır.&nbsp;Kaynaklar arasında internet aramaları, alan kaydı bilgilerinin alınması, sosyal m&uuml;hendislik,&nbsp;ağ taraması ve hatta bazen&nbsp;&nbsp;<a href=\"https://en.wikipedia.org/wiki/Dumpster_diving\">dumpster yer alır</a>&nbsp;.&nbsp;Bu bilgiler, sızma testinin hedefin saldırı y&uuml;zeyini ve olası g&uuml;venlik a&ccedil;ıklarını belirlemesine yardımcı olur.&nbsp;<strong>Keşif</strong>, sızma testinin kapsamı ve hedeflerine g&ouml;re değişebilir ve bir sistemin işlevselliğini g&ouml;zden ge&ccedil;irmek i&ccedil;in bir telefon g&ouml;r&uuml;şmesi yapmak kadar basit olabilir.</li>\r\n	<li><strong>Tarama&nbsp;</strong>&nbsp;Sızma testi, hedef web sitesini veya sistemdeki a&ccedil;ık hizmetleri, uygulama g&uuml;venlik sorunları ve a&ccedil;ık kaynak g&uuml;venlik a&ccedil;ıkları dahil olmak &uuml;zere zayıflıkları incelemek i&ccedil;in ara&ccedil;lar kullanır.&nbsp;Sızma testi uzmanları, keşif sırasında ve test sırasında bulduklarına g&ouml;re &ccedil;eşitli ara&ccedil;lar kullanır.</li>\r\n	<li><strong>Erişim&nbsp;</strong>&nbsp;Saldırgan motivasyonları, verileri &ccedil;almaktan, değiştirmekten veya silmekten fonların taşınmasına ve itibarınıza zarar vermeye kadar &ccedil;eşitlilik g&ouml;sterir.&nbsp;Her bir test senaryosunu ger&ccedil;ekleştirmek i&ccedil;in, sızma testi uzmanları ister&nbsp;SQL enjeksiyonu&nbsp;gibi bir zayıflık, ister&nbsp;k&ouml;t&uuml; ama&ccedil;lı yazılım,&nbsp;&nbsp;sosyal m&uuml;hendislik&nbsp;veya başka bir şey&nbsp;yoluyla sisteminize erişim sağlamak i&ccedil;in en iyi ara&ccedil;lara ve tekniklere karar vermelidir&nbsp;&nbsp;.</li>\r\n	<li><strong>Erişimi s&uuml;rd&uuml;rmek.&nbsp;</strong>&nbsp;Sızma testi yapanlar hedefe erişim sağladıktan sonra, sim&uuml;le edilmiş saldırılarının hedeflerine ulaşmak i&ccedil;in yeterince uzun s&uuml;re bağlı kalması gerekir: verileri sızdırmak, değiştirmek veya işlevi k&ouml;t&uuml;ye kullanmak gibi.</li>\r\n</ul>\r\n\r\n<h2>Sızma Testinin Avantajları ve Dezavantajları Nedir?</h2>\r\n\r\n<p>Her ge&ccedil;en yıl artan g&uuml;venlik ihlallerinin sıklığı ve şiddeti ile kuruluşlar, saldırılara karşı savunma modellerine dair daha fazla arayış i&ccedil;indedirler.&nbsp;PCI DSS ve HIPAA gibi d&uuml;zenlemeler, gereksinimlerini g&uuml;ncel tutmak i&ccedil;in periyodik sızma testini zorunlu kılar.&nbsp;Bu zorunlulukları g&ouml;z &ouml;n&uuml;nde bulundurularak, sızma testinin avantajları ve dezavantajları:</p>\r\n\r\n<h3><strong>Sızma testinin Avantajları</strong></h3>\r\n\r\n<ul>\r\n	<li>Otomatikleştirilmiş ara&ccedil;lar, yapılandırma ve kodlama standartları, mimari analiz ve diğer daha hafif g&uuml;venlik a&ccedil;ığı değerlendirme etkinlikleri gibi yukarı akış g&uuml;venlik g&uuml;vencesi uygulamalarındaki boşlukları bulur</li>\r\n	<li>Hem bilinen hem de bilinmeyen yazılım kusurlarını ve g&uuml;venlik a&ccedil;ıklarını, k&uuml;&ccedil;&uuml;k olanlar da dahil olmak &uuml;zere, &ccedil;ok fazla endişe yaratmayacak ancak karmaşık bir saldırı modelinin par&ccedil;ası olarak maddi zarara neden olabilecek ihlalleri bulur</li>\r\n	<li>K&ouml;t&uuml; niyetli bilgisayar korsanlarının &ccedil;oğunun nasıl davranacağını taklit ederek herhangi bir sisteme saldırabilir, ger&ccedil;ek d&uuml;nyadaki bir rakibi olabildiğince taklit edebilir.</li>\r\n</ul>\r\n\r\n<h3><strong><strong>Sızma testinin Dezavantajları</strong></strong></h3>\r\n\r\n<ul>\r\n	<li>Emek yoğun ve maliyetlidir</li>\r\n	<li>Hataların ve ihlallerin 100% &lsquo; n&uuml; engelleyemez.&nbsp;<strong>Fişi &ccedil;ekilene kadar hi&ccedil; bir sistem 100% g&uuml;venli değildir</strong></li>\r\n</ul>\r\n\r\n<p>Kuruluşunuzun olası ihlalleri &ouml;nlemek ve mevcut g&uuml;venlik kontrollerini kalifiye bir saldırgana karşı g&uuml;&ccedil;lendirmek i&ccedil;in&nbsp;<a href=\"https://secromix.com/sizma-testi-nedir.html\" rel=\"noreferrer noopener sponsored\" target=\"_blank\">SecroMix</a>&nbsp;ekibi, &ouml;zel ağ altyapısını ve uygulamalarını hedefleyen &ccedil;ok aşamalı bir saldırı planına dayanan Sızma testi hizmetleri sunmaktadır.</p>\r\n', '2021-01-17 13:26:29');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`) VALUES
(11, 'Kaan Sarımeşinli', 'kaansari@gmail.com', 'kaansari', '$5$rounds=535000$SFGlRO2qb7cSHm2C$whbBDppr7OXG.9ZD4wJlx/uVCFWphjtY.h2KuoIJef4'),
(19, 'ahmet duran', 'ahmet@gmail.com', 'ahmetduran', '$5$rounds=535000$rfn1XxKg9Ts1LfvW$dO3M82K3WL01LX0RrQYvSx9K6ltieXts6ziToz9MiQ5'),
(21, 'Mustafa Sarımeşinli', 'sarimesinlimustafa@gmail.com', 'm1usty', '$5$rounds=535000$NMUXUInd.T57gCGc$cxTicgVbGMT2zegMWTGhmQELhsgrqH5xZVAxAoNe5WC'),
(22, 'Murat Sarımeşinli', 'murat.makina@gmail.com', 'muratsari', '$5$rounds=535000$15QlgvNVxUW8aUyf$EbJLDlPHUhe29Ee1WouQpDFCrCv.DjVre7PXmoJvDh3');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
