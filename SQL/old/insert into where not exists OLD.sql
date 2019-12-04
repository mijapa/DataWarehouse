INSERT INTO "STAGINGAREA"."czas_WYMIAR" ("kwadrans", "godzina", "dzien", "miesiac", "rok")
SELECT (EXTRACT(MINUTE FROM "czas") / 15),
       EXTRACT(MINUTE FROM "czas"),
       EXTRACT(MINUTE FROM "czas"),
       EXTRACT(MINUTE FROM "czas"),
       EXTRACT(MINUTE FROM "czas")
FROM "STAGINGAREA"."magazyn"
WHERE NOT EXISTS(SELECT null FROM "STAGINGAREA"."czas_WYMIAR" WHERE "STAGINGAREA"."czas_WYMIAR"."kwadrans" = 1);