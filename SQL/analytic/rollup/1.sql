SELECT WHOUSE."sprzedaz_FAKT"."id_produktu",
       WHOUSE."sprzedaz_FAKT"."id_lokalizacji",
       SUM(WHOUSE."sprzedaz_FAKT"."suma_dochodow") AS dochod
from WHOUSE."sprzedaz_FAKT"
GROUP BY ROLLUP ("id_lokalizacji", "id_produktu")
order by dochod desc;

