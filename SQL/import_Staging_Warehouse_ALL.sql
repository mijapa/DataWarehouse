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
end;
/

  