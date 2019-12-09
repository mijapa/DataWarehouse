--PRODUKT
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."produk_STAGE";
CREATE TABLE STAGINGAREA."produk_STAGE"
( "id_produktu" NUMBER(38) ,
  "model" VARCHAR2(100),
  "marka" VARCHAR2(100),
  "producent" VARCHAR2(100),
  "cena" NUMBER(38) ,
  "rodzaj_produktu" VARCHAR2(50) ,
  "kategoria" VARCHAR2(50) ,
  "opis" VARCHAR2(500),
  "marza_zawarta_w_cenie" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
    INSERT INTO STAGINGAREA."produkt" ("id_produktu", "model", "marka", "producent", "cena", "rodzaj_produktu", "kategoria", "opis", "marza_zawarta_w_cenie")
    SELECT "id_produktu", "model", "marka", "producent", "cena" * (SELECT "kurs_walut"."przelicznik" FROM STAGINGAREA."kurs_walut" WHERE "kurs_walut"."id_kursu" = 2), "rodzaj_produktu", "kategoria", "opis", "marza_zawarta_w_cenie" FROM STAGINGAREA."produk_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."produk_STAGE"';
end;
/

--PROMOCJA
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."promocj_STAGE";
CREATE TABLE STAGINGAREA."promocj_STAGE"
( "id_promocji" NUMBER(38) ,
  "procentowa_wysokosc_rabatu" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
        NOBADFILE
        NODISCARDFILE
        NOLOGFILE
        skip 1
        fields terminated BY ','
            OPTIONALLY ENCLOSED BY '"' AND '"'
            lrtrim
            missing field VALUES are NULL
            ( "id_promocji" CHAR(4000),
            "nazwa_formy_ekspozycji" CHAR(4000),
            "flaga_aktywnego_rabatu" CHAR(4000),
            "procentowa_wysokosc_rabatu" CHAR(4000)
            )
        )
        LOCATION ('dr_exposure.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."promocja" ("id_promocji", "procentowa_wysokosc_rabatu")
    SELECT "id_promocji", "procentowa_wysokosc_rabatu" FROM STAGINGAREA."promocj_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."promocj_STAGE"';
end;
/

--SKLEP
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."skle_STAGE";
CREATE TABLE STAGINGAREA."skle_STAGE"
( "id_sklepu" NUMBER(38) ,
  "kod_pocztowy" VARCHAR2(100) ,
  "ulica" VARCHAR2(100) ,
  "numer_lokalu" VARCHAR2(100) ,
  "miasto" VARCHAR2(100) ,
  "kraj" VARCHAR2(100) ,
  "odleglosc_od_centrum" VARCHAR2(100) ,
  "ilosc_klientow_w_zasiegu" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
        NOBADFILE
        NODISCARDFILE
        NOLOGFILE
        skip 1
        fields terminated BY ','
            OPTIONALLY ENCLOSED BY '"' AND '"'
            lrtrim
            missing field VALUES are NULL
            ( "id_sklepu" CHAR(4000),
            "kod_pocztowy" CHAR(4000),
            "ulica" CHAR(4000),
            "numer_lokalu" CHAR(4000),
            "miasto" CHAR(4000),
            "kraj" CHAR(4000),
            "odleglosc_od_centrum" CHAR(4000),
            "ilosc_klientow_w_zasiegu" CHAR(4000)
            )
        )
        LOCATION ('dr_store.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."sklep" ("id_sklepu", "kraj", "powiat", "wojewodztwo", "miasto", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu")
    SELECT "id_sklepu", "kraj", "kod_pocztowy", "kod_pocztowy", "miasto", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu" FROM STAGINGAREA."skle_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."skle_STAGE"';
end;
/
--MAGAZYN
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."magazy_STAGE";
CREATE TABLE STAGINGAREA."magazy_STAGE"
( "id_sklepu" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) ,
  "czas" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
            "ilosc_sztuk" CHAR(4000),
            "czas" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
            )
        )
        LOCATION ('dr_stored_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."magazyn" ("id_sklepu", "id_produktu", "ilosc_sztuk", "czas")
    SELECT "id_sklepu", "id_produktu", "ilosc_sztuk", "czas" FROM STAGINGAREA."magazy_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."magazy_STAGE"';
end;
/

--EKSPOZYCJA
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."ekspozycj_STAGE";
CREATE TABLE STAGINGAREA."ekspozycj_STAGE"
( "id_ekspozycji" NUMBER(38) ,
  "nazwa_formy_ekspozycji" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
        NOBADFILE
        NODISCARDFILE
        NOLOGFILE
        skip 1
        fields terminated BY ','
            OPTIONALLY ENCLOSED BY '"' AND '"'
            lrtrim
            missing field VALUES are NULL
            ( "id_ekspozycji" CHAR(4000),
            "nazwa_formy_ekspozycji" CHAR(4000),
            "procentowa_wysokosc_rabatu" CHAR(4000)
            )
        )
        LOCATION ('dr_exposure.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."ekspozycja" ("id_ekspozycji", "nazwa_formy_ekspozycji")
    SELECT "id_ekspozycji", "nazwa_formy_ekspozycji" FROM STAGINGAREA."ekspozycj_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."ekspozycj_STAGE"';
end;
/

--PRODUKT_EKSPOZYCJA
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."produkt_ekspozycj_STAGE";
CREATE TABLE STAGINGAREA."produkt_ekspozycj_STAGE"
( "id_ekspozycji" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "data_rozpoczecia" TIMESTAMP ,
  "data_zakonczenia" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
            "data_rozpoczecia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
            "data_zakonczenia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
            )
        )
        LOCATION ('dr_exposure_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."produkt_ekspozycja" ("id_ekspozycji", "id_produktu", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_ekspozycji", "id_produktu", "data_rozpoczecia", "data_zakonczenia" FROM STAGINGAREA."produkt_ekspozycj_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."produkt_ekspozycj_STAGE"';
end;
/

--PRODUKT_PROMOCJA
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."produkt_promocj_STAGE";
CREATE TABLE STAGINGAREA."produkt_promocj_STAGE"
( "id_promocji" NUMBER(38) ,
  "id_produktu" NUMBER(38) ,
  "data_rozpoczecia" TIMESTAMP ,
  "data_zakonczenia" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
        NOBADFILE
        NODISCARDFILE
        NOLOGFILE
        skip 1
        fields terminated BY ','
            OPTIONALLY ENCLOSED BY '"' AND '"'
            lrtrim
            missing field VALUES are NULL
            ( "id_produktu" CHAR(4000),
            "id_promocji" CHAR(4000),
            "data_rozpoczecia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS",
            "data_zakonczenia" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
            )
        )
        LOCATION ('dr_exposure_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."produkt_promocja" ("id_promocji", "id_produktu", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_promocji", "id_produktu", "data_rozpoczecia", "data_zakonczenia" FROM STAGINGAREA."produkt_promocj_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."produkt_promocj_STAGE"';
end;
/

--TRANSAKCJA
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."transakcj_STAGE";
CREATE TABLE STAGINGAREA."transakcj_STAGE"
( "id_transakcji" NUMBER(38) ,
  "id_sklepu" NUMBER(38) ,
  "rodzaj_platnosci" VARCHAR2(10) ,
  "czas" TIMESTAMP )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
            "rodzaj_platnosci" CHAR(4000),
            "czas" CHAR(4000) date_format DATE mask "YYYY-MM-DD:HH24:MI:SS"
            )
        )
        LOCATION ('dr_order.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."transakcja" ("id_transakcji", "id_sklepu", "rodzaj_platnosci", "czas")
    SELECT "id_transakcji", "id_sklepu", "rodzaj_platnosci", "czas" FROM STAGINGAREA."transakcj_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."transakcj_STAGE"';
end;
/

--SPRZEDANY_PRODUKT
SET DEFINE OFF
CREATE TABLE STAGINGAREA."sprzedany_produk_STAGE"
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "ilosc_sztuk" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
            "ilosc_sztuk" CHAR(4000)
            )
        )
        LOCATION ('dr_ordered_product.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."sprzedany_produkt" ("id_produktu", "id_transakcji", "ilosc_sztuk")
    SELECT "id_produktu", "id_transakcji", "ilosc_sztuk" FROM STAGINGAREA."sprzedany_produk_STAGE" ;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."sprzedany_produk_STAGE"';
end;
/

--ZWROT
SET DEFINE OFF
CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'C:\app\zbd\staging-area\DR_STORE_DB_ZBD';
--GRANT READ ON DIRECTORY TEMP_DIR TO USER;
--GRANT WRITE ON DIRECTORY TEMP_DIR TO USER;
drop table STAGINGAREA."zwrot_STAGE";
CREATE TABLE STAGINGAREA."zwrot_STAGE"
( "id_produktu" NUMBER(38) ,
  "id_transakcji" NUMBER(38) ,
  "czas" TIMESTAMP ,
  "ilosc_sztuk" NUMBER(38) )
    ORGANIZATION EXTERNAL
    (  TYPE ORACLE_LOADER
        DEFAULT DIRECTORY TEMP_DIR
        ACCESS PARAMETERS
        (records delimited BY '\r\n'
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
        LOCATION ('dr_return.csv')
        )
        REJECT LIMIT UNLIMITED;

whenever sqlerror exit rollback;
begin
    INSERT INTO STAGINGAREA."zwrot" ("id_produktu", "id_transakcji", "czas", "ilosc_sztuk")
    SELECT "id_produktu", "id_transakcji", "czas", "ilosc_sztuk" FROM STAGINGAREA."zwrot_STAGE" WHERE ROWNUM <= 100;
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE STAGINGAREA."zwrot_STAGE"';
end;
/





