/*======================== SET OPERATORLERI: UNION, UNION ALL==========================
    
UNION: İKİ VEYA DAHA FAZLA SORGU İFADESİNİN SONUC KUMELERİNİ BİRLEŞTİREREK 
TEK BİR SONUC KUMESİ OLUSTURUR.
   
    	   UNION:         SADECE BENZERSİZ VERİLERİ ALIR 

           UNION ALL:     BENZERLİ VERİLERİ DE ALIR
 
    Syntax:
    ----------
    SELECT sutun_adi FROM tablo_adi;
    UNION
    SELECT sutun_adi FROM tablo_adi;
    
NOT: Birlesik olan olan Sorgu ifadesinin veri türü diger sorgulardaki 
ifadelerin veri türü ile uyumlu olmalidir.
======================================================================================*/ 

CREATE TABLE personel 
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
INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'Istanbul', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
select * from personel;
    
/* -----------------------------------------------------------------------------
  SORU1: maas'i 4000’den cok olan personel isim'lerini ve  
--maas'i 5000’den cok olan sehir'leri gosteren tekrarsız sorguyu yaziniz
------------------------------------------------------------------------------*/

select maas, isim from personel where maas>4000

union

select maas, sehir from personel where maas>5000;

/* -----------------------------------------------------------------------------
  SORU2: isim'i 'Mehmet Ozturk' olan kisilerin aldigi maas'lari  ve  
--sehir'i 'Istabul' olan personelin maas'larini tekrarsız
--büyükten küçüge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.    
------------------------------------------------------------------------------*/  

select maas, isim as isim_sehir from personel where isim = 'Mehmet Ozturk'

union

select maas, sehir from personel where sehir = 'Istanbul'

order by maas desc;




/* -----------------------------------------------------------------------------
  SORU3: sirket'i 'Honda', 'Ford' ve 'Tofas' olan personelin isim'ini tekrarsız listeleyin
------------------------------------------------------------------------------*/  

select isim, sirket from personel where sirket='Honda'

union

select isim, sirket from personel where sirket='Ford'

union

select isim, sirket from personel where sirket='Tofas'

select isim, sirket from personel where sirket in ('Honda', 'Tofas', 'Ford');

/* -----------------------------------------------------------------------------
  SORU4: 5000’den az maas alan personelin isim, maas ve sirket bilgileri ile, 
-- 'Honda' calisani olmayan personelin isim, maas, sirket bilgilerini
-- tekrarsız listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 

select isim, maas, sirket from personel where maas<5000

union

select isim, maas, sirket from personel where sirket != 'Honda';

/* -----------------------------------------------------------------------------
  SORU5: isim'i 'Mehmet Ozturk' olanlarin isim'lerini, sehir'lerini ve
-- sehir'i 'Istanbul' olmayanların isim'lerini sehir'lerini tekrarsız listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/

select isim, sehir from personel where isim ='Mehmet Ozturk'

union

select isim, sehir from personel where sehir != 'Istanbul';