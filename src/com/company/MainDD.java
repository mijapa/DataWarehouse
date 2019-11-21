package com.company;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import static java.lang.Math.round;

public class MainDD {
    static int j = 0;

    public static void main(String[] args) throws IOException {

        BufferedWriter writer = new BufferedWriter(new FileWriter("reklama.csv", true));
        writer.append("id_reklamy,id_produktu,data_rozpoczecia,data_zakonczenia,rodzaj,rabat_lub_ekspozycja\n");
        for (int i = 5000; i < 5000 + 5000; i++) {

            writer.append(String.valueOf(i));
            writer.append(",");

            writer.append(String.valueOf(i));
            writer.append(",");

            writer.append("9");
            writer.append(String.valueOf(i % 10));
            writer.append("/0");
            writer.append(String.valueOf(i % 9 + 1));
            writer.append("/");
            writer.append(zeroJedenDwa(i));
            writer.append(String.valueOf(i % 9 + 1));
            writer.append(" ");
            writer.append(String.valueOf(i % 12 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(",");

            writer.append("9");
            writer.append(String.valueOf(i % 9 + 1));
            writer.append("/0");
            writer.append(String.valueOf(i % 9 + 1));
            writer.append("/");
            writer.append(zeroJedenDwa(i));
            writer.append(String.valueOf(i % 9 + 1));
            writer.append(" ");
            writer.append(String.valueOf(i % 12 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(",");

            writer.append(rodzajReklamy(i));
            writer.append(",");

            writer.append(String.valueOf(i % 10));
            writer.append("\n");
        }

        writer = new BufferedWriter(new FileWriter("produkt.csv", true));
        writer.append("id_produktu,cena,marka,model,producent,kategoria,rodzaj_produktu,opis,marza\n");
        for (int i = 5000; i < 15000; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");

            writer.append(String.valueOf(i % 100 + 400));
            writer.append(",");

            writer.append("marka" + i % 100 + ",");
            writer.append("model" + i % 100 + ",");
            writer.append("producent" + i % 100 + ",");
            writer.append("kategoria" + i % 100 + ",");
            writer.append("rodzaj" + i % 100 + ",");
            writer.append("opis" + i % 100 + ",");

            writer.append(String.valueOf((round(i % 100 + 400) * 0.3 * 100) / 100));
            writer.append("\n");
        }
//za tydzień posumowanie i wystawienie ocen
// 9 stycznia ostatnie spotkania
        writer = new BufferedWriter(new FileWriter("magazyn.csv", true));
        writer.append("id_produktu,id_sklepu,ilosc_sztuk,czas\n");
        for (int i = 5000; i < 15000; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append(String.valueOf(i % 100 + 200));
            writer.append(",");
            writer.append(String.valueOf((i % 10) * 1000));
            writer.append(",");

            writer.append("9");
            writer.append(String.valueOf(i % 10));
            writer.append("/0");
            writer.append(String.valueOf(i % 9 + 1));
            writer.append("/");
            writer.append(zeroJedenDwa(i));
            writer.append(String.valueOf(i % 9 + 1));
            writer.append(" ");
            writer.append(String.valueOf(i % 12 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));

            writer.append("\n");
        }

        writer = new BufferedWriter(new FileWriter("sprzedaz.csv", true));
        writer.append("id_sprzedazy,id_sklepu,data,rodzaj\n");
        for (int i = 20000000; i < 20000000 + 25000000; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");

            writer.append(String.valueOf(i % 100 + 200));
            writer.append(",");

            writer.append("9");
            writer.append(String.valueOf(i % 10));
            writer.append("/0");
            writer.append(String.valueOf(i % 9 + 1));
            writer.append("/");
            writer.append(zeroJedenDwa(i));
            writer.append(String.valueOf(i % 9 + 1));
            writer.append(" ");
            writer.append(String.valueOf(i % 12 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(":");
            writer.append(String.valueOf(i % 49 + 10));
            writer.append(",");
            writer.append(rodzaj(i));
            writer.append("\n");
        }


        writer = new BufferedWriter(new FileWriter("zakup_produkt.csv", true));
        writer.append("id_produktu,id_sprzedazy,ilosc\n");
        for (int i = 5000, j = 20000000; j < 20000000 + 25000000; i++, j++) {
            if (i == 15000) {
                i = 5000;
            }
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append(String.valueOf(j));
            writer.append(",");
            writer.append("10");
            writer.append("\n");
        }
        writer.close();


        writer = new BufferedWriter(new FileWriter("reklamacja.csv", true));
        writer.append("id_produktu,id_sprzedazy,data,ilosc\n");
        for (int i = 5000, j = 20000000; j < 20000000 + 25000000; i++, j++) {
            if (i == 15000) {
                i = 5000;
            }
            if (i % 3 == 0) {
                writer.append(String.valueOf(i));
                writer.append(",");
                writer.append(String.valueOf(j));
                writer.append(",");

                writer.append("9");
                writer.append(String.valueOf(i % 10));
                writer.append("/0");
                writer.append(String.valueOf(i % 9 + 1));
                writer.append("/");
                writer.append(zeroJedenDwa(i));
                writer.append(String.valueOf(i % 9 + 1));
                writer.append(" ");
                writer.append(String.valueOf(i % 12 + 10));
                writer.append(":");
                writer.append(String.valueOf(i % 49 + 10));
                writer.append(":");
                writer.append(String.valueOf(i % 49 + 10));

                writer.append(",");
                writer.append("1");
                writer.append("\n");
            }
        }
        writer.close();
//
//zaimplementować staging area w oraclu, zaimplementować pierwszy etap etl'a w ramach procedur lub funckji zaimplementować ładowanie z baz wejściowych
// eliminować niespójności, przeliczanie walut, zaimplementować w sql hurtownie danych, gdzie będą tabele z faktami i wymiary, dociągnąć dokumentację.
    }

    private static String rodzajReklamy(int i) {
        j++;
        if (j % 2 == 1) {
            return "promocja";
//        }else if(j % 5 == 2){
//            return "kampania internetowa";
//        }else if(j % 5 == 3){
//            return "miejsce na wystawie";
//        }else if(j % 5 == 4){
//            return "drugi produkt -50%";
        } else {
            return "ekspozycja";
        }
    }

    private static String zeroJedenDwa(int i) {
        if (i % 3 == 1) {
            return "1";
        } else if (i % 3 == 2) {
            return "2";
        } else {
            return "0";
        }
    }

    private static String wolnyDzien(int i) {
        if (i % 400 == 0) {
            return "tak";
        } else {
            return "nie";
        }
    }

    private static String rodzaj(int i) {
        if (i % 3 == 1) {
            return "karta";
        } else if (i % 3 == 2) {
            return "gotowka";
        } else {
            return "kredyt";
        }
    }
}