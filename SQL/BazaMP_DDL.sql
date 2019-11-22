CREATE TABLE "produktMP" (
  "id" numeric(10) PRIMARY KEY,
  "nazwa" varchar2(100),
  "producent" varchar2(100),
  "marka" varchar2(100),
  "model" varchar2(100),
  "rodzaj" varchar2(100),
  "kategoria" varchar2(100),
  "cena" numeric(10,2),
  "marza_zawarta" numeric(10,2)
);

CREATE TABLE "zakupMP" (
  "id" numeric(10) PRIMARY KEY,
  "sklepID" numeric(10),
  "data" timestamp,
  "typ_platnosci" varchar2(100),
  "kasaID" numeric(10),
  "pracownikID" numeric(10)
);

CREATE TABLE "sklepMP" (
  "id" numeric(10) PRIMARY KEY,
  "miasto" varchar2(100) NOT NULL,
  "powiat" varchar2(100) NOT NULL,
  "wojewodztwo" varchar2(100) NOT NULL,
  "kraj" varchar2(100) NOT NULL,
  "odleglosc_od_centrum" varchar2(100) NOT NULL,
  "ilosc_klientow_w_zasiegu" numeric(10) NOT NULL
);

CREATE TABLE "reklamacjaMP" (
  "produktID" numeric(10),
  "pracownikID" numeric(10),
  "data" timestamp,
  "kasaID" numeric(10),
  "zakupID" numeric(10),
  "ilosc" numeric(10),
  PRIMARY KEY ("produktID", "zakupID")
);

CREATE TABLE "magazynMP" (
  "sklepID" numeric(10),
  "produktID" numeric(10),
  "ilosc" numeric(10),
  "czas" timestamp,
  PRIMARY KEY ("sklepID", "produktID")
);

CREATE TABLE "zakup_produktMP" (
  "zakupID" numeric(10),
  "produktID" numeric(10),
  "ilosc" numeric(10),
  PRIMARY KEY ("zakupID", "produktID")
);

CREATE TABLE "produkt_ekspozycjaMP" (
  "produktID" numeric(10),
  "ekspozycjaID" numeric(10),
  "data_rozpoczecia" timestamp NOT NULL,
  "data_zakonczenia" timestamp NOT NULL,
  PRIMARY KEY ("produktID", "ekspozycjaID")
);

CREATE TABLE "ekspozycjaMP" (
  "id" numeric(10) PRIMARY KEY,
  "nazwa_formy_ekspozycji" numeric(10) NOT NULL
);

CREATE TABLE "produkt_promocjaMP" (
  "produktID" numeric(10),
  "promocjaID" numeric(10),
  "data_rozpoczecia" timestamp NOT NULL,
  "data_zakonczenia" timestamp NOT NULL,
  PRIMARY KEY ("produktID", "promocjaID")
);

CREATE TABLE "promocjaMP" (
  "id" numeric(10) PRIMARY KEY,
  "procentowa_wysokosc_rabatu" numeric(10) NOT NULL
);

ALTER TABLE "zakupMP" ADD FOREIGN KEY ("sklepID") REFERENCES "sklepMP" ("id");

ALTER TABLE "reklamacjaMP" ADD FOREIGN KEY ("produktID") REFERENCES "produktMP" ("id");

ALTER TABLE "reklamacjaMP" ADD FOREIGN KEY ("zakupID") REFERENCES "zakupMP" ("id");

ALTER TABLE "magazynMP" ADD FOREIGN KEY ("sklepID") REFERENCES "sklepMP" ("id");

ALTER TABLE "magazynMP" ADD FOREIGN KEY ("produktID") REFERENCES "produktMP" ("id");

ALTER TABLE "zakup_produktMP" ADD FOREIGN KEY ("zakupID") REFERENCES "zakupMP" ("id");

ALTER TABLE "zakup_produktMP" ADD FOREIGN KEY ("produktID") REFERENCES "produktMP" ("id");

ALTER TABLE "produkt_ekspozycjaMP" ADD FOREIGN KEY ("produktID") REFERENCES "produktMP" ("id");

ALTER TABLE "produkt_ekspozycjaMP" ADD FOREIGN KEY ("ekspozycjaID") REFERENCES "ekspozycjaMP" ("id");

ALTER TABLE "produkt_promocjaMP" ADD FOREIGN KEY ("produktID") REFERENCES "produktMP" ("id");

ALTER TABLE "produkt_promocjaMP" ADD FOREIGN KEY ("promocjaID") REFERENCES "promocjaMP" ("id");