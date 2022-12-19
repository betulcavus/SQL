--HAVING CLAUSE

/*  WHERE                                           HAVING
              FİLTRELEME YAPAR
ON FİLRE                                        SON FILTRE
SATIRLARI FILTRELER                             GRUPLRI FILTRELER
AGGREGATE FONK İLE KULLANILMAZ-                 KULLANILIR
GROUP BY İF.DEN ONCE KULLANILIR                 GROUP BY IF.SONRA KULLANILIR  
SELECT, UPDATE, DELETE +                        SADECE SELECT ILE KULLANILIR
                                                1- GROUP BY  2- AGGREGATE FONK
*/
												
CREATE table KISILER(
id int,
isim varchar(30),
soyisim varchar(30),
yas int,
sehir varchar(20),
cinsiyet char(1),
ulke varchar(30),
maas int)

insert into kisiler values(1, 'Ahmet', 'Yilmaz', 20, 'Ankara', 'E', 'Turkiye',  2000);
insert into kisiler values(2, 'Mehmet', 'Efe', 22, 'Bolu', 'E', 'Turkiye',  2000);
insert into kisiler values(3, 'Ayse', 'Can', 23, 'Istanbul', 'K', 'Turkiye',  3500);
insert into kisiler values(4, 'Fatma', 'Ak', 35, 'Ankara', 'K', 'Turkiye',  3200);
insert into kisiler values(5, 'John', 'Smith', 45, 'New York', 'E', 'USA',  3500);
insert into kisiler values(6, 'Ellen', 'Smith', 40, 'New York', 'K', 'USA',  3500);
insert into kisiler values(7, 'Hans', 'Muller', 30, 'Berlin', 'E', 'Almanya',  4000);
insert into kisiler values(8, 'Frank', 'Cesanne', 35, 'Paris', 'E', 'Fransa',  3700);
insert into kisiler values(9, 'Abbas', 'Demir', 26, 'Adana', 'E', 'Turkiye',  2000);
insert into kisiler values(10, 'Hatice', 'Topcu', 26, 'Hatay', 'K', 'Turkiye',  2200);
insert into kisiler values(11, 'Gulsum', 'Demir', 35, 'Adana', 'K', 'Turkiye',  2000);

SELECT ulke, AVG(maas) FROM kisiler GROUP BY ulke

--1.YASI 30dan buyuk olan kısılerın ulkelere gore maas ort
SELECT ulke, AVG(maas) FROM kisiler WHERE yas > 30 GROUP BY ulke

--2.YAS ort 30dan buyuk olan ulkeler
SELECT ulke FROM kisiler GROUP BY ulke HAVING AVG(yas) > 30

--3.turkiyede olanların sehirlere gore toplam yas
select ulke, sehir, sum(yas) from kisiler group by ulke, sehir having ulke='Turkiye'
select ulke, sehir, sum(yas) from kisiler where ulke='Turkiye' group by ulke, sehir

--4.sehırlere gore yas ort 30dan cok olan sehırler
select sehir, avg(yas) from kisiler group by sehir having avg(yas)>30

--5.toplam maası 5000den fazla olan sehırler
select sehir, sum(maaas) from kisiler group by sehir having sum(maas)>10000

--6.sehir ve cinsiyete gore gruplandırıp yas ort 30dan cok olan gruplar
select sehir, cinsiyet from kisiler group by sehir, cinsiyet having avg(yas)>30

--7.cinsiyet ve ulkelere gore maas ort 3500den cok olanlar
select avg(maas), ulke, cinsiyet from kisiler group by ulke, cinsiyet having avg(maas)>3500

--8.yas ort 30dan buyuk ulkelerın ulke isimlerini WWW yap
UPDATE kisiler SET ulke='WWW'
where ulke in (select ulke from kisiler group by ulke HAVING avg(yas)<30 )

select * from kisiler
--tabloyu eski haline donduruyoruz

--9.çalışan sayısı 1’den fazla olan şehirleri ve çalışan sayılarını getiren sorguyu yazalım
select sehir, count (*) as calısan from kisiler group by sehir having count(*)>1;
--burada count icine herhangı bır sutunu koyabılırız

--10.Maaş ortalaması 3000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke, avg(maas) from kisiler where cinsiyet='E'
group by ulke having avg(maas)>3000

--11.Erkek çalışanların sayısı 1’den fazla olan ülkelerin maaş ortalamasını getiren sorgu:
SELECT ulke, AVG(maaş) FROM kisiler WHERE Cinsiyet='E' GROUP BY ulke HAVING COUNT(*) > 1