CREATE TABLE ogrenciler(
ogrenci_no char(7), 
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarihi date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE notlar
AS  
SELECT isim, not_ort FROM ogrenciler;

SELECT * FROM notlar;

--INSERT - TABLO ICINE VERI EKLEME
INSERT INTO notlar VALUES('Betul', 75.5);
INSERT INTO notlar VALUES('Fero', 75.5);
INSERT INTO notlar VALUES('Kerem', 75.5);
INSERT INTO notlar VALUES('Sevde', 75.5);
INSERT INTO notlar VALUES('Ayse', 75.5);
INSERT INTO notlar VALUES('Sezer', 75.5);

--CONSTRAINT
--UNIQUE
CREATE TABLE ogrencilerYeni(
ogrenci_no char(7) UNIQUE, 
isim varchar(20) NOT null,
soyisim varchar(25),
not_ort real, 
kayit_tarihi date
);

INSERT INTO ogrencilerYeni VALUES('1234567', 'Betul', 'Cavus', 75.5, now() );
INSERT INTO ogrencilerYeni VALUES('1234587', 'Ali', 'Veli', 75.5, now() );
INSERT INTO ogrencilerYeni (ogrenci_no, soyisim, not_ort) VALUES ('1234569', 'Cavus', 76.5); --not null kisitlamasi oldugu icin bu veri eklenemedi

SELECT * FROM ogrencilerYeni;

--PRIMARY KEY ATAMASI
CREATE TABLE ogrenciler2(
ogrenci_no char(7) PRIMARY KEY, 
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarihi date
);

--PRIMARY KEY ATAMASI IKINCI YOL
CREATE TABLE ogrenciler3(
ogrenci_no char(7), 
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarihi date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no) --veya PRIMARY KEY(ogrenci_no)	
);

--FOREIGN KEY
/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
CREATE TABLE tedarikciler3(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)	
);

CREATE TABLE urunler(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)	
);

SELECT * FROM tedarikciler3;

SELECT * FROM urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar(
id varchar(5) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date 	
);

CREATE TABLE adresler(
adres_id varchar(5), 
sokak varchar(15),
cadde varchar(15),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)	
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --unique cons oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --not null cons oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --unique cons oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --olmaz
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --primary key ikinci hicligi kabul etmedi unique olmali
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --primary key

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep'); --Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;

SELECT * FROM adresler;

--CHECK CONSTRAINT 
CREATE TABLE calisanlar1(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000),
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');

--DQL - WHERE KULLANIMI
SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;

--calisanlar tablosunda maas'i 5000'den buyuk olan isimleri listele
SELECT isim, maas FROM calisanlar WHERE maas>5000;

--calisanlar tablosunda ismi 'Veli Han' olan tum veriyi listele
SELECT * FROM calisanlar WHERE isim='Veli Han';

--calisanlar tablosunda maas'i 5000 olan tum verileri listele
SELECT * FROM calisanlar WHERE maas=5000;

--DML - DELETE KULLANIMI
DELETE FROM calisanlar; --eger parent table baska bir child table ile iliskili ise once child table silinmeli
DELETE FROM adresler;

--adresler tablosundan sehri Antep olan verileri sil
DELETE FROM adresler WHERE sehir='Antep';

CREATE TABLE ogrenciler4
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler4 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler4 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler4 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler4 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler4 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler4 VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
DELETE FROM ogrenciler4 WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';
