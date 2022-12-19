/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN'a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
	ORDER BY sutun_adı        İNT==>KÜÇÜKTEN BÜYÜGE  STRİNG==>A-Z
	ORDER BY sutun_adı DESC   İNT==>BÜYÜKTEN KÜÇÜGE  STRİNG==>Z-A
==============================================================================*/   

CREATE TABLE meslekler
(
id int PRIMARY KEY,
isim VARCHAR(50), 
soyisim VARCHAR(50),
meslek CHAR(9),
maas int
);
    	
INSERT INTO meslekler VALUES(1, 'Ali', 'Can', 'Doktor', '20000' );
INSERT INTO meslekler VALUES(2, 'Veli', 'Cem', 'Mühendis', '18000');
INSERT INTO meslekler VALUES(3, 'Mine', 'Bulut', 'Avukat', '17000');
INSERT INTO meslekler VALUES(4, 'Mahmut', 'Bulut', 'Ögretmen', '15000');
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13000');
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000');
INSERT INTO meslekler VALUES(7, 'Ali', 'Can', 'Marangoz', '10000' );
INSERT INTO meslekler VALUES(8, 'Veli', 'Cem', 'Tekniker', '14000');

select * from meslekler;

-- SORU1: meslekler tablosunu meslek'e göre sıralayarak sorgulayınız.
select * from meslekler order by meslek;
	
-- SORU2: meslekler tablosunda maas'i buyukten kucuge siralayiniz
select * from meslekler order by maas desc;

-- SORU3: meslekler tablosunda maas'i kucukten buyuge siralayiniz
select * from meslekler order by maas;

-- SORU4: meslekler tablosunda isim'i 'Mine' olanları,
-- maas'a göre büyükten küçüge sıralayarak sorgulayınız
select * from meslekler where isim='Mine' order by maas desc;

-- SORU5: meslekler tablosunda soyisim 'i 'Can' olanları,
-- maas sıralı olarak sorgulayınız.
select * from meslekler where soyisim='Can' order by maas;

-- SORU6: meslekler tablosunda maası en yüksek 5 kişinin bilgilerini listeleyiniz
select * from meslekler order by maas desc limit 5;

-- SORU7: meslekler tablosunda en yüksek maaşı alan 3. 4. 5. 6. kişilerin bilgilerini listele
select * from meslekler order by maas desc offset 2 limit 4 ;

CREATE TABLE magaza 
(
    isim varchar(30), 
    urun_adi varchar(20), 
    urun_miktari int 
);
    
INSERT INTO magaza VALUES( 'Hasan', 'Terlik', 3);
INSERT INTO magaza VALUES( 'Cihan', 'Kazak', 8);
INSERT INTO magaza VALUES( 'Ahmet', 'Gömlek', 9);
INSERT INTO magaza VALUES( 'Hasan', 'Terlik', 2);
INSERT INTO magaza VALUES( 'Said', 'Kazak', 3);
INSERT INTO magaza VALUES( 'Said', 'Gömlek', 6);

select * from magaza;

--SORU1: Satılan urun_adi'na göre gruplandırarak,
--satılan max urun_miktari'nı ve min urun_miktari'nı, 
--min urun_miktari'na göre sıralayarak listeleyiniz   

select urun_adi, max(urun_miktari) as max, min(urun_miktari) as min from magaza group by urun_adi order by min ;

--SORU2: Kisi isim'ine ve urun_adi' na göre  gruplandırarak,
--satılan urun_miktari'nın toplamını, 
--isim'e göre sıralayan sorguyu yazınız

select isim, urun_adi, sum(urun_miktari) from magaza group by isim, urun_adi order by isim ;

CREATE TABLE kisiler 
(
	id int  PRIMARY KEY, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	sirket VARCHAR(20)
);
   
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'istanbul', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
SELECT * FROM personel;
    
/* -----------------------------------------------------------------------------
  SORU1: isim'i 'Mehmet Ozturk' olan kisinin maas'larini + 
  sehir'i 'Istanbul' olan kisinin maas'larini
  büyükten küçüge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.    
------------------------------------------------------------------------------*/  

select maas, isim as isim_sehir from kisiler where isim = 'Mehmet Ozturk'
union
select maas, sehir from kisiler where sehir = 'Istanbul'
order by maas desc;