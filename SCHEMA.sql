--Stergerea tabelelor existente--
drop table SUCURSALA_SS cascade constraints;
drop table DEPARTAMENT_SS  cascade constraints;
drop table ANGAJAT_SS cascade constraints;
drop table INCASARE_SS cascade constraints;
drop table CLIENT_SS cascade constraints;
drop table CONT_SS cascade constraints;
drop table CREDIT_SS cascade constraints;
drop table SERVICIU_BANCAR_SS cascade constraints;
drop table TRANZACTIE_SS cascade constraints;
drop table CLASAMENT_SS cascade constraints;
drop table ORAS_SS cascade constraints;
drop table OFERTA_BANCARA_SS cascade constraints;
drop table LISTA_OFERTA_BANCARA_SS cascade constraints;

----- CREAREA TABELELOR -- 


--Crearea tabelului Sucursala
Create Table SUCURSALA_SS (
  id_sucursala number(4) PRIMARY KEY not null,
  nume_sucursala varchar2(10) not null,
  sef_sucursala varchar2(20) not null,
  telefon_sucursala number(10) not null
  );
  
--Crearea tabelului Departament
Create Table DEPARTAMENT_SS (
  id_departament number(4) PRIMARY KEY not null,
  denumire_departament varchar2(15) not null,
  telefon_departament number(10) not null,
  email_departament varchar2(15) UNIQUE
  );

--Crearea tabelului Angajat
Create Table ANGAJAT_SS (
  id_angajat number(4) PRIMARY KEY,
  CNP_angajat number (13) UNIQUE,
  nume_angajat varchar2(15) not null,
  prenume_angajat varchar2(15) not null,
  adresa varchar2(15) not null,
  telefon number(10) not null,
  email varchar2(20) UNIQUE,
  data_angajare date not null,
  functia varchar2(10) not null,
  salariu number(7) not null,
  id_departament number(4) references departament_ss(id_departament) not null,
  id_sucursala number(4) references sucursala_ss(id_sucursala) not null
  );


--Crearea tabelului Incasare
Create Table INCASARE_SS (
  id_incasare number(4) PRIMARY KEY not null,
  data_incasare date not null,
  tip_incasare varchar2(10) not null,
  suma varchar2(8) not null,
  id_angajat number(4) references angajat_ss(id_angajat) not null
  );

--Crearea tabelului Client
Create Table CLIENT_SS (
   id_client number(4) PRIMARY KEY not null,
   CNP_client number(13) unique,
   nume_client varchar2(15) not null,
   prenume_client varchar2(15) not null,
   adresa_client varchar2(15) not null,
   telefon_client number(10) not null,
   email_client varchar2(15)
    );

--Crearea tabelului Cont
Create table CONT_SS (
  IBAN varchar2(24) PRIMARY KEY not null,
  tip_cont varchar2(10) not null,
  data_expirare date not null,
  sold number(10) not null,
  id_client number(4) references client_ss(id_client) not null
  );

--Crearea tabelului Credit
Create table CREDIT_SS(
  id_credit number(4) PRIMARY KEY not null,
  tip_credit varchar2(10) not null,
  nume_credit varchar2(10) not null,
  durata_credit varchar2(10) not null,
  suma_creditata number(10) not null,
  id_client number(4) references client_ss(id_client) not null
  );


--Crearea tabelului Serviciu_bancar
Create table SERVICIU_BANCAR_SS(
  id_serviciu number(4) PRIMARY KEY not null,
  nume_serviciu varchar2(15) not null,
  data_expirare_serviciu date not null,
  suma_serviciu number (10) not null,
  id_client number(4) references client_ss(id_client) not null
  );
  
--Crearea tabelului Tranzactie
Create table TRANZACTIE_SS (
  id_tranzactie number(4) PRIMARY KEY not null,
  data_tranzactie date not null,
  tip_tranzactie varchar2(14) not null,
  id_client number(4) references client_ss(id_client) not null,
  id_angajat number(4) references angajat_ss(id_angajat) not null
  );

--Crearea tabelului Clasament
Create table CLASAMENT_SS (
  id_clasament number(4) PRIMARY KEY not null,
  nume_castigator varchar2(15) not null,
  target_ating number(4) not null,
  id_sucursala number(4) references sucursala_ss(id_sucursala) not null
  );

--Crearea tabelului Oras
Create table ORAS_SS(
  id_oras number(4) PRIMARY KEY not null,
  nume_oras varchar2(15) not null,
  numar_sucursale number(2) not null
  );
  
--Crearea tabelului Oferta_bancara
Create table OFERTA_BANCARA_SS (
  id_oferta number(4) PRIMARY KEY not null,
  denumire_oferta varchar2(15) not null,
  beneficiar varchar2(15) not null,
  cost_oferta number(4) not null,
  durata_oferta varchar2(15) not null
  
  );

