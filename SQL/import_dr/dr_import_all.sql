/*drop table "produkt_STAGE";
drop table "promocja_STAGE";
drop table "sklep_STAGE";
drop table "magazyn_STAGE";
drop table "ekspozycja_STAGE";
drop table "produkt_ekspozycja_STAGE";
drop table "produkt_promocja_STAGE";
drop table "transakcja_STAGE";
drop table "sprzedany_produkt_STAGE";
drop table "zwrot_STAGE";
*/

SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\data';

--PRODUKT
CREATE TABLE "produkt_STAGE"
( "id_produktu" NUMBER(38) ,
  "model" VARCHAR2(100),
  "marka" VARCHAR2(100),
  "producent" VARCHAR2(100),
  "cena" NUMBER(38) ,
  "rodzaj_produktu" VARCHAR2(50) ,
  "kategoria" VARCHAR2(50) ,
  "kraj_produkcji" VARCHAR2(100),
  "opis" VARCHAR2(500),
  "marza_zawarta_w_cenie" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            "model" CHAR(4000),
            "marka" CHAR(4000),
            "producent" CHAR(4000),
            "cena" CHAR(4000),
            "rodzaj_produktu" CHAR(4000),
            "kategoria" CHAR(4000),
            "kraj_produkcji" CHAR(4000),
            "opis" CHAR(4000),
            "marza_zawarta_w_cenie" CHAR(4000)
            )
        )
        LOCATION ('dr_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt" ("id_produktu", "model", "marka", "producent", "cena", "rodzaj_produktu", "kategoria", "opis", "marza_zawarta_w_cenie")
    SELECT "id_produktu", "model", "marka", "producent", "cena" * (select "kurs_walut"."przelicznik" from "kurs_walut" where "id_kursu" = 2), "rodzaj_produktu", "kategoria", "opis", "marza_zawarta_w_cenie" FROM "produkt_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produkt_STAGE"';
end;
/

--PROMOCJA
CREATE TABLE "promocja_STAGE"
( "id_promocji" NUMBER(38) ,
  "opis" VARCHAR2(50),
  "flaga" VARCHAR2(50),
  "procentowa_wysokosc_rabatu" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_promocji" CHAR(4000),
            "opis" CHAR(4000),
            "flaga" CHAR(4000),
            "procentowa_wysokosc_rabatu" CHAR(4000)
            )
        )
        LOCATION ('dr_exposure.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "promocja" ("id_promocji", "procentowa_wysokosc_rabatu")
    SELECT "id_promocji", "procentowa_wysokosc_rabatu" FROM "promocja_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "promocja_STAGE"';
end;
/

--SKLEP
CREATE TABLE "sklep_STAGE"
( "id_sklepu" NUMBER(38) ,
  "kod_pocztowy" VARCHAR2(100) ,
  "ulica" VARCHAR2(100) ,
  "numer_lokalu" NUMBER(38),
  "miasto" VARCHAR2(100) ,
  "kraj" VARCHAR2(100) ,
  "odleglosc_od_centrum" VARCHAR2(100) ,
  "ilosc_klientow_w_zasiegu" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_sklepu" CHAR(4000) ,
            "kod_pocztowy" CHAR(4000) ,
            "ulica" CHAR(4000) ,
            "numer_lokalu" CHAR(4000),
            "miasto" CHAR(4000) ,
            "kraj" CHAR(4000) ,
            "odleglosc_od_centrum" CHAR(4000) ,
            "ilosc_klientow_w_zasiegu" CHAR(4000)
            )
        )
        LOCATION ('dr_store.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "sklep" ("id_sklepu", "wojewodztwo", "powiat", "miasto", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu")
    SELECT "id_sklepu", "kod_pocztowy", "kod_pocztowy", "miasto", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu" FROM "sklep_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "sklep_STAGE"';
end;
/

--MAGAZYN
CREATE TABLE "magazyn_STAGE"
( "id_sklepu" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) ,
  "czas" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_sklepu" CHAR(4000) ,
            "id_produktu" CHAR(4000) ,
            "ilosc_sztuk" CHAR(4000) ,
            "czas" CHAR (4000) date_format DATE mask "YYYY-MM-DD"
            )
        )
        LOCATION ('dr_stored_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "magazyn" ("id_sklepu", "id_produktu", "ilosc_sztuk", "czas")
    SELECT "id_sklepu", "id_produktu", "ilosc_sztuk", "czas" FROM "magazyn_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "magazyn_STAGE"';
end;
/

--EKSPOZYCJA
CREATE TABLE "ekspozycja_STAGE"
( "id_ekspozycji" NUMBER(38) ,
  "opis" VARCHAR2(50),
  "flaga" VARCHAR2(50),
  "procentowa_wysokosc_rabatu" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_ekspozycji" CHAR(4000) ,
            "opis" CHAR(4000),
            "flaga" CHAR(4000),
            "procentowa_wysokosc_rabatu" CHAR(4000)
            )
        )
        LOCATION ('dr_exposure.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "ekspozycja" ("id_ekspozycji", "nazwa_formy_ekspozycji")
    SELECT "id_ekspozycji", "opis" FROM "ekspozycja_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "ekspozycja_STAGE"';
end;
/

--PRODUKT_EKSPOZYCJA
CREATE TABLE "produkt_ekspozycja_STAGE"
( "id_ekspozycji" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "data_rozpoczecia" TIMESTAMP ,
  "data_zakonczenia" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_ekspozycji" CHAR(4000),
            "id_produktu" CHAR(4000),
            "data_rozpoczecia" CHAR(4000) date_format DATE mask "YYYY-MM-DD",
            "data_zakonczenia" CHAR(4000) date_format DATE mask "YYYY-MM-DD"
            )
        )
        LOCATION ('dr_exposure_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt_ekspozycja" ("id_ekspozycji", "id_produktu", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_ekspozycji", "id_produktu", "data_rozpoczecia", "data_zakonczenia" FROM "produkt_ekspozycja_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produkt_ekspozycja_STAGE"';
end;
/

--PRODUKT_PROMOCJA
CREATE TABLE "produkt_promocja_STAGE"
( "id_promocji" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "data_rozpoczecia" TIMESTAMP ,
  "data_zakonczenia" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_promocji" CHAR(4000),
            "id_produktu" CHAR(4000),
            "data_rozpoczecia" CHAR(4000) date_format DATE mask "YYYY-MM-DD",
            "data_zakonczenia" CHAR(4000) date_format DATE mask "YYYY-MM-DD"
            )
        )
        LOCATION ('dr_exposure_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt_promocja" ("id_promocji", "id_produktu", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_promocji", "id_produktu", "data_rozpoczecia", "data_zakonczenia" FROM "produkt_promocja_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produkt_promocja_STAGE"';
end;
/


--TRANSAKCJA
CREATE TABLE "transakcja_STAGE"
( "id_transakcji" NUMBER(38) ,
  "id_sklepu" NUMBER(38) ,
  "rodzaj_platnosci" VARCHAR2(10) ,
  "czas" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_transakcji" CHAR(4000) ,
            "id_sklepu" CHAR(4000) ,
            "rodzaj_platnosci" CHAR(4000) ,
            "czas" CHAR (4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
            )
        )
        LOCATION ('dr_order.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "transakcja" ("id_transakcji", "id_sklepu", "rodzaj_platnosci", "czas")
    SELECT "id_transakcji", "id_sklepu", "rodzaj_platnosci", "czas" FROM "transakcja_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "transakcja_STAGE"';
end;
/

--SPRZEDANY_PRODUKT
CREATE TABLE "sprzedany_produkt_STAGE"
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            "id_transakcji" CHAR(4000) ,
            "ilosc_sztuk" CHAR(4000)
            )
        )
        LOCATION ('dr_ordered_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO "sprzedany_produkt" ("id_produktu", "id_transakcji", "ilosc_sztuk")
    SELECT "id_produktu", "id_transakcji", "ilosc_sztuk" FROM "sprzedany_produkt_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "sprzedany_produkt_STAGE"';
end;
/

--ZWROT
CREATE TABLE "zwrot_STAGE"
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "czas" TIMESTAMP ,
  "ilosc_sztuk" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
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
            ( "id_produktu"  CHAR(4000),
            "id_transakcji"  CHAR(4000),
            "czas" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
            "ilosc_sztuk" CHAR(4000)
            )
        )
        LOCATION ('dr_return.csv')
        )
        REJECT LIMIT UNLIMITED;

select * from "zwrot_STAGE" ;

whenever sqlerror exit rollback;
begin
    INSERT INTO "zwrot" ("id_produktu", "id_transakcji", "czas", "ilosc_sztuk")
    SELECT "id_produktu", "id_transakcji", "czas", "ilosc_sztuk" FROM "zwrot_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "zwrot_STAGE"';
end;
/



