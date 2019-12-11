SET DEFINE OFF
CREATE OR REPLACE DIRECTORY Stage AS '/vagrant';
--GRANT READ ON DIRECTORY Stage TO stagingarea;
--GRANT WRITE ON DIRECTORY Stage TO stagingarea;
--drop table "ekspozycj_STAG";
CREATE TABLE "ekspozycj_STAG"
(
    "id_ekspozycji"          NUMBER(38),
    "nazwa_formy_ekspozycji" NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
        ACCESS PARAMETERS
        (records delimited BY '\n'
        BADFILE Stage:'bad.bad'
        DISCARDFILE Stage:'dis.dis'
        LOGFILE Stage:'log.log'
        skip 1
        fields terminated BY ','
            OPTIONALLY ENCLOSED BY '"' AND '"'
            lrtrim
            missing field VALUES are NULL
            ( "id_ekspozycji" CHAR (4000),
            "nazwa_formy_ekspozycji" CHAR (4000)
            )
        )
        LOCATION ('ekspozycjaMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "ekspozycj_STAG"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    MERGE INTO "ekspozycja" eksp
    USING (
        SELECT "id_ekspozycji", "nazwa_formy_ekspozycji"
        FROM "ekspozycj_STAG"
        where "id_ekspozycji" is not null
          and "nazwa_formy_ekspozycji" is not null) stag
    on (stag."id_ekspozycji" = eksp."id_ekspozycji")
    when not matched then
        insert ("id_ekspozycji", "nazwa_formy_ekspozycji")
        values (stag."id_ekspozycji", stag."nazwa_formy_ekspozycji");
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "ekspozycj_STAG"';
end ;
/

--drop table "produk_STAGE";
CREATE TABLE "produk_STAGE"
(
    "id_produktu"           NUMBER(38),
    "opis"                  VARCHAR2(500),
    "producent"             VARCHAR2(100),
    "marka"                 VARCHAR2(100),
    "model"                 VARCHAR2(100),
    "rodzaj_produktu"       VARCHAR2(50),
    "kategoria"             VARCHAR2(50),
    "cena"                  NUMBER(38),
    "marza_zawarta_w_cenie" NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stagg
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
            ( "id_produktu" CHAR (4000),
            "opis" CHAR (4000),
            "producent" CHAR (4000),
            "marka" CHAR (4000),
            "model" CHAR (4000),
            "rodzaj_produktu" CHAR (4000),
            "kategoria" CHAR (4000),
            "cena" CHAR (4000),
            "marza_zawarta_w_cenie" CHAR (4000)
            )
        )
        LOCATION ('produktMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "produk_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt" ("id_produktu", "opis", "producent", "marka", "model", "rodzaj_produktu", "kategoria", "cena",
                           "marza_zawarta_w_cenie")
    SELECT "id_produktu",
           "opis",
           "producent",
           "marka",
           "model",
           "rodzaj_produktu",
           "kategoria",
           "cena" *
           (SELECT STAGINGAREA."kurs_walut"."przelicznik"
            from STAGINGAREA."kurs_walut"
            where "waluta_z" like 'PLN'
              and "id_kursu" = 0),
           "marza_zawarta_w_cenie"
    FROM "produk_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produk_STAGE"';
end;
/

--drop table "skle_STAGE";
CREATE TABLE "skle_STAGE"
(
    "id_sklepu"                NUMBER(38),
    "miasto"                   VARCHAR2(100),
    "powiat"                   VARCHAR2(100),
    "wojewodztwo"              VARCHAR2(100),
    "kraj"                     VARCHAR2(100),
    "odleglosc_od_centrum"     VARCHAR2(100),
    "ilosc_klientow_w_zasiegu" NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_sklepu" CHAR (4000),
            "miasto" CHAR (4000),
            "powiat" CHAR (4000),
            "wojewodztwo" CHAR (4000),
            "kraj" CHAR (4000),
            "odleglosc_od_centrum" CHAR (4000),
            "ilosc_klientow_w_zasiegu" CHAR (4000)
            )
        )
        LOCATION ('sklepMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "skle_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "sklep" ("id_sklepu", "miasto", "powiat", "wojewodztwo", "kraj", "odleglosc_od_centrum",
                         "ilosc_klientow_w_zasiegu")
    SELECT "id_sklepu", "miasto", "powiat", "wojewodztwo", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu"
    FROM "skle_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "skle_STAGE"';
end;
/

--drop table "transakcj_STAGE";
CREATE TABLE "transakcj_STAGE"
(
    "id_transakcji"    NUMBER(38),
    "id_sklepu"        NUMBER(38),
    "czas"             TIMESTAMP,
    "rodzaj_platnosci" VARCHAR2(10),
    "id_kasy"          NUMBER(38),
    "id_pracownika"    NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_transakcji" CHAR (4000),
            "id_sklepu" CHAR (4000),
            "czas" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS",
            "rodzaj_platnosci" CHAR (4000),
            "id_kasy" CHAR (4000),
            "id_pracownika" CHAR (4000)
            )
        )
        LOCATION ('zakupMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "transakcj_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "transakcja" ("id_transakcji", "id_sklepu", "czas", "rodzaj_platnosci")
    SELECT "id_transakcji", "id_sklepu", "czas", "rodzaj_platnosci"
    FROM "transakcj_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "transakcj_STAGE"';
end;
/

--drop table "promocj_STAGE";
CREATE TABLE "promocj_STAGE"
(
    "id_promocji"                NUMBER(38),
    "procentowa_wysokosc_rabatu" NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_promocji" CHAR (4000),
            "procentowa_wysokosc_rabatu" CHAR (4000)
            )
        )
        LOCATION ('promocjaMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "promocj_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "promocja" ("id_promocji", "procentowa_wysokosc_rabatu")
    SELECT "id_promocji", "procentowa_wysokosc_rabatu"
    FROM "promocj_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "promocj_STAGE"';
end;
/

--drop table "produkt_promocj_STAGE";
CREATE TABLE "produkt_promocj_STAGE"
(
    "id_produktu"      NUMBER(38),
    "id_promocji"      NUMBER(38),
    "data_rozpoczecia" TIMESTAMP,
    "data_zakonczenia" TIMESTAMP
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_produktu" CHAR (4000),
            "id_promocji" CHAR (4000),
            "data_rozpoczecia" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS",
            "data_zakonczenia" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS"
            )
        )
        LOCATION ('produkt_promocjaMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "produkt_promocj_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt_promocja" ("id_produktu", "id_promocji", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_produktu", "id_promocji", "data_rozpoczecia", "data_zakonczenia"
    FROM "produkt_promocj_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produkt_promocj_STAGE"';
end;
/

--drop table "produkt_ekspozycj_STAGE";
CREATE TABLE "produkt_ekspozycj_STAGE"
(
    "id_produktu"      NUMBER(38),
    "id_ekspozycji"    NUMBER(38),
    "data_rozpoczecia" TIMESTAMP,
    "data_zakonczenia" TIMESTAMP
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_produktu" CHAR (4000),
            "id_ekspozycji" CHAR (4000),
            "data_rozpoczecia" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS",
            "data_zakonczenia" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS"
            )
        )
        LOCATION ('produkt_ekspozycjaMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "produkt_ekspozycj_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "produkt_ekspozycja" ("id_produktu", "id_ekspozycji", "data_rozpoczecia", "data_zakonczenia")
    SELECT "id_produktu", "id_ekspozycji", "data_rozpoczecia", "data_zakonczenia"
    FROM "produkt_ekspozycj_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "produkt_ekspozycj_STAGE"';
end;
/

--drop table "sprzedany_produk_STAGE";
CREATE TABLE "sprzedany_produk_STAGE"
(
    "id_transakcji" NUMBER(38),
    "id_produktu"   NUMBER(38),
    "ilosc_sztuk"   NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_transakcji" CHAR (4000),
            "id_produktu" CHAR (4000),
            "ilosc_sztuk" CHAR (4000)
            )
        )
        LOCATION ('zakup_produktMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "sprzedany_produk_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "sprzedany_produkt" ("id_transakcji", "id_produktu", "ilosc_sztuk")
    SELECT "id_transakcji", "id_produktu", "ilosc_sztuk"
    FROM "sprzedany_produk_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "sprzedany_produk_STAGE"';
end;
/

--drop table "zwro_STAGE";
CREATE TABLE "zwro_STAGE"
(
    "id_produktu"   NUMBER(38),
    "id_pracownika" NUMBER(38),
    "czas"          TIMESTAMP,
    "id_kasy"       NUMBER(38),
    "id_transakcji" NUMBER(38),
    "ilosc_sztuk"   NUMBER(38)
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_produktu" CHAR (4000),
            "id_pracownika" CHAR (4000),
            "czas" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS",
            "id_kasy" CHAR (4000),
            "id_transakcji" CHAR (4000),
            "ilosc_sztuk" CHAR (4000)
            )
        )
        LOCATION ('reklamacjaMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "zwro_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "zwrot" ("id_produktu", "czas", "id_transakcji", "ilosc_sztuk")
    SELECT "id_produktu", "czas", "id_transakcji", "ilosc_sztuk"
    FROM "zwro_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "zwro_STAGE"';
end;
/

--drop table "magazy_STAGE";
CREATE TABLE "magazy_STAGE"
(
    "id_sklepu"   NUMBER(38),
    "id_produktu" NUMBER(38),
    "ilosc_sztuk" NUMBER(38),
    "czas"        TIMESTAMP
)
    ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY Stage
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
            ( "id_sklepu" CHAR (4000),
            "id_produktu" CHAR (4000),
            "ilosc_sztuk" CHAR (4000),
            "czas" CHAR (4000) date_format TIMESTAMP mask "YYYY-MM-DD HH24:MI:SS"
            )
        )
        LOCATION ('magazynMP.csv')
        )
        REJECT LIMIT UNLIMITED;

select *
from "magazy_STAGE"
WHERE ROWNUM <= 5;

whenever sqlerror exit rollback;
begin
    INSERT INTO "magazyn" ("id_sklepu", "id_produktu", "ilosc_sztuk", "czas")
    SELECT "id_sklepu", "id_produktu", "ilosc_sztuk", "czas"
    FROM "magazy_STAGE";
    COMMIT;
    EXECUTE IMMEDIATE 'DROP TABLE "magazy_STAGE"';
end;
/

