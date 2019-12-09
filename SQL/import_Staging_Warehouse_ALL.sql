whenever sqlerror exit
rollback;
begin
    MERGE INTO WHOUSE."produkt_WYMIAR" wpr
    USING (SELECT distinct "id_produktu",
                           "cena",
                           "marza_zawarta_w_cenie",
                           "marka",
                           "model",
                           "producent",
                           "kategoria",
                           "rodzaj_produktu",
                           "opis"
           FROM "STAGINGAREA"."produkt") spr
    on (wpr."marka" = spr."marka" and wpr."model" = spr."model")
    WHEN NOT MATCHED THEN
        INSERT ("id_produktu", "cena", "marza_zawarta_w_cenie", "marka", "model",
                "producent", "kategoria", "rodzaj_produktu", "opis")
        VALUES (spr."id_produktu", spr."cena", spr."marza_zawarta_w_cenie", spr."marka", spr."model",
                spr."producent", spr."kategoria", spr."rodzaj_produktu", spr."opis");
    COMMIT;

    MERGE INTO WHOUSE."lokalizacja_WYMIAR" l
    USING (SELECT distinct "id_sklepu",
                           "miasto",
                           "powiat",
                           "wojewodztwo",
                           "kraj",
                           "odleglosc_od_centrum",
                           "ilosc_klientow_w_zasiegu"
           FROM "STAGINGAREA"."sklep") s
    on (l."miasto" = s."miasto" and l."powiat" = s."powiat")
    WHEN NOT MATCHED THEN
        INSERT ("id_lokalizacji", "miasto", "powiat", "wojewodztwo", "kraj",
                "odleglosc_od_centrum", "ilosc_klientow_w_zasiegu")
        VALUES (s."id_sklepu", s."miasto", s."powiat", s."wojewodztwo", s."kraj", s."odleglosc_od_centrum",
                s."ilosc_klientow_w_zasiegu");
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

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "data_rozpoczecia") / 15)) kw,
                           EXTRACT(HOUR FROM "data_rozpoczecia")                 go,
                           EXTRACT(DAY FROM "data_rozpoczecia")                  dz,
                           EXTRACT(MONTH FROM "data_rozpoczecia")                mi,
                           EXTRACT(YEAR FROM "data_rozpoczecia")                 ro
           FROM "STAGINGAREA"."produkt_promocja") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "data_zakonczenia") / 15)) kw,
                           EXTRACT(HOUR FROM "data_zakonczenia")                 go,
                           EXTRACT(DAY FROM "data_zakonczenia")                  dz,
                           EXTRACT(MONTH FROM "data_zakonczenia")                mi,
                           EXTRACT(YEAR FROM "data_zakonczenia")                 ro
           FROM "STAGINGAREA"."produkt_ekspozycja") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "czas") / 15)) kw,
                           EXTRACT(HOUR FROM "czas")                 go,
                           EXTRACT(DAY FROM "czas")                  dz,
                           EXTRACT(MONTH FROM "czas")                mi,
                           EXTRACT(YEAR FROM "czas")                 ro
           FROM "STAGINGAREA"."transakcja") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "czas") / 15)) kw,
                           EXTRACT(HOUR FROM "czas")                 go,
                           EXTRACT(DAY FROM "czas")                  dz,
                           EXTRACT(MONTH FROM "czas")                mi,
                           EXTRACT(YEAR FROM "czas")                 ro
           FROM "STAGINGAREA"."zwrot") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    MERGE INTO "WHOUSE"."czas_WYMIAR" c
    USING (SELECT distinct round((EXTRACT(MINUTE FROM "czas") / 15)) kw,
                           EXTRACT(HOUR FROM "czas")                 go,
                           EXTRACT(DAY FROM "czas")                  dz,
                           EXTRACT(MONTH FROM "czas")                mi,
                           EXTRACT(YEAR FROM "czas")                 ro
           FROM "STAGINGAREA"."transakcja") w
    on (c."kwadrans" = w.kw and c."godzina" = w.go and c."dzien" = w.dz and c."miesiac" = w.mi and c."rok" = w.ro)
    WHEN NOT MATCHED THEN
        INSERT ("kwadrans", "godzina", "dzien", "miesiac", "rok")
        VALUES (w.kw, w.go, w.dz, w.mi, w.ro);
    COMMIT;

    MERGE INTO WHOUSE."forma_ekspozycji_WYMIAR" fe
    USING (SELECT distinct "id_ekspozycji", "nazwa_formy_ekspozycji", cr."id_czasu" i_c_r, cz."id_czasu" i_c_z
           from STAGINGAREA."produkt_ekspozycja" pe
                    natural join STAGINGAREA."ekspozycja"
                    left join WHOUSE."czas_WYMIAR" cr
                              on (cr."kwadrans" = round((EXTRACT(MINUTE FROM pe."data_rozpoczecia") / 15)) and
                                  cr."godzina" = EXTRACT(HOUR FROM pe."data_rozpoczecia") and
                                  cr."dzien" = EXTRACT(DAY FROM pe."data_rozpoczecia") and
                                  cr."miesiac" = EXTRACT(MONTH FROM pe."data_rozpoczecia") and
                                  cr."rok" = EXTRACT(YEAR FROM pe."data_rozpoczecia"))
                    left join WHOUSE."czas_WYMIAR" cz
                              on (cz."kwadrans" = round((EXTRACT(MINUTE FROM pe."data_zakonczenia") / 15)) and
                                  cz."godzina" = EXTRACT(HOUR FROM pe."data_zakonczenia") and
                                  cz."dzien" = EXTRACT(DAY FROM pe."data_rozpoczecia") and
                                  cz."miesiac" = EXTRACT(MONTH FROM pe."data_rozpoczecia") and
                                  cz."rok" = EXTRACT(YEAR FROM pe."data_zakonczenia"))) sel
    ON (sel."nazwa_formy_ekspozycji" = fe."nazwa" and sel.i_c_r = fe."id_czasu_rozpoczecia" and
        sel.i_c_z = fe."id_czasu_zakonczenia")
    WHEN NOT MATCHED THEN
        INSERT ("id_czasu_rozpoczecia", "id_czasu_zakonczenia", "nazwa")
        values (sel.i_c_r, sel.i_c_z, sel."nazwa_formy_ekspozycji");
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
    USING (SELECT distinct pp."data_rozpoczecia",
                           pp."data_zakonczenia",
                           "promocja"."procentowa_wysokosc_rabatu",
                           cr."id_czasu" id_czasu_rozpoczecia,
                           cz."id_czasu" id_czasu_zakonczenia
           from STAGINGAREA."produkt_promocja" pp
                    natural join STAGINGAREA."promocja"
                    left join WHOUSE."czas_WYMIAR" cr
                              on (cr."kwadrans" = round((EXTRACT(MINUTE FROM pp."data_rozpoczecia") / 15)) and
                                  cr."godzina" = EXTRACT(HOUR FROM pp."data_rozpoczecia") and
                                  cr."dzien" = EXTRACT(DAY FROM pp."data_rozpoczecia") and
                                  cr."miesiac" = EXTRACT(MONTH FROM pp."data_rozpoczecia") and
                                  cr."rok" = EXTRACT(YEAR FROM pp."data_rozpoczecia"))
                    left join WHOUSE."czas_WYMIAR" cz
                              on (cz."kwadrans" = round((EXTRACT(MINUTE FROM pp."data_zakonczenia") / 15)) and
                                  cz."godzina" = EXTRACT(HOUR FROM pp."data_zakonczenia") and
                                  cz."dzien" = EXTRACT(DAY FROM pp."data_rozpoczecia") and
                                  cz."miesiac" = EXTRACT(MONTH FROM pp."data_rozpoczecia") and
                                  cz."rok" = EXTRACT(YEAR FROM pp."data_zakonczenia"))) pp
    on (p."id_czasu_rozpoczecia" = pp.id_czasu_rozpoczecia and p."id_czasu_zakonczenia" = pp.id_czasu_zakonczenia
        and p."procentowa_wysokosc_rabatu" = pp."procentowa_wysokosc_rabatu")
    WHEN NOT MATCHED THEN
        INSERT ("id_czasu_rozpoczecia", "id_czasu_zakonczenia", "procentowa_wysokosc_rabatu")
        VALUES (id_czasu_rozpoczecia, id_czasu_zakonczenia, pp."procentowa_wysokosc_rabatu");
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

    MERGE INTO WHOUSE."magazyn_FAKT" wh_ma
    USING (SELECT distinct "id_produktu",
                           "id_czasu",
                           "id_lokalizacji",
                           "ilosc_sztuk"
           FROM "STAGINGAREA"."magazyn" st_ma
                    left join WHOUSE."czas_WYMIAR" c
                              on (c."kwadrans" = round((EXTRACT(MINUTE FROM "czas") / 15)) and
                                  c."godzina" = EXTRACT(HOUR FROM "czas") and c."dzien" = EXTRACT(DAY FROM "czas") and
                                  c."miesiac" = EXTRACT(MONTH FROM "czas") and
                                  c."rok" = EXTRACT(YEAR FROM "czas"))
                    left join WHOUSE."lokalizacja_WYMIAR" l
                              on (l."id_lokalizacji" = st_ma."id_sklepu")) st_ma
    on (st_ma."id_produktu" = wh_ma."id_produktu" and st_ma."id_czasu" = wh_ma."id_czasu" and
        st_ma."id_lokalizacji" = wh_ma."id_lokalizacji")
    WHEN NOT MATCHED THEN
        INSERT ("id_produktu", "id_czasu", "id_lokalizacji", "suma_ilosci_produktow")
        VALUES (st_ma."id_produktu", st_ma."id_czasu", st_ma."id_lokalizacji", st_ma."ilosc_sztuk");
    COMMIT;

    MERGE INTO WHOUSE."zwroty_FAKT" z
    USING (SELECT distinct st_zw."id_produktu"                       id_pr,
                           c."id_czasu"                              id_cz,
                           st_zw."id_transakcji"                     id_tr,
                           p."marza_zawarta_w_cenie" * "ilosc_sztuk" suma_dochodow_utraconych,
                           p."cena" * "ilosc_sztuk"                  suma_przychodow_utraconych,
                           st_zw."ilosc_sztuk"                       ilosc_sztuk_zwroconych_produktow
           FROM "STAGINGAREA"."zwrot" st_zw
                    left join WHOUSE."czas_WYMIAR" c
                              on (c."kwadrans" = round((EXTRACT(MINUTE FROM "czas") / 15)) and
                                  c."godzina" = EXTRACT(HOUR FROM "czas") and c."dzien" = EXTRACT(DAY FROM "czas") and
                                  c."miesiac" = EXTRACT(MONTH FROM "czas") and
                                  c."rok" = EXTRACT(YEAR FROM "czas"))
                    left join WHOUSE."produkt_WYMIAR" p
                              on (p."id_produktu" = st_zw."id_produktu")) sel
    ON (z."id_produktu" = sel.id_pr and z."id_czasu" = sel.id_cz and
        z."id_transakcji" = sel.id_tr)
    WHEN NOT MATCHED THEN
        INSERT ("id_produktu", "id_czasu", "id_transakcji",
                "suma_dochodow_utraconych", "suma_przychodow_utraconych",
                "suma_ilosci_zwroconych_produktow")
        VALUES (sel.id_pr, sel.id_cz, sel.id_tr, sel.suma_dochodow_utraconych,
                sel.suma_przychodow_utraconych, sel.ilosc_sztuk_zwroconych_produktow);
    COMMIT;

    MERGE INTO WHOUSE."sprzedaz_FAKT" sp
    USING (SELECT distinct st_sp."id_produktu",
                           c."id_czasu",
                           st_sp."id_transakcji",
                           prw."id_promocji",
                           "id_lokalizacji",
                           pe."id_ekspozycji",
                           "id_przedzialu_cenowego",
                           "id_sposobu_platnosci",
                           "ilosc_sztuk",
                           "ilosc_sztuk" * "marza_zawarta_w_cenie" dochod,
                           "ilosc_sztuk" * "cena"                  przychod
           FROM "STAGINGAREA"."sprzedany_produkt" st_sp
                    left join STAGINGAREA."transakcja" t
                              on (t."id_transakcji" = st_sp."id_transakcji")
                    left join WHOUSE."lokalizacja_WYMIAR" l
                              on (l."id_lokalizacji" = t."id_sklepu")
                    left join WHOUSE."czas_WYMIAR" c
                              on (c."kwadrans" = round((EXTRACT(MINUTE FROM t."czas") / 15)) and
                                  c."godzina" = EXTRACT(HOUR FROM t."czas") and c."dzien" = EXTRACT(DAY FROM "czas") and
                                  c."miesiac" = EXTRACT(MONTH FROM t."czas") and
                                  c."rok" = EXTRACT(YEAR FROM t."czas"))
                    left join WHOUSE."produkt_WYMIAR" p
                              on (p."id_produktu" = st_sp."id_produktu")
                    left join WHOUSE."przedzial_cenowy_WYMIAR" pc
                              on (pc."start_przedzialu_zawiera" = (round("cena" / 10) * 10 - 5) and
                                  pc."koniec_przedzialu" = (round("cena" / 10) * 10 + 5))
                    left join WHOUSE."sposob_platnosci_WYMIAR" sp
                              on (sp."rodzaj" = t."rodzaj_platnosci")
                    left join STAGINGAREA."produkt_promocja" pp
                              on (pp."id_produktu" = st_sp."id_produktu")
                    left join STAGINGAREA."promocja" pr
                              on (pr."id_promocji" = pp."id_promocji")
                    left join WHOUSE."czas_WYMIAR" cr
                              on (cr."kwadrans" = round((EXTRACT(MINUTE FROM pp."data_rozpoczecia") / 15)) and
                                  cr."godzina" = EXTRACT(HOUR FROM pp."data_rozpoczecia") and
                                  cr."dzien" = EXTRACT(DAY FROM pp."data_rozpoczecia") and
                                  cr."miesiac" = EXTRACT(MONTH FROM pp."data_rozpoczecia") and
                                  cr."rok" = EXTRACT(YEAR FROM pp."data_rozpoczecia"))
                    left join WHOUSE."czas_WYMIAR" cz
                              on (cz."kwadrans" = round((EXTRACT(MINUTE FROM pp."data_zakonczenia") / 15)) and
                                  cz."godzina" = EXTRACT(HOUR FROM pp."data_zakonczenia") and
                                  cz."dzien" = EXTRACT(DAY FROM pp."data_rozpoczecia") and
                                  cz."miesiac" = EXTRACT(MONTH FROM pp."data_rozpoczecia") and
                                  cz."rok" = EXTRACT(YEAR FROM pp."data_zakonczenia"))
                    left join WHOUSE."promocja_WYMIAR" prw
                              on (prw."id_czasu_rozpoczecia" = cr."id_czasu" and
                                  prw."id_czasu_zakonczenia" = cz."id_czasu"
                                  and prw."procentowa_wysokosc_rabatu" = pr."procentowa_wysokosc_rabatu")
                    left join STAGINGAREA."produkt_ekspozycja" pe
                              on (pe."id_produktu" = st_sp."id_produktu")
                    left join STAGINGAREA."ekspozycja" e
                              on (pe."id_ekspozycji" = e."id_ekspozycji")
                    left join WHOUSE."czas_WYMIAR" crfe
                              on (crfe."kwadrans" = round((EXTRACT(MINUTE FROM pe."data_rozpoczecia") / 15)) and
                                  crfe."godzina" = EXTRACT(HOUR FROM pe."data_rozpoczecia") and
                                  crfe."dzien" = EXTRACT(DAY FROM pe."data_rozpoczecia") and
                                  crfe."miesiac" = EXTRACT(MONTH FROM pe."data_rozpoczecia") and
                                  crfe."rok" = EXTRACT(YEAR FROM pe."data_rozpoczecia"))
                    left join WHOUSE."czas_WYMIAR" czfe
                              on (czfe."kwadrans" = round((EXTRACT(MINUTE FROM pe."data_zakonczenia") / 15)) and
                                  czfe."godzina" = EXTRACT(HOUR FROM pe."data_zakonczenia") and
                                  czfe."dzien" = EXTRACT(DAY FROM pe."data_rozpoczecia") and
                                  czfe."miesiac" = EXTRACT(MONTH FROM pe."data_rozpoczecia") and
                                  czfe."rok" = EXTRACT(YEAR FROM pe."data_zakonczenia"))
                    left join WHOUSE."forma_ekspozycji_WYMIAR" few
                              on (few."id_czasu_rozpoczecia" = crfe."id_czasu" and
                                  few."id_czasu_zakonczenia" = czfe."id_czasu"
                                  and few."nazwa" = e."nazwa_formy_ekspozycji")) sel
    ON (sp."id_transakcji" = sel."id_transakcji")
    WHEN NOT MATCHED THEN
        INSERT ("id_produktu", "id_czasu", "id_transakcji", "id_promocji", "id_lokalizacji",
                "id_formy_ekspozycji", "id_przedzialu_cenowego", "id_sposobu_platnosci",
                "suma_ilosci_zakupionych_produktow", "suma_dochodow",
                "suma_przychodow")
        VALUES (sel."id_produktu", sel."id_czasu", sel."id_transakcji", sel."id_promocji", sel."id_lokalizacji",
                sel."id_ekspozycji", sel."id_przedzialu_cenowego", sel."id_sposobu_platnosci", sel."ilosc_sztuk",
                sel.dochod, sel.przychod);
    COMMIT;
end ;
/

  