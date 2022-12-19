--SQL EXISTS condition
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE musteriler
(
  id int, 
  isim varchar(50), 
  sehir varchar(50), 
  yas int
);

INSERT INTO musteriler VALUES(100, 'Ahmet Ümit', 'İstanbul', 54);
INSERT INTO musteriler VALUES(101, 'R.Nuri Güntekin', 'Antalya', 18);
INSERT INTO musteriler VALUES(102, 'S.Faik Abasıyanık', 'Bursa', 14);
INSERT INTO musteriler VALUES(103, 'Yaşar Kemal', 'İstanbul', 26);
INSERT INTO musteriler VALUES(104, 'Halide E. Adıvar', 'İzmir', 35);
INSERT INTO musteriler VALUES(105, 'Nazan Bekiroğlu', 'İzmir', 42);
INSERT INTO musteriler VALUES(106, 'Peyami Safa', 'Antalya', 33);
INSERT INTO musteriler VALUES(107, 'Sabahattin Ali', 'İstanbul', 41);
INSERT INTO musteriler VALUES(108, 'Oğuz Atay', 'İstanbul', 28);
INSERT INTO musteriler VALUES(109, 'Orhan Pamuk', 'Ankara', 30);

CREATE TABLE siparisler
(
  id int, 
  musteri_id int, 
  urun_adi varchar(20), 
  tutar int
);

INSERT INTO siparisler VALUES(3001,109, 'kitap',100);
INSERT INTO siparisler VALUES(3002,101, 'kitap',230);
INSERT INTO siparisler VALUES(3003,109, 'defter',100);
INSERT INTO siparisler VALUES(3004,102, 'kalem',80);
INSERT INTO siparisler VALUES(3005,101, 'çanta',550);
INSERT INTO siparisler VALUES(3006,109, 'çanta',440);
INSERT INTO siparisler VALUES(3007,103, 'kitap',160);
INSERT INTO siparisler VALUES(3008,103, 'kalem',75);
INSERT INTO siparisler VALUES(3009,105, 'defter',250);
INSERT INTO siparisler VALUES(3010,108, 'kitap',300);
INSERT INTO siparisler VALUES(3011,106, 'kitap',175);
INSERT INTO siparisler VALUES(3012,109, 'kalem',105);
INSERT INTO siparisler VALUES(3013,107, 'defter',145);

SELECT * FROM siparisler;
SELECT * FROM musteriler;

--1)Siparişlerde defter varsa müşterilerin isim ve şehirlerini listeleyiniz.
--yoksa

SELECT isim, sehir FROM musteriler 
WHERE EXISTS (SELECT * FROM siparisler WHERE urun_adi='defter' )--not exists

--2)Siparişlerde tutarı 600 den büyük sipariş varsa 
--müşterilerin yaş ortalamasını bul .

SELECT AVG(yas) FROM musteriler
WHERE EXISTS (SELECT * FROM siparisler s WHERE tutar>600 )  

--3)Siparişi olan müşterileri listeleyiniz.(ilişkili)

SELECT * FROM musteriler m
WHERE EXISTS (SELECT musteri_id FROM siparisler s WHERE s.musteri_id=m.id )

--(IN kullanımı)

SELECT * FROM musteriler m
WHERE musteri_id IN (SELECT musteri_id FROM siparisler s WHERE s.musteri_id=m.id )

--4)Siparişi olmayan müşterileri listeleyiniz.(ilişkili)

SELECT * FROM musteriler m
WHERE NOT EXISTS (SELECT * FROM siparisler s WHERE s.musteri_id=m.id )

--5)Müşterilerden yaşı 18 den küçük varsa siparişini sil.(ilişkili)

DELETE FROM siparisler s WHERE EXISTS 
(SELECT * FROM musteriler m WHERE yas<18 and m.id=s.musteri_id)

SELECT * FROM siparisler

--6)İstanbulda yaşayan müşteri varsa müşteri_id , sipariş verdiği ürün adı
-- ve tutarı listeleyiniz.

SELECT musteri_id, urun_adi, tutar
FROM siparisler s
WHERE EXISTS
(SELECT * FROM musteriler m WHERE m.id=s.musteri_id and sehir='İstanbul')

SELECT musteri_id, urun_adi, tutar
FROM siparisler s
WHERE musteri_id IN 
(SELECT musteri_id FROM musteriler m WHERE m.id=s.musteri_id and sehir='İstanbul')

--7)İstanbulda yaşayan müşteri varsa sipariş tutarından 50 br indirim
--yapınız ve tüm siparişleri listeleyiniz.

UPDATE siparisler s SET tutar=(tutar-50)
WHERE EXISTS (SELECT * FROM musteriler m WHERE m.id=s.musteri_id and sehir='İstanbul')

SELECT * FROM siparisler

--8)Çanta siparişi veren müşteri varsa isminin yanına * işareti koyunuz ve 
--tüm müşterileri listeleyiniz.

UPDATE musteriler m SET isim='*' || isim
WHERE EXISTS (SELECT * FROM siparisler s WHERE s.musteri_id=m.id AND urun_adi='çanta' )

SELECT * FROM musteriler

--BONUS--Toplam sipariş tutarı 500 den fazla olan müşterileri listeleyiniz.(ilişkili)

SELECT * FROM musteriler m
WHERE EXISTS
(SELECT sum(tutar) FROM siparisler s WHERE s.musteri_id=m.id GROUP BY musteri_id HAVING sum(tutar)>500)