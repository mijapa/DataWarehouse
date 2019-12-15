create bitmap index bit_rabat_nazwa_formy_lokalizacja_rok_produkt_przedzial_idx on WHOUSE."sprzedaz_FAKT" (WHOUSE."forma_ekspozycji_WYMIAR"."nazwa",
                                                                                                           WHOUSE."promocja_WYMIAR"."procentowa_wysokosc_rabatu",
                                                                                                           WHOUSE."lokalizacja_WYMIAR"."ilosc_klientow_w_zasiegu",
                                                                                                           WHOUSE."czas_WYMIAR"."rok",
                                                                                                           WHOUSE."produkt_WYMIAR"."marka",
                                                                                                           WHOUSE."przedzial_cenowy_WYMIAR"."start_przedzialu_zawiera",
                                                                                                           WHOUSE."przedzial_cenowy_WYMIAR"."koniec_przedzialu")
    from WHOUSE."forma_ekspozycji_WYMIAR", WHOUSE."sprzedaz_FAKT", WHOUSE."promocja_WYMIAR", WHOUSE."lokalizacja_WYMIAR", WHOUSE."czas_WYMIAR", WHOUSE."produkt_WYMIAR", WHOUSE."przedzial_cenowy_WYMIAR"
        where WHOUSE."forma_ekspozycji_WYMIAR"."id_formy_ekspozycji" = WHOUSE."sprzedaz_FAKT"."id_formy_ekspozycji"
            and WHOUSE."promocja_WYMIAR"."id_promocji" = WHOUSE."sprzedaz_FAKT"."id_promocji"
            and WHOUSE."lokalizacja_WYMIAR"."id_lokalizacji" = WHOUSE."sprzedaz_FAKT"."id_lokalizacji"
            and WHOUSE."czas_WYMIAR"."id_czasu" = WHOUSE."sprzedaz_FAKT"."id_czasu"
            and WHOUSE."produkt_WYMIAR"."id_produktu" = WHOUSE."sprzedaz_FAKT"."id_produktu"
            and WHOUSE."przedzial_cenowy_WYMIAR"."id_przedzialu_cenowego" =
                WHOUSE."sprzedaz_FAKT"."id_przedzialu_cenowego";