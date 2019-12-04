SELECT DISTINCT round((EXTRACT(MINUTE FROM stagingarea."magazyn"."czas") / 15)) kw,
                EXTRACT(HOUR FROM stagingarea."magazyn"."czas")                 go,
                EXTRACT(DAY FROM stagingarea."magazyn"."czas")                  dz,
                EXTRACT(MONTH FROM stagingarea."magazyn"."czas")                mi,
                EXTRACT(YEAR FROM stagingarea."magazyn"."czas")                 ro
FROM stagingarea."magazyn"
ORDER BY ro,
         mi,
         dz,
         go,
         kw