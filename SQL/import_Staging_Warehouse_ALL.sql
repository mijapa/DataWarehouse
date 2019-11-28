whenever sqlerror exit rollback;
begin
    INSERT INTO "WHOUSE"."produkt_WYMIAR" ("id_produktu", "cena", "marza_zawarta_w_cenie", "marka", "model",
                                           "producent", "kategoria", "rodzaj_produktu", "opis")
    SELECT "id_produktu",
           "cena",
           "marza_zawarta_w_cenie",
           "marka",
           "model",
           "producent",
           "kategoria",
           "rodzaj_produktu",
           "opis"
    FROM "STAGINGAREA"."produkt";
    COMMIT;

    INSERT INTO "WHOUSE"."lokalizacja_WYMIAR" ("id_lokalizacji", "miasto", "powiat", "wojewodztwo", "kraj",
                                               "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu")
    SELECT "id_sklepu", "miasto", "powiat", "wojewodztwo", "kraj", "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu"
    FROM "STAGINGAREA"."sklep";
    COMMIT;

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "czas") / 15)) kw,
                           EXTRACT(HOUR FROM "czas")                 go,
                           EXTRACT(DAY FROM "czas")                  dz,
                           EXTRACT(MONTH FROM "czas")                mi,
                           EXTRACT(YEAR FROM "czas")                 ro
           FROM "STAGINGAREA"."magazyn") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    insert into WHOUSE."forma_ekspozycji_WYMIAR" ("id_formy_ekspozycji", "nazwa")
    SELECT "id_ekspozycji", "nazwa_formy_ekspozycji"
    from STAGINGAREA."ekspozycja";
    commit;

    MERGE INTO "WHOUSE"."sposob_platnosci_WYMIAR" s
    USING (SELECT distinct "transakcja"."rodzaj_platnosci"
           FROM "STAGINGAREA"."transakcja") t
    on (s."rodzaj" = t."rodzaj_platnosci")
    WHEN NOT MATCHED THEN
        INSERT ("rodzaj")
        VALUES (t."rodzaj_platnosci");
    COMMIT;

    MERGE INTO "WHOUSE"."promocja_WYMIAR" p
    USING (SELECT distinct "produkt_promocja"."data_rozpoczecia",
                           "produkt_promocja"."data_zakonczenia",
                           "promocja"."procentowa_wysokosc_rabatu"
           from STAGINGAREA."produkt_promocja"
                    natural join STAGINGAREA."promocja") pp
    on (p."data_rozpoczecia" = pp."data_rozpoczecia" and p."data_zakonczenia" = pp."data_zakonczenia"
        and p."procentowa_wysokosc_rabatu" = pp."procentowa_wysokosc_rabatu")
    WHEN NOT MATCHED THEN
        INSERT ("data_rozpoczecia", "data_zakonczenia", "procentowa_wysokosc_rabatu")
        VALUES (pp."data_rozpoczecia", pp."data_zakonczenia", pp."procentowa_wysokosc_rabatu");
    COMMIT;

    MERGE INTO "WHOUSE"."przedzial_cenowy_WYMIAR" pc
    USING (SELECT distinct (round(STAGINGAREA."produkt"."cena" / 10) * 10 - 5) od,
                           (round(STAGINGAREA."produkt"."cena" / 10) * 10 + 5) do
           from STAGINGAREA."produkt") pr
    on (pc."start_przedzialu_zawiera" = pr.od and pc."koniec_przedzialu" = pr.do)
    WHEN NOT MATCHED THEN
        INSERT ("start_przedzialu_zawiera", "koniec_przedzialu")
        VALUES (pr.od, pr.do);
    COMMIT;

end;
/

  