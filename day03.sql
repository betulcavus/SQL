CREATE TABLE ogrenciler5
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler5 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler5 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler5 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler5 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler5;

--Veli ismi Hasan olan datayi sil
DELETE FROM ogrenciler5 WHERE veli_isim='Hasan';

--TRUNCATE
--BIR TABLODAKI TUM VERILERI GERI ALINMAYACAK SEKILDE SILER. SARTLI SILME YAPMAZ
TRUNCATE ogrenciler5

--ON DELETE CASCADE
--Tablo varsa tabloyu siler. normalde oncelikle  childdaki datayi silmemiz gerekir.
--child da on delete cascade kullanirsak... parent'dan datayi silebiliriz.
--bu durumda data hem parenttan hemde childdan silinir.
DROP TABLE IF EXISTS adresler

CREATE TABLE talebeler ( 
id CHAR(3) primary key, 
isim VARCHAR(50), 
veli_isim VARCHAR(50),
yazili_notu int 
);

CREATE TABLE notlar1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar1 VALUES ('123','kimya',75);
INSERT INTO notlar1 VALUES ('124', 'fizik',65);
INSERT INTO notlar1 VALUES ('125', 'tarih',90);
INSERT INTO notlar1 VALUES ('126', 'Matematik',90);

SELECT * FROM talebeler;
SELECT * FROM notlar1;

--Notlar tablosundan talebe_id'si 123 olan datayi sil
DELETE FROM notlar1 WHERE talebe_id='123';

--Talebeler tablosundan id'si 126 olan datayi sil
DELETE FROM talebeler WHERE id='126';

--IN CONDITION
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Musteriler tablosunda urun ismi orange, apple veya apricot olanlari listele
SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--Bunu IN condition ile yaparsak kod daha kisa olur
SELECT * FROM musteriler WHERE urun_isim IN('Orange', 'Apple', 'Apricot');

--NOT IN - Yazdigimiz verilerin disindakileri getirir
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange', 'Apple', 'Apricot');

--BETWEEN CONDITION
--Musteriler tablosunda id'si 20 ile 40 arasinda olan tum veriler listele
SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40

SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;

--SUNQUERIES - SORGU ICINDE SORGU
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM calisanlar2;
SELECT * FROM markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim, maas, isyeri FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

--Marka id'si 101 den buyuk olan marka calisanlarinin isim maas ve sehirlerini listele
SELECT isim, maas, sehir FROM calisanlar2 WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);

--AGGREGATE METHOD
SELECT MAX(maas) FROM calisanlar2;
--Eger bir sutuna gecici olarak bir isim vermek istersek as komutunu yazdiktan sonra vermek istedigimiz ismi yazariz

--Calisanlar tablosundan minimum maasi listele
SELECT MIN(maas) AS en_dusuk_maas FROM calisanlar2

--Calisanlar tablosundaki maaslarin toplamini listele
SELECT SUM(maas) FROM calisanlar2

--Calisanlar tablosundaki maaslarin ort'sini listele
SELECT AVG(maas) FROM calisanlar2 
SELECT round (AVG(maas), 2) FROM calisanlar2

--Calisanlar tablosundaki maas'larin sayisini listele
SELECT COUNT (maas) AS maas_sayisi FROM calisanlar2
SELECT COUNT (*) AS maas_sayisi FROM calisanlar2
--Eger count(*) kullanirsak tablodaki tum satirlarin sayisini verir
--sutun adi kullanirsak o sutundaki sayilari verir

--AGGREGATE METHODLARDA SUBQUERY
--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id, marka_isim, 
(SELECT COUNT (sehir) AS sehir_sayisi FROM calisanlar2 WHERE marka_isim=isyeri) 
FROM markalar;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
CREATE view summaas
as
SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as toplam_maas
FROM markalar

SELECT * FROM summaas;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
From markalar

--VIEW KULLANIMI
CREATE VIEW maxminmaas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
From markalar;

SELECT * FROM maxminmaas;

-- EXİSTS CONDITION
CREATE TABLE mart(   
urun_id int,    
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan (   
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart
select * from nisan

/*
--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
*/
SELECT urun_id,musteri_isim FROM mart
WHERE exists (SELECT urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id)

/*
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)

--DML - UPDATE
CREATE TABLE tedarikciler( -- parent
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler( -- child
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler
select * from urunler

--vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
/*
UPDATE tablo_adi
SET sutun_ismi = 'istenen veri' WHERE sutun_ismi='istenen veri'
*/
UPDATE tedarikciler
SET firma_ismi = 'Vestel' WHERE vergi_no=102;

--vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler
SET firma_ismi = 'Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101

--urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler
SET urun_isim = 'Telefon' WHERE urun_isim='Phone';

--urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler
SET urun_id = urun_id + 1 WHERE urun_id>1004;

--urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler
SET urun_id = urun_id + ted_vergino
DELETE FROM urunler

--urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci  tablosunda irtibat_ismi 
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
UPDATE urunler                      
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')                       
WHERE musteri_isim='Ali Bak';                      

--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
UPDATE urunler                      
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi='Apple')                     
WHERE urun_isim='Laptop'