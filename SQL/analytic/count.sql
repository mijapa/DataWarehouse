SELECT count(WHOUSE."sprzedaz_FAKT"."id_produktu")
from WHOUSE."sprzedaz_FAKT"
         left join WHOUSE."produkt_WYMIAR" on "sprzedaz_FAKT"."id_produktu" = "produkt_WYMIAR"."id_produktu"
         left join WHOUSE."lokalizacja_WYMIAR"
                   on "sprzedaz_FAKT"."id_lokalizacji" = "lokalizacja_WYMIAR"."id_lokalizacji"
         left join WHOUSE."sposob_platnosci_WYMIAR"
                   on "sprzedaz_FAKT"."id_sposobu_platnosci" = "sposob_platnosci_WYMIAR"."id_sposobu_platnosci"
         left join WHOUSE."czas_WYMIAR" on "sprzedaz_FAKT"."id_czasu" = "czas_WYMIAR"."id_czasu"
         left join WHOUSE."promocja_WYMIAR" on "sprzedaz_FAKT"."id_promocji" = "promocja_WYMIAR"."id_promocji"
         left join WHOUSE."forma_ekspozycji_WYMIAR"
                   on "sprzedaz_FAKT"."id_formy_ekspozycji" = "forma_ekspozycji_WYMIAR"."id_formy_ekspozycji"
         left join WHOUSE."przedzial_cenowy_WYMIAR"
                   on "sprzedaz_FAKT"."id_przedzialu_cenowego" = "przedzial_cenowy_WYMIAR"."id_przedzialu_cenowego"
where "sposob_platnosci_WYMIAR"."rodzaj" = 'gotowka'
  and WHOUSE."czas_WYMIAR"."rok" = 99
  and WHOUSE."promocja_WYMIAR"."procentowa_wysokosc_rabatu" > 10
  and WHOUSE."przedzial_cenowy_WYMIAR"."start_przedzialu_zawiera" = 1595
  and WHOUSE."przedzial_cenowy_WYMIAR"."koniec_przedzialu" = 1605
  and WHOUSE."lokalizacja_WYMIAR"."ilosc_klientow_w_zasiegu" > 200;