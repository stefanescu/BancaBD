-----------Crearea tabelului--------
create table MESAJE_SS (
message_id number primary key,
message varchar2(255), 
message_type varchar2(1),
created_by varchar2(40) not null,
create_at date not null
);

--------adaugarea valorile in comment pentru message_type

comment on column MESAJE_SS.message_type is 'E - Error, W - Warning, I - Information';

---Crearea unei secvente pentru

CREATE SEQUENCE secventa_mesaje
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

-- Creati o functie care pentru angajatul cu numele Dinca va returna salariul acestuia.
 CREATE OR REPLACE FUNCTION f2_angajat_ss
 (v_nume angajat_ss.nume_angajat%TYPE DEFAULT 'Dinca')
RETURN NUMBER IS
 salariu angajat_ss.salariu%type;
 BEGIN
 SELECT salariu INTO salariu
 FROM angajat_ss
 WHERE nume_angajat = v_nume;
 RETURN salariu;
 END f2_angajat_ss;
/
BEGIN
 DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2_angajat_ss);
END;
/

--varianta 2(cand se va introduce de la tastatura numele)

DECLARE
 v_nume angajat_ss.nume_angajat%TYPE:= Initcap('&p_nume');
 FUNCTION f6 RETURN NUMBER IS
 salariu angajat_ss.salariu%type;
 BEGIN
 SELECT salariu INTO salariu
 FROM angajat_ss
 WHERE nume_angajat = v_nume;
 RETURN salariu;
 END f6;
 BEGIN
 DBMS_OUTPUT.PUT_LINE('Salariul este '|| f6);
END;
/




--- Realizati o procedura care pentru un id al ofertei introdus returneaza costul ei.
--varianta 1

DECLARE
 v_id oferta_bancara_ss.id_oferta%TYPE := Initcap('&p_id');

 PROCEDURE p3
 IS
 oferta Oferta_bancara_ss.cost_oferta%TYPE;
 BEGIN
 SELECT cost_oferta INTO oferta
 FROM oferta_bancara_ss
 WHERE id_oferta = v_id;
 
 DBMS_OUTPUT.PUT_LINE('Costul acestei oferte este: '|| oferta);
 end p3;
 BEGIN
 p3;
END;
/
--varianta 2

DECLARE
 v_id oferta_bancara_ss.id_oferta%TYPE := Initcap('&p_id');
 v_cost oferta_bancara_ss.cost_oferta%type;
 PROCEDURE p3(cost OUT oferta_bancara_ss.cost_oferta%type) IS
 BEGIN
 SELECT cost_oferta INTO cost
 FROM oferta_bancara_ss
 WHERE id_oferta = v_id;
  END p3;
BEGIN
 p3(v_cost);
 DBMS_OUTPUT.PUT_LINE('Costul ofertei: '|| v_cost);
END;
/

  --Prin intermediul unui cursor afisati toti angajatii dupa id,nume si adresa.
DECLARE
   c_id angajat_ss.id_angajat%type;
   c_name angajat_ss.nume_angajat%type;
   c_adr angajat_ss.adresa%type;
   CURSOR c_angajat_ss is
      SELECT id_angajat, nume_angajat, adresa FROM angajat_ss;
BEGIN
   OPEN c_angajat_ss;
   LOOP
      FETCH c_angajat_ss into c_id, c_name, c_adr;
      EXIT WHEN c_angajat_ss%notfound;
      dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_adr);
   END LOOP;
   CLOSE c_angajat_ss;
END;
/
---




--Realizati un trigger care pentru angajatul cu id-ul 1 sterge inregistrarea, altfel afisati un mesaj de eroare.
   set serveroutput on;
  CREATE or REPLACE TRIGGER trg1
	AFTER
	DELETE ON Angajat_SS
	FOR EACH ROW
BEGIN
	IF :old.id_angajat = 1 THEN
		raise_application_error(-20015, 'You can t delete this row');
	END IF;
END;
/


/* Realizati un update al salariului angajatilor din sucursala 1, apoi printr-un trigger, aflati: 
salariul nou,salariul vechi, si diferenta salariala.
*/
update angajat_ss 
 set salariu=salariu+6002
 where id_sucursala=1;

set serveroutput on;
create or replace
trigger modificare_salariu
before insert or update on angajat_ss
for each row
when (new.id_angajat>0)
declare
 diferenta_sal number;
 begin 
 diferenta_sal:=:new.salariu-:old.salariu;
 DBMS_OUTPUT.PUT_LINE('salariu vechi : '||:old.salariu);
 DBMS_OUTPUT.PUT_LINE('salariu nou : '||:new.salariu);
 DBMS_OUTPUT.PUT_LINE('diferenta : '||diferenta_sal);
 end;

  -- Declarati un cursor care pentru suma_creditata>8000 si pentru numele creditului UltraBT va pune suma: 15000
declare cursor c1 is  
select durata_credit, id_client
from credit_ss
where suma_creditata>8000; 
inreg c1%rowtype;  
begin
 open c1;
 fetch c1 into inreg;
 if inreg.nume_credit='UltraBT' then
 update credit_ss set suma_creditata=15000;
 end if;
 end;
/;
 -- Creati un cu ajutorul pachetelor un script care adauga si sterge angajati.
CREATE OR REPLACE PACKAGE BODY c_package AS
   PROCEDURE addCustomer(c_id  angajat_ss.id_angajat%type,
      c_name angajat_ss.nume_angajat%type,
      c_addr  angajat_ss.adresa%type, 
      c_sal   angajat_ss.salariu%type)
   IS
   BEGIN
      INSERT INTO angajat_ss(id_angajat,nume_angajat,adresa,salariu)
         VALUES(c_id, c_name, c_addr, c_sal);
   END addCustomer;
  
   PROCEDURE delCustomer(c_id   angajat_ss.id_angajat%type) IS
   BEGIN
       DELETE FROM customers
         WHERE id_angajat = c_id;
   END delCustomer;

   PROCEDURE listCustomer IS
   CURSOR c_angajat_ss is
      SELECT nume_angajat FROM angajat_ss;
   TYPE c_list is TABLE OF angajat_ss.nume_anga%type;
   nume_angajat_list c_list := c_list();
   counter integer :=0;
   BEGIN
      FOR n IN c_angajat_ss LOOP
      counter := counter +1;
      nume_angajat_list.extend;
      nume_angajat_list(counter)  := n.name;
      dbms_output.put_line('Customer(' ||counter|| ')'||nume_angajat_list(counter));
      END LOOP;
   END listCustomer;
/