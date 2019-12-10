SELECT WHOUSE."zwroty_FAKT"."id_produktu",
       "czas_WYMIAR"."rok",
       "czas_WYMIAR"."miesiac",
       count(WHOUSE."zwroty_FAKT"."id_produktu") as ilosc_zwroconych
from WHOUSE."zwroty_FAKT"
         natural join WHOUSE."czas_WYMIAR"
group by rollup ("czas_WYMIAR"."rok", "czas_WYMIAR"."miesiac", WHOUSE."zwroty_FAKT"."id_produktu")
order by ilosc_zwroconych desc;