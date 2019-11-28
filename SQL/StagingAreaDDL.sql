CREATE TABLE "transakcja" (
  "id_transakcji" numeric NOT NULL PRIMARY KEY,
  "rodzaj_platnosci" VARCHAR2(10) NOT NULL,
  "czas" timestamp NOT NULL,
  "id_sklepu" numeric NOT NULL
);

CREATE TABLE "promocja" (
  "id_promocji" numeric NOT NULL PRIMARY KEY,
  "procentowa_wysokosc_rabatu" numeric NOT NULL
);

CREATE TABLE "produkt" (
  "id_produktu" numeric NOT NULL PRIMARY KEY,
  "cena" numeric NOT NULL,
  "marza_zawarta_w_cenie" numeric NOT NULL,
  "marka" varchar2(100),
  "model" varchar2(100),
  "producent" varchar2(100),
  "kategoria" varchar2(50) NOT NULL,
  "rodzaj_produktu" varchar2(50) NOT NULL,
  "opis" varchar2(500)
);

CREATE TABLE "magazyn" (
  "id_produktu" numeric NOT NULL,
  "id_sklepu" numeric NOT NULL,
  "czas" timestamp NOT NULL,
  "ilosc_sztuk" numeric NOT NULL,
  PRIMARY KEY("id_sklepu", "id_produktu")
);

CREATE TABLE "sklep" (
  "id_sklepu" numeric NOT NULL PRIMARY KEY,
  "miasto" varchar2(100) NOT NULL,
  "powiat" varchar2(100) NOT NULL,
  "wojewodztwo" varchar2(100) NOT NULL,
  "kraj" varchar2(100) NOT NULL,
  "odleglosc_od_centrum" varchar2(100) NOT NULL,
  "ilosc_klientow_w_zasiegu" numeric NOT NULL
);

CREATE TABLE "sprzedany_produkt" (
  "id_transakcji" numeric NOT NULL,
  "id_produktu" numeric NOT NULL,
  "ilosc_sztuk" numeric NOT NULL,
  PRIMARY KEY("id_transakcji", "id_produktu")
);

CREATE TABLE "produkt_promocja" (
  "id_produktu" numeric NOT NULL,
  "id_promocji" numeric NOT NULL,
  "data_rozpoczecia" TIMESTAMP NOT NULL,
  "data_zakonczenia" timestamp NOT NULL,
  Primary key("id_produktu", "id_promocji")
);

CREATE TABLE "produkt_ekspozycja" (
  "id_produktu" numeric NOT NULL,
  "id_ekspozycji" numeric NOT NULL,
  "data_rozpoczecia" TIMESTAMP NOT NULL,
  "data_zakonczenia" TIMESTAMP NOT NULL,
  Primary key("id_produktu", "id_ekspozycji")
);

CREATE TABLE "ekspozycja" (
  "id_ekspozycji" numeric NOT NULL PRIMARY KEY,
  "nazwa_formy_ekspozycji" numeric NOT NULL
);

CREATE TABLE "zwrot" (
  "id_produktu" numeric NOT NULL,
  "id_transakcji" numeric NOT NULL,
  "czas" timestamp NOT NULL,
  "ilosc_sztuk" numeric NOT NULL,
  Primary key("id_produktu", "id_transakcji")
);

ALTER TABLE "zwrot" ADD FOREIGN KEY ("id_transakcji") REFERENCES "transakcja" ("id_transakcji");

ALTER TABLE "zwrot" ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt" ("id_produktu");

ALTER TABLE "produkt_ekspozycja" ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt" ("id_produktu");

ALTER TABLE "produkt_ekspozycja" ADD FOREIGN KEY ("id_ekspozycji") REFERENCES "ekspozycja" ("id_ekspozycji");

ALTER TABLE "produkt_promocja" ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt" ("id_produktu");

ALTER TABLE "produkt_promocja" ADD FOREIGN KEY ("id_promocji") REFERENCES "promocja" ("id_promocji");

ALTER TABLE "magazyn" ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt" ("id_produktu");

ALTER TABLE "magazyn" ADD FOREIGN KEY ("id_sklepu") REFERENCES "sklep" ("id_sklepu");

ALTER TABLE "sprzedany_produkt" ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt" ("id_produktu");

ALTER TABLE "transakcja" ADD FOREIGN KEY ("id_sklepu") REFERENCES "sklep" ("id_sklepu");

ALTER TABLE "sprzedany_produkt" ADD FOREIGN KEY ("id_transakcji") REFERENCES "transakcja" ("id_transakcji");

CREATE TABLE "kurs_walut"
(
    "id_kursu"    NUMBER(10, 0),
	"waluta_z" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"waluta_do" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"przelicznik" NUMBER(12,6) NOT NULL ENABLE, 
	 PRIMARY KEY ("id_kursu")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

insert into "kurs_walut"
("id_kursu", "waluta_z", "waluta_do", "przelicznik")
values 
(0, 'PLN', 'EUR', 4);

insert into "kurs_walut"
("id_kursu", "waluta_z", "waluta_do", "przelicznik")
values 
(1, 'CZK', 'EUR', 1);

insert into "kurs_walut"
("id_kursu", "waluta_z", "waluta_do", "przelicznik")
values 
(2, 'JPY', 'EUR', 4);