--Crearea tabelului LIsta_oferta_bancara
Create table LISTA_OFERTA_BANCARA_SS (
  id_lista number(4) PRIMARY KEY not null,
  numar_oferte number(4) not null,
  numar_beneficiari number(4) not null,
  suma_totala number (4) not null,
  id_sucursala number(4) references sucursala_ss(id_sucursala) not null,
  id_oferta number(4) references oferta_bancara_ss(id_oferta) not null
  );
  

-----POPULAREA TABELELOR----

INSERT INTO SUCURSALA_SS VALUES ( 4402, 'Pitesti' , 'Ioana Petrescu' , 0724412511);
INSERT INTO SUCURSALA_SS VALUES (125 , 'Bucuresti1' , 'Alexandru Ion' , 0213606060);
INSERT INTO SUCURSALA_SS VALUES (10, 'Cluj-Babes' , 'Bircea Ionela' , 0744213461);
INSERT INTO SUCURSALA_SS VALUES (441, 'Bacau' , 'Iamandi Costel' , 0744124421);
INSERT INTO SUCURSALA_SS VALUES (12 , 'Iasi', 'Cristina Marinescu' , 02332513141);
INSERT INTO SUCURSALA_SS VALUES (11 , 'Timisoara' , 'Galateanu Ion' , 0766512439);
INSERT INTO SUCURSALA_SS VALUES (1 , 'Cluj' , 'Mircea Voda' , 027541222);
INSERT INTO SUCURSALA_SS VALUES (5, 'Brasov' , 'Marian Stancescu' , 0731456021);
INSERT INTO SUCURSALA_SS VALUES (21, 'Botosani' , 'Leonte Ionut' , 0231323456);
INSERT INTO SUCURSALA_SS VALUES (2 , 'Roman' , 'Mateescu Cristina', 0766555219);

INSERT INTO DEPARTAMENT_SS VALUES ( 66 , 'Tehnic' , 0216202020 , 'tehnic@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 42 , 'Operatiuni' , 0451254620, 'operati@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 62 , 'Contabilitate',0762453222,'contab@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 88 , 'HR',0233256987,'HR@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 54 , 'Auto',0726895451,'auto@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 19 , 'Elecrotehnica',0745698214,'electro@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 23 , 'Judiciar',0756987520,'judiciar@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 55 , 'Notariat',0752147569,'notariat@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 67 , 'Psihologie',0756985231,'psiho@bt.ro');
INSERT INTO DEPARTAMENT_SS VALUES ( 15 , 'Intern',0765897123,'intern@bt.ro');

insert into ANGAJAT_SS values ( 1,1560423231244,'Alexe','Marius','bd Nicolae Rosu',0744242112,'alexe.m@bt.ro','28-SEP-2007','casier',1300,42,11);
insert into ANGAJAT_SS values(2, 2690908382780,'Godeanu','Sorina','bd Unirii','0721323331',' ' ,'14-AUG-2000','Psiholog',2000,67,10);
insert into ANGAJAT_SS values(3, 1890508437296,'Ianculescu','Cristi','Bd Preciziei',0762331442,'cristi.i@bt.ro','01-JAN-2014','IT',4200,66,5);
insert into ANGAJAT_SS values(4, 1930806330793, 'Tomescu', 'Marius','Str Magheru',0331456261,'toma@bt.ro','25-DEC-2013','sofer',900,54,5);
insert into ANGAJAT_SS values(5, 2789245694224, 'Stamatoiu', 'Ioana','Str Uverturii',0753222134 ,'ioana.s@bt.ro','05-APR-1999','avocat',4000,23,11);
insert into ANGAJAT_SS values(6, 2549243565423,'Marinica','Doina','Bd I Creanga',0762341231,'intern@bt.ro','01-JAN-1992','presedinte',9000,15,1);
insert into ANGAJAT_SS values(7, 1874321536676,'Cristescu','Ion','Baneasa',0754212432,'cristescu@bt.ro','03-AUG-2005','casier',1300,42,11);
insert into ANGAJAT_SS values(8, 1925431456546, 'Vaideanu' , 'Alex', 'bd Ghencea',0223213765,'alex.v@bt.ro','06-SEP-2009','notar',3200,55,2);
insert into ANGAJAT_SS values(9, 2543654743241, 'Dinca','Corina','Bd Preciziei',0761252312,'corina.d@bt.ro','09-AUG-2000','admin',10000,15,1);
insert into ANGAJAT_SS values(10,2354362212356,'Alexe','Mariana','Bd Kisselef',0316202020,'Alexe.m@bt.ro','21-FEB-2001','HR',1500,88,441);

