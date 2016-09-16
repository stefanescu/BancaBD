----- 15 interogari----
----1. Sa se afiseze salariul maxim al angajatilor din fiecare departament---
SELECT ID_DEPARTAMENT
       ,MAX(salariu) SALARIU_MAXIM
FROM ANGAJAT_SS
GROUP BY id_departament;

--2. Sa se afiseze denumirea ofertei mai mari de 1 an cu costul cel mai mic--

select p.denumire_oferta
from OFERTA_BANCARA_SS p
where durata_oferta>'1an'
and 
p.cost_oferta=(select min(cost_oferta) 
from OFERTA_BANCARA_SS); 


/*3. Angajatii cu id-ul 1,5,7 lucreaza la IBM, MICROSOFT, respectiv HP. Sa se atribuie pentru ei companiile, iar pentru restul compania BT daca
salariul este mai mare ca 3200.*/

SELECT nume_angajat,
DECODE(id_angajat , 1, 'IBM',
                    5, 'Microsoft',
                    7, 'Hewlett Packard',
                    'BT') AS FIRMA
FROM ANGAJAT_SS
where salariu>3200;

-- 4. Sa se ordoneze in ordine crescatoare dupa durata si suma, toate creditele mai mari cu 1200.--

select durata_credit,nume_credit,suma_creditata
 from CREDIT_SS
 where suma_creditata> 1200
 order by durata_credit,suma_creditata;
 
 --5. Sa se afiseze numarul tranzactiilor in euro pentru clientul 1.
 SELECT tip_tranzactie, COUNT(*) AS "Numarul tranzactiilor in euro:"
FROM TRANZACTIE_SS
WHERE tip_tranzactie = 'Euro' and id_client=1
GROUP BY tip_tranzactie;

/*6. Sa se afiseze numarul zilelor si a lunilor pentru fiecare angajat. De asemenea pentru angajatii care s-au angajat inainte
de 21-feb-2001 sa li se atribuie "veteran", celor intre 22-FEB-2001 si 30-SEP-2009 "Angajat" iar restul "perioada test"*/

select round(months_between(sysdate,data_angajare)) as "numar luni", round(sysdate-data_angajare) as "numar zile",
case when data_angajare <='21-FEB-01' then 'Veteran'
     when data_angajare between '22-FEB-2001' and '30-SEP-2009' then 'Angajat'
     else  'In Perioada de Testare'
    end as "tipul"
from ANGAJAT_SS;

--7. Afisati primii 6 clienti in ordine descrescatoare dupa suma creditata.

select id_client,durata_credit,suma_creditata
from ( select id_client, durata_credit,suma_creditata
      from CREDIT_SS 
      order by suma_creditata desc ) 
where rownum<=6;


--8. Facand o corelare intre tabelul client si cont determinati id-ul clientul care mai are 1340 euro in cont.

SELECT id_client
FROM CLIENT_SS a
WHERE EXISTS
(SELECT *
FROM CONT_SS d
WHERE d.sold = 1340 
AND EXISTS 
(SELECT *
FROM CONT_SS b
WHERE d.sold = b.sold AND b.id_client = a.id_client));

--9 Afisati ofertele care nu s-au vandut.

select d.id_oferta
from OFERTA_BANCARA_SS d
where d.id_oferta 
not in 
( select c.id_oferta
from LISTA_OFERTA_BANCARA_SS c 
where c.id_oferta=d.id_oferta);
                             
--10. Folosind NVL si SUM calculati suma totala a tuturor ofertelor cumparate.

SELECT SUM (NVL(SUMA_TOTALA,100)) 
AS SUMA_Oferte_cumparate
FROM LISTA_OFERTA_BANCARA_SS;

--11. Afisati salariul impreuna cu numarul de angajati care au acelasi salariu, dar care este mai mic de 49000.

SELECT salariu, COUNT(*) AS "Numarul Angajatilor"
FROM ANGAJAT_SS
WHERE salariu< 49500
GROUP BY salariu
HAVING COUNT(*) >1;

--12. Afisati numele si salariul angajatului care are salariul cat media salariilor.

select e.nume_angajat, e.salariu
 from   ANGAJAT_SS e
where  e.salariu >(select avg(x.salariu)
                   from   ANGAJAT_SS x
                where  x.nume_angajat= e.nume_angajat);
            
--13. Sa se determine numele si prenumele angajatului care a facut cele mai multe tranzactii.
select a.nume_angajat, a.prenume_angajat
from ANGAJAT_SS a,TRANZACTIE_SS s
where a.id_angajat=s.id_angajat
group by  a.nume_angajat, a.prenume_angajat
having count(s.id_angajat)=(select max(count(s.id_angajat))
                             from TRANZACTIE_SS  s
                             group by s.id_angajat);
                             
--14 Sa sa gaseasca id-ul creditului pentru clientul cu identificatorul 1.

SELECT a.id_credit, a.id_client
FROM CREDIT_SS a, CLIENT_SS b
WHERE a.id_credit = b.id_client 
AND b.id_client=1;

--15 Sa se determine numele si prenumele clientului cu creditul cel mai mare.

select a.nume_client,a.prenume_client
from Client_SS a,CREDIT_SS c
where a.id_client=c.id_client and c.id_credit=( select id_credit
                                                  from CREDIT_SS
                                                  where suma_creditata= (select max(suma_creditata)
                                                                from CREDIT_SS));
