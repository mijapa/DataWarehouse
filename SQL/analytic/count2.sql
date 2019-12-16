Select count(*)
from WHOUSE."sprzedaz_FAKT"
         left join WHOUSE."sposob_platnosci_WYMIAR"
                   on WHOUSE."sprzedaz_FAKT"."id_sposobu_platnosci" =
                      WHOUSE."sposob_platnosci_WYMIAR"."id_sposobu_platnosci"
where WHOUSE."sposob_platnosci_WYMIAR"."rodzaj" = 'karta';

