SELECT "czas_WYMIAR"."rok"                           as rok,
       "czas_WYMIAR"."miesiac"                       as miesiac,
       SUM(WHOUSE."sprzedaz_FAKT"."suma_dochodow")   AS dochod,
       SUM(WHOUSE."sprzedaz_FAKT"."suma_przychodow") AS przychod
from WHOUSE."sprzedaz_FAKT"
         natural join WHOUSE."czas_WYMIAR"
GROUP BY ROLLUP ("czas_WYMIAR"."rok", "czas_WYMIAR"."miesiac")
order by dochod desc;
