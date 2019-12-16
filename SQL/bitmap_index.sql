create bitmap index join_bit_sposob_idx
    on WHOUSE."sprzedaz_FAKT" (
                               WHOUSE."sposob_platnosci_WYMIAR"."rodzaj")
    from
        WHOUSE."sprzedaz_FAKT",
        WHOUSE."sposob_platnosci_WYMIAR"
        where WHOUSE."sposob_platnosci_WYMIAR"."id_sposobu_platnosci" = WHOUSE."sprzedaz_FAKT"."id_sposobu_platnosci";

create bitmap index join_bit_sposob_forma_idx
    on WHOUSE."sprzedaz_FAKT" (WHOUSE."sposob_platnosci_WYMIAR"."rodzaj",
                               WHOUSE."forma_ekspozycji_WYMIAR"."nazwa")
    from
        WHOUSE."sprzedaz_FAKT",
        WHOUSE."sposob_platnosci_WYMIAR",
        WHOUSE."forma_ekspozycji_WYMIAR"
        where WHOUSE."sposob_platnosci_WYMIAR"."id_sposobu_platnosci" = WHOUSE."sprzedaz_FAKT"."id_sposobu_platnosci"
            and WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji" = WHOUSE."sprzedaz_FAKT"."id_formy_ekspozycji";


create bitmap index join_bit_rabat_idx
    on WHOUSE."sprzedaz_FAKT" (
                               WHOUSE."promocja_WYMIAR"."procentowa_wysokosc_rabatu")
    from
        WHOUSE."sprzedaz_FAKT",
        WHOUSE."promocja_WYMIAR"
        where WHOUSE."promocja_WYMIAR"."id_promocji" = WHOUSE."sprzedaz_FAKT"."id_promocji";
