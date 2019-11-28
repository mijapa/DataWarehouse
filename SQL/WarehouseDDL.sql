CREATE TABLE "sprzedaz_FAKT"
(
    "id_produktu"                       numeric NOT NULL,
    "id_czasu"                          numeric NOT NULL,
    "id_transakcji"                     numeric NOT NULL,
    "id_promocji"                       numeric NOT NULL,
    "id_lokalizacji"                    numeric NOT NULL,
    "id_formy_ekspozycji"               numeric NOT NULL,
    "id_przedzialu_cenowego"            numeric NOT NULL,
    "id_sposobu_platnosci"              numeric NOT NULL,
    "suma_ilosci_zakupionych_produktow" numeric NOT NULL,
    "suma_dochodow"                     numeric NOT NULL,
    "suma_przychodow"                   numeric NOT NULL
);

CREATE TABLE "zwroty_FAKT"
(
    "id_produktu"                                  numeric NOT NULL,
    "id_czasu"                                     numeric NOT NULL,
    "id_transakcji"                                numeric NOT NULL,
    "id_promocji"                                  numeric NOT NULL,
    "id_przedzialu_cenowego_pojedynczego_produktu" numeric NOT NULL,
    "id_sposobu_platnosci"                         numeric NOT NULL,
    "suma_dochodow_utraconych"                     numeric NOT NULL,
    "suma_przychodow_utraconych"                   numeric NOT NULL,
    "suma_ilosci_zwroconych_produktow"             numeric NOT NULL
);

CREATE TABLE "magazyn_FAKT"
(
    "id_produktu"           numeric NOT NULL,
    "id_czasu"              numeric NOT NULL,
    "id_lokalizacji"        numeric NOT NULL,
    "suma_ilosci_produktow" numeric NOT NULL
);

CREATE TABLE "produkt_WYMIAR"
(
    "id_produktu"           numeric       NOT NULL PRIMARY KEY,
    "cena"                  numeric       NOT NULL,
    "marza_zawarta_w_cenie" numeric       NOT NULL,
    "marka"                 varchar2(100) NOT NULL,
    "model"                 varchar2(100) NOT NULL,
    "producent"             varchar2(100) NOT NULL,
    "kategoria"             varchar2(100) NOT NULL,
    "rodzaj_produktu"       varchar2(100) NOT NULL,
    "opis"                  varchar2(100) NOT NULL
);

CREATE TABLE "czas_WYMIAR"
(
    "id_czasu" numeric GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    "kwadrans" numeric                                                            NOT NULL,
    "godzina"  numeric                                                            NOT NULL,
    "dzien"    numeric                                                            NOT NULL,
    "miesiac"  numeric                                                            NOT NULL,
    "rok"      numeric                                                            NOT NULL
);

CREATE TABLE "promocja_WYMIAR"
(
    "id_promocji"                numeric GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    "data_rozpoczecia"           timestamp                                                          NOT NULL,
    "data_zakonczenia"           timestamp                                                          NOT NULL,
    "procentowa_wysokosc_rabatu" numeric                                                            NOT NULL
);

CREATE TABLE "lokalizacja_WYMIAR"
(
    "id_lokalizacji"           numeric       NOT NULL PRIMARY KEY,
    "miasto"                   varchar2(100) NOT NULL,
    "powiat"                   varchar2(100) NOT NULL,
    "wojewodztwo"              varchar2(100) NOT NULL,
    "kraj"                     varchar2(100) NOT NULL,
    "odleglosc_od_centrum"     varchar2(100) NOT NULL,
    "ilosc_klientow_w_zasiegu" numeric       NOT NULL
);

CREATE TABLE "forma_ekspozycji_WYMIAR"
(
    "id_formy_ekspozycji" numeric       NOT NULL PRIMARY KEY,
    "nazwa"               varchar2(100) NOT NULL
);

CREATE TABLE "przedzial_cenowy_WYMIAR"
(
    "id_przedzialu_cenowego"   numeric GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    "start_przedzialu_zawiera" numeric                                                            NOT NULL,
    "koniec_przedzialu"        numeric                                                            NOT NULL
);

CREATE TABLE "sposob_platnosci_WYMIAR"
(
    "id_sposobu_platnosci" numeric GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    "rodzaj"               varchar2(100)                                                      NOT NULL
);

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt_WYMIAR" ("id_produktu");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_czasu") REFERENCES "czas_WYMIAR" ("id_czasu");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_promocji") REFERENCES "promocja_WYMIAR" ("id_promocji");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_lokalizacji") REFERENCES "lokalizacja_WYMIAR" ("id_lokalizacji");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_formy_ekspozycji") REFERENCES "forma_ekspozycji_WYMIAR" ("id_formy_ekspozycji");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_przedzialu_cenowego") REFERENCES "przedzial_cenowy_WYMIAR" ("id_przedzialu_cenowego");

ALTER TABLE "sprzedaz_FAKT"
    ADD FOREIGN KEY ("id_sposobu_platnosci") REFERENCES "sposob_platnosci_WYMIAR" ("id_sposobu_platnosci");

ALTER TABLE "zwroty_FAKT"
    ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt_WYMIAR" ("id_produktu");

ALTER TABLE "zwroty_FAKT"
    ADD FOREIGN KEY ("id_czasu") REFERENCES "czas_WYMIAR" ("id_czasu");

ALTER TABLE "zwroty_FAKT"
    ADD FOREIGN KEY ("id_promocji") REFERENCES "promocja_WYMIAR" ("id_promocji");

ALTER TABLE "zwroty_FAKT"
    ADD FOREIGN KEY ("id_przedzialu_cenowego_pojedynczego_produktu") REFERENCES "przedzial_cenowy_WYMIAR" ("id_przedzialu_cenowego_pojedynczego_produktu");

ALTER TABLE "zwroty_FAKT"
    ADD FOREIGN KEY ("id_sposobu_platnosci") REFERENCES "sposob_platnosci_WYMIAR" ("id_sposobu_platnosci");

ALTER TABLE "magazyn_FAKT"
    ADD FOREIGN KEY ("id_produktu") REFERENCES "produkt_WYMIAR" ("id_produktu");

ALTER TABLE "magazyn_FAKT"
    ADD FOREIGN KEY ("id_czasu") REFERENCES "czas_WYMIAR" ("id_czasu");

ALTER TABLE "magazyn_FAKT"
    ADD FOREIGN KEY ("id_lokalizacji") REFERENCES "lokalizacja_WYMIAR" ("id_lokalizacji");