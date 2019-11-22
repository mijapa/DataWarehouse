SET DEFINE OFF
CREATE OR REPLACE DIRECTORY IMPORT AS '/vagrant';

CREATE TABLE "produk_STAGE" 
( "id_produktu" NUMBER(38) ,
  "cena" NUMBER(38) ,
  "marka" VARCHAR2(100),
  "model" VARCHAR2(100),
  "producent" VARCHAR2(100),
  "kategoria" VARCHAR2(50) ,
  "rodzaj_produktu" VARCHAR2(50) ,
  "opis" VARCHAR2(500),
  "marza_zawarta_w_cenie" NUMBER(38) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_produktu" CHAR(4000),
             "cena" CHAR(4000),
             "marka" CHAR(4000),
             "model" CHAR(4000),
             "producent" CHAR(4000),
             "kategoria" CHAR(4000),
             "rodzaj_produktu" CHAR(4000),
             "opis" CHAR(4000),
             "marza_zawarta_w_cenie" CHAR(4000)
           )
       )
     LOCATION ('produkt.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "produk_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "produkt" ("id_produktu", "cena", "marka", "model", "producent", "kategoria", "rodzaj_produktu", "opis", "marza_zawarta_w_cenie") 
  SELECT "id_produktu", "cena" * (select przelicznik from "kurs_walut" where "id_kursu" = 1), "marka", "model", "producent", "kategoria", "rodzaj_produktu", "opis", "marza_zawarta_w_cenie" FROM "produk_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "produk_STAGE"';
end;
/

CREATE TABLE eksopozycja_STAGE 
( "id_reklamy" NUMBER(38),
  "id_produktu" NUMBER(38),
  "data_rozpoczecia" DATE,
  "data_zakonczenia" DATE,
  "rodzaj" VARCHAR2(26),
  "rabat_lub_ekspozycja" NUMBER(38))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 0 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_reklamy" CHAR(4000),
             "id_produktu" CHAR(4000),
             "data_rozpoczecia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
             "data_zakonczenia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
             "rodzaj" CHAR(4000),
             "rabat_lub_ekspozycja" CHAR(4000)
           )
       )
     LOCATION ('reklama.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from eksopozycja_STAGE WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "ekspozycja" ("id_ekspozycji", "nazwa_formy_ekspozycji")
  SELECT "id_reklamy", "rabat_lub_ekspozycja" FROM eksopozycja_STAGE WHERE "rodzaj" LIKE 'ekspozycja';
  COMMIT;
  INSERT INTO "promocja" ("id_promocji", "procentowa_wysokosc_rabatu")
  SELECT "id_reklamy", "rabat_lub_ekspozycja" FROM eksopozycja_STAGE WHERE "rodzaj" LIKE 'promocja';
  COMMIT;
    INSERT INTO "produkt_ekspozycja" ("id_produktu", "id_ekspozycji", "data_rozpoczecia", "data_zakonczenia")
  SELECT "id_produktu", "id_reklamy", "data_rozpoczecia", "data_zakonczenia" FROM eksopozycja_STAGE WHERE "rodzaj" LIKE 'ekspozycja';
  COMMIT;
   INSERT INTO "produkt_promocja" ("id_produktu", "id_promocji", "data_rozpoczecia", "data_zakonczenia")
  SELECT "id_produktu", "id_reklamy", "data_rozpoczecia", "data_zakonczenia" FROM eksopozycja_STAGE WHERE "rodzaj" LIKE 'promocja';
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE eksopozycja_STAGE';
end;
/




CREATE TABLE "skle_STAGE" 
( "id_sklepu" NUMBER(38) ,
  "miasto" VARCHAR2(100) ,
  "odleglosc_od_centrum" VARCHAR2(100) ,
  "ilosc_klientow_w_zasiegu" NUMBER(38) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_sklepu" CHAR(4000),
             "miasto" CHAR(4000),
             "odleglosc_od_centrum" CHAR(4000),
             "ilosc_klientow_w_zasiegu" CHAR(4000)
           )
       )
     LOCATION ('sklep.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "skle_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "sklep" ("id_sklepu", "miasto", "powiat", "wojewodztwo", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu") 
  SELECT "id_sklepu", regexp_substr("miasto", '[^|]+', 1, 1) miasto, regexp_substr("miasto", '[^|]+', 1, 2) powiat, regexp_substr("miasto", '[^|]+', 1, 3) wojewodztwo, regexp_substr("miasto", '[^|]+', 1, 4) kraj, "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu" FROM "skle_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "skle_STAGE"';
end;
/


CREATE TABLE "transakcj_STAGE" 
( "id_transakcji" NUMBER(38) ,
  "id_sklepu" NUMBER(38) ,
  "czas" TIMESTAMP ,
  "rodzaj_platnosci" VARCHAR2(10) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_transakcji" CHAR(4000),
             "id_sklepu" CHAR(4000),
             "czas"  CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
             "rodzaj_platnosci" CHAR(4000)
        )
       )
     LOCATION ('sprzedaz.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "transakcj_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "transakcja" ("id_transakcji", "id_sklepu", "czas", "rodzaj_platnosci") 
  SELECT "id_transakcji", "id_sklepu", "czas", "rodzaj_platnosci" FROM "transakcj_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "transakcj_STAGE"';
end;
/

CREATE TABLE "sprzedany_produk_STAGE" 
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( 
           "id_produktu" CHAR(4000),
           "id_transakcji" CHAR(4000),
             "ilosc_sztuk" CHAR(4000)
           )
       )
     LOCATION ('zakup_produkt.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "sprzedany_produk_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "sprzedany_produkt" ("id_produktu", "id_transakcji", "ilosc_sztuk") 
  SELECT "id_produktu", "id_transakcji", "ilosc_sztuk" FROM "sprzedany_produk_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "sprzedany_produk_STAGE"';
end;
/






CREATE TABLE "zwro_STAGE" 
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "czas" TIMESTAMP ,
  "ilosc_sztuk" NUMBER(38) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_produktu" CHAR(4000),
             "id_transakcji" CHAR(4000),
             "czas" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
             "ilosc_sztuk" CHAR(4000)
           )
       )
     LOCATION ('reklamacja.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "zwro_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "zwrot" ("id_produktu", "id_transakcji", "czas", "ilosc_sztuk") 
  SELECT "id_produktu", "id_transakcji", "czas", "ilosc_sztuk" FROM "zwro_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "zwro_STAGE"';
end;
/

CREATE TABLE "magazy_STAGE" 
( "id_produktu" NUMBER(38) ,
  "id_sklepu" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) ,
  "czas" TIMESTAMP )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_produktu" CHAR(4000),
             "id_sklepu" CHAR(4000),
             "ilosc_sztuk" char(4000),
             "czas" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
           )
       )
     LOCATION ('magazyn.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "magazy_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "magazyn" ("id_produktu", "id_sklepu", "ilosc_sztuk", "czas") 
  SELECT "id_produktu", "id_sklepu", "ilosc_sztuk", "czas" FROM "magazy_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "magazy_STAGE"';
end;
/




CREATE TABLE "skle_STAGE" 
( "id_sklepu" NUMBER(38) ,
  "miasto" VARCHAR2(100) ,
  "odleglosc_od_centrum" VARCHAR2(100) ,
  "ilosc_klientow_w_zasiegu" NUMBER(38) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY IMPORT
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( "id_sklepu" CHAR(4000),
             "miasto" CHAR(4000),
             "odleglosc_od_centrum" CHAR(4000),
             "ilosc_klientow_w_zasiegu" CHAR(4000)
           )
       )
     LOCATION ('sklep.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from "skle_STAGE" WHERE ROWNUM <= 100;

whenever sqlerror exit rollback;
begin
  INSERT INTO "sklep" ("id_sklepu", "miasto", "powiat", "wojewodztwo", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu") 
  SELECT "id_sklepu", regexp_substr("miasto", '[^|]+', 1, 1) miasto, regexp_substr("miasto", '[^|]+', 1, 2) powiat, regexp_substr("miasto", '[^|]+', 1, 3) wojewodztwo, regexp_substr("miasto", '[^|]+', 1, 4) kraj, "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu" FROM "skle_STAGE" ;
  COMMIT;
  EXECUTE IMMEDIATE 'DROP TABLE "skle_STAGE"';
end;
/