insert into INCASARE_SS values(215,'12-SEP-2014','Lei',5000,1);
insert into INCASARE_SS values(1,'06-AUG-2002','Euro',400,5);
insert into INCASARE_SS values(544,'07-DEC-2014','Lei',9000,9);
insert into INCASARE_SS values(201,'29-JAN-2009','Lire',876,6);
insert into INCASARE_SS values(190,'12-JAN-2010','Euro',4500,1);
insert into INCASARE_SS values(14,'29-MAR-2000','Lire',9980,7);
insert into INCASARE_SS values(76,'30-AUG-2009','Euro',300,9);
insert into INCASARE_SS values(54,'24-MAY-2008','Lei',6500,4);
insert into INCASARE_SS values(500,'09-DEC-2014','Euro',540,2);
insert into INCASARE_SS values(212,'05-FEB-2009','Lire',5433,1);

insert into CLIENT_SS values(710,1402994250291,'Andrei','Andrei','str. Targului',0754221231,' ');
insert into CLIENT_SS values(110,2728402859211,'Tanase','Ioana','str. Baraolt',0739069483,'ioana.t@gt.ro');
insert into CLIENT_SS values(432,1294728496023,'Tugui','Ion','str. Abrud',0745028510,' ');
insert into CLIENT_SS values(54,1921886590284,'Florea','Andrei','str. Calinesti',0233123434,' ');
insert into CLIENT_SS values(1,2402994250291,'Andreescu','Cristina-Ioana','str. Negoiu',0765431241,' ');
insert into CLIENT_SS values(543,1920582947325,'Florea','Florin','str. Lavitei',0763214235,' ');
insert into CLIENT_SS values(20,1628375029584,'Paraschiv','Ionel','str. Sadului',0733213444, 'par.i@gsp.ro');
insert into CLIENT_SS values(12,1728402859211,'Ionescu','Sorin','str. Eclipsei',0763221321,' ');
insert into CLIENT_SS values(154,2929472849623,'Kedih','Sorana','str. Acvila',0754554443,'kedih@gsp.ro');
insert into CLIENT_SS values(144,1924582618294,'Petrescu','Cristi','str. Baciului',0721332424,' ');

insert into CONT_SS values('ROBTRL567554598988323221','lei','11-JAN-2007',0,154); 
insert into CONT_SS values('ROBTRL456456475684363543','lei','11-FEB-2014',222,20);
insert into CONT_SS values('ROBTRL546542432421436798','Euro','01-MAY-2002',10,1); 
insert into CONT_SS values('ROBTRLt46547b65464553532','lei','11-JAN-2000',92434,543);
insert into CONT_SS values('ROBTRL543657889685743322','Euro','09-SEP-1993',1340,12);
insert into CONT_SS values('ROBTRL867868679909090988','lei','20-MAY-2008',0,710);
insert into CONT_SS values('ROBTRL765734324141113243','lei','23-MAY-2002',1120,110);
insert into CONT_SS values('ROBTRL654652353464324242','euro','20-MAY-2008',1240,432);
insert into CONT_SS values('ROBTRL575789099090998765','lire','20-AUG-2008',56670,144);

 insert into CREDIT_SS values(14,'lei','UltraBT','20ani','9992',144);
 insert into CREDIT_SS values(1,'lei','JuniorST','3ani','942',432);
 insert into CREDIT_SS values(15,'Lire','BTSTAR','5ani','214',12);
 insert into CREDIT_SS values(20,'Euro','ClasicBT','15ani','2010',110);
 insert into CREDIT_SS values(145,'lire','VIPBT','1an','200',710);
 insert into CREDIT_SS values(1443,'lei','UBT','5luni','10',543);
 insert into CREDIT_SS values(1444,'lei','UltraBT','20ani','54362',1);
 insert into CREDIT_SS values(141,'lei','UltraBT','20ani','9432',154);
 insert into CREDIT_SS values(2435,'lei','BTAgent','30ani','20000',20);
 
insert into SERVICIU_BANCAR_SS values (43,'INTERNETBank','15-APR-2014','20',1);
insert into SERVICIU_BANCAR_SS values (12,'SMSAlert','15-JAN-2014','15',154);
insert into SERVICIU_BANCAR_SS values (4,'Asigurare','10-JAN-2015','2022',1);
insert into SERVICIU_BANCAR_SS values (45,'INTERNETBank','15-SEP-014','20',110);
insert into SERVICIU_BANCAR_SS values (47,'CARDVIP','10-APR-2015','20',710);
insert into SERVICIU_BANCAR_SS values (123,'CARDCUMP','23-AUG-2004','205',154);
insert into SERVICIU_BANCAR_SS values (431,'INTERNETBank','29-SEP-2023','2054',543);
insert into SERVICIU_BANCAR_SS values (22,'Asigurare','01-JAN-2054','95433',12);
insert into SERVICIU_BANCAR_SS values (4345,'CardVip','15-APR-2019','20534',1);

