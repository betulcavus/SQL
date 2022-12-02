CREATE DATABASE techproed;

--DDL DATA DEFINITION LANGUAGE
--CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --ondalikli sayilar icin
kayit_tarihi date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
AS --benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin normal tablo olustururkenki parantezler yerine AS kullanip SELECT komutuyla almak istedigimiz verileri aliriz
SELECT isim, soyisim, not_ort FROM ogrenciler;

-- DML DATA MANIPULATION LANGUAGE
-- INSERT - DATABASE'E VERI EKLEME
INSERT INTO ogrenciler VALUES('1234567', 'Said', 'ILHAN', 85.5, now() );
INSERT INTO ogrenciler VALUES('1234567', 'Said', 'ILHAN', 85.5, '2020-12-11' );

--BIR TABLOYA PARCALI VERI EKLEME
INSERT INTO ogrenciler (isim, soyisim) VALUES ('Erol', 'Evren');

--DQL DATA QUERT LANGUAGE
--SELECT
SELECT * FROM ogrenciler; -- * herseyi anlamindadir







