SELECT WHOUSE."sprzedaz_FAKT"."id_produktu",
       WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji",
       count(WHOUSE."sprzedaz_FAKT"."id_produktu") as ile
from WHOUSE."sprzedaz_FAKT"
         left join WHouse."czas_WYMIAR" czas_sprzedazy
                   on (czas_sprzedazy."id_czasu" = "sprzedaz_FAKT"."id_czasu")
         left join WHOUSE."forma_ekspozycji_WYMIAR"
                   on ("forma_ekspozycji_WYMIAR"."id_formy_ekspozycji" = "sprzedaz_FAKT"."id_formy_ekspozycji")
         left join WHOUSE."czas_WYMIAR" czas_rospoczecia
                   on ("forma_ekspozycji_WYMIAR"."id_czasu_rozpoczecia" = czas_rospoczecia."id_czasu")
         left join WHOUSE."czas_WYMIAR" czas_zakonczenia
                   on ("forma_ekspozycji_WYMIAR"."id_czasu_zakonczenia" = czas_zakonczenia."id_czasu")
where czas_sprzedazy."rok" between czas_rospoczecia."rok" and czas_zakonczenia."rok"
group by rollup (WHOUSE."sprzedaz_FAKT"."id_produktu", WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji")