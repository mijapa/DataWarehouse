Select count(*)
from WHOUSE."sprzedaz_FAKT"
         left join WHOUSE."sposob_platnosci_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_sposobu_platnosci" =
                      WHOUSE."sposob_platnosci_WYMIAR"."id_sposobu_platnosci"
         left join WHOUSE."forma_ekspozycji_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_formy_ekspozycji" =
                      WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji"
where WHOUSE."sposob_platnosci_WYMIAR"."rodzaj" = 'karta'
  and WHOUSE."forma_ekspozycji_WYMIAR"."nazwa" = '5';