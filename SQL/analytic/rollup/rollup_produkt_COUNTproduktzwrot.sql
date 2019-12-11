SELECT WHOUSE."sprzedaz_FAKT"."id_produktu",
       count(WHOUSE."zwroty_FAKT"."id_produktu") / count(WHOUSE."sprzedaz_FAKT"."id_produktu") as ile_procent
from WHOUSE."sprzedaz_FAKT"
         left join WHOUSE."zwroty_FAKT" on "zwroty_FAKT"."id_transakcji" = "sprzedaz_FAKT"."id_transakcji"
group by rollup (WHOUSE."sprzedaz_FAKT"."id_produktu")
order by ile_procent desc