SELECT *
FROM (SELECT (round(STAGINGAREA."produkt"."cena" / 10) * 10 - 5),
             (round(STAGINGAREA."produkt"."cena" / 10) * 10 + 5),
             STAGINGAREA."produkt"."cena",
             row_number()
                     over (PARTITION BY (round(STAGINGAREA."produkt"."cena" / 10) * 10) order by (round(STAGINGAREA."produkt"."cena" / 10) * 10)) r
      from STAGINGAREA."produkt") a
where a.r = 1;