insert into TRANZACTIE_SS values( 21, '15-MAR-2007','Lei',154,1);
insert into TRANZACTIE_SS values( 221, '11-JAN-2000','Euro',710,9);
insert into TRANZACTIE_SS values( 6121, '23-AUG-2004','Lei',154,1);
insert into TRANZACTIE_SS values( 1, '06-AUG-2002','Lire',1,5);
insert into TRANZACTIE_SS values( 54, '29-MAR-2000','Lei',432,6);
insert into TRANZACTIE_SS values(111, '15-MAR-2006','Euro',154,7);
insert into TRANZACTIE_SS values( 31, '16-JAN-2001','Lei',543,3);
insert into TRANZACTIE_SS values( 42, '23-MAR-2005','Lei',12,3);
insert into TRANZACTIE_SS values( 765, '30-SEP-2006','Euro',1,1);
insert into TRANZACTIE_SS values( 6542, '01-FEB-2007','Lei',154,2);

insert into CLASAMENT_SS values (10,'Lupulescu Alin',110,441);
insert into CLASAMENT_SS values (1,'Stamatoiu Ioana',100,12);
insert into CLASAMENT_SS values (42,'Cristescu Vali',100,5);
insert into CLASAMENT_SS values (654,'Lupu Alina',80,125);
insert into CLASAMENT_SS values (102,'Marinica Doina',98,12);
insert into CLASAMENT_SS values (1432,'Ion Anca',150,1);
insert into CLASAMENT_SS values (321,'Voicu Alex',70,5);
insert into CLASAMENT_SS values (1321,'Trasca Alex',134,11);
insert into CLASAMENT_SS values (1000,'Lupulescu Alin',120,441);
insert into CLASAMENT_SS values (12,'Voicu Alina',92,2);
 
insert into  ORAS_SS values( 12, 'Alexandria',4);
insert into  ORAS_SS values( 2, 'Calarasi',65);
insert into  ORAS_SS values( 1, 'Iasi',14);
insert into  ORAS_SS values( 123, 'Botosani',3);
insert into  ORAS_SS values( 10, 'Bacau',34);
insert into  ORAS_SS values( 15, 'Constanta',19);
insert into  ORAS_SS values( 121, 'Piatra-Neamt',22);
insert into  ORAS_SS values( 124, 'Ploiesti',1);
insert into  ORAS_SS values( 125, 'Bucuresti',68);
insert into  ORAS_SS values( 22, 'Pitesti',44);

insert into OFERTA_BANCARA_SS values (43, '2in1','Costel Ion',21,'2ani');
insert into OFERTA_BANCARA_SS values (21,'DepozitStudent','Aurelian Paun',43,' ');
insert into OFERTA_BANCARA_SS values (65,'DepozitSimplu','Dinca Alex',200,'5ani');
insert into OFERTA_BANCARA_SS values (873,'PrimaCasa','Panait Alina', 1100,'16ani');
insert into OFERTA_BANCARA_SS values (201,'Offshore','Cristea Paul',540,'6luni');
insert into OFERTA_BANCARA_SS values (254,'Actiuni BT','Sham Tim',9000,'anual');
insert into OFERTA_BANCARA_SS values (1,'Triple Play','Kim Wiston',100,'2ani');
insert into OFERTA_BANCARA_SS values (2411,'CardAvantaj','Popescu Alice',43,' ' );
insert into OFERTA_BANCARA_SS values (543,'DepozitVIP','Howard Walkin',6855,' ');
insert into OFERTA_BANCARA_SS values (7652,'Allbusiness','SC. ABC SRL',9989,'1luna');


insert into LISTA_OFERTA_BANCARA_SS values (41,15,44,993,4402,2411);
insert into LISTA_OFERTA_BANCARA_SS values (15,543,21,9584,1,1);
insert into LISTA_OFERTA_BANCARA_SS values (1,1,1,9989,125,7652);
insert into LISTA_OFERTA_BANCARA_SS values (21,4,21,2100,4402,1);
insert into LISTA_OFERTA_BANCARA_SS values (543,90,4,2000,21,543);
insert into LISTA_OFERTA_BANCARA_SS values (14,100,8,8800,12,873);
insert into LISTA_OFERTA_BANCARA_SS values (165,943,15,3000,1,65);
insert into LISTA_OFERTA_BANCARA_SS values (50,2,290,900,4402,43);
insert into LISTA_OFERTA_BANCARA_SS values (53,15,2,2200,441,873);
