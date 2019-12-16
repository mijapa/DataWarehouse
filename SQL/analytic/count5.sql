Select WHOUSE."sprzedaz_FAKT"."id_produktu",
       count(*)
from WHOUSE."sprzedaz_FAKT"
         left join WHOUSE."sposob_platnosci_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_sposobu_platnosci" =
                      WHOUSE."sposob_platnosci_WYMIAR"."id_sposobu_platnosci"
         left join WHOUSE."forma_ekspozycji_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_formy_ekspozycji" =
                      WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji"
         left join WHOUSE."promocja_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_promocji" = WHOUSE."promocja_WYMIAR"."id_promocji"
where WHOUSE."sposob_platnosci_WYMIAR"."rodzaj" = 'karta'
  and WHOUSE."forma_ekspozycji_WYMIAR"."nazwa" = '5'
  and WHOUSE."promocja_WYMIAR"."procentowa_wysokosc_rabatu" = 10
group by rollup (WHOUSE."sprzedaz_FAKT"."id_produktu")