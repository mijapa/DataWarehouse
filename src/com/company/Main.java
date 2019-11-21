package com.company;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import static java.lang.Math.round;

public class Main {
    static double ileProduktow = 10 * 1000;
    static double ileFormEkspozycji = 10;
    static double ilePromocji = 100;
    static double ileSklepow = 100;
    static double ileStanowMagazynowych = 1000 * 1000;
    static double ileZakupow = 10 * 1000 * 1000;
    static double ileProduktowNaPromocji = 1000;
    static double ileReklamacji = 10 * 1000;


    public static void main(String[] args) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter("ekspozycjaMP.csv", true));
        writer.append("id,numer_formy_ekspozycji\n");
        for (int i = 0; i < ileFormEkspozycji; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append(String.valueOf(i));
            writer.append("\n");
        }
        writer.close();

        writer = new BufferedWriter(new FileWriter("promocjaMP.csv", true));
        writer.append("id,procentowa_wysokosc_rabatu\n");
        for (int i = 0; i < ilePromocji; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append(String.valueOf((i + 5) % 30));
            writer.append("\n");
        }
        writer.close();

        writer = new BufferedWriter(new FileWriter("produkt_promocjaMP.csv", true));
        writer.append("produktID,promocjaID,data_rozpoczecia,data_zakonczenia\n");
        for (int i = 0; i < ileProduktowNaPromocji; i++) {

            writer.append(String.valueOf(i % ileProduktow));
            writer.append(",");
            writer.append(String.valueOf(i % ilePromocji));
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
            writer.append("\n");
        }
        writer.close();

        writer = new BufferedWriter(new FileWriter("sklepMP.csv", true));
        writer.append("id,miasto,powiat,wojewodztwo,kraj,odleglosc_od_centrum,ilosc_klientow_w_zasiegu\n");
        for (int i = 0; i < ileSklepow; i++) {

            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append("miasto" + i % 128);
            writer.append(",");
            writer.append("powiat" + i % 64);
            writer.append(",");
            writer.append("wojewodztwo" + i % 32);
            writer.append(",");
            writer.append("kraj" + i % 1);
            writer.append(",");
            writer.append(String.valueOf(i % 100));
            writer.append(",");
            writer.append(String.valueOf((i * 1000 + 500) % 10000));
            writer.append("\n");
        }
        writer.close();


        writer = new BufferedWriter(new FileWriter("produkt_ekspozycjaMP.csv", true));
        writer.append("produktID,ekspozycjaID,data_rozpoczecia,data_zakonczenia\n");
        for (int i = 0; i < ileProduktow; i++) {

            writer.append(String.valueOf(i % ileProduktow));
            writer.append(",");
            writer.append(String.valueOf(i % ileFormEkspozycji));
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
            writer.append("\n");
        }
        writer.close();

        writer = new BufferedWriter(new FileWriter("produktMP.csv", true));
        writer.append("produktID,nazwa,producent,marka,model,rodzaj,kategoria,cena,marza_zawarta\n");
        for (int i = 0; i < ileProduktow; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append("nazwa" + i % 100);
            writer.append(",");
            writer.append("producent" + i % 100);
            writer.append(",");
            writer.append("marka" + i % 100);
            writer.append(",");
            writer.append("model" + i % 100);
            writer.append(",");
            writer.append("rodzaj" + i % 100);
            writer.append(",");
            writer.append("kategoria" + i % 100);
            writer.append(",");
            writer.append(String.valueOf(i % 100 + 300));
            writer.append(",");
            writer.append(String.valueOf((round(i % 100 + 300) * 0.3*Math.random() * 100) / 100));
            writer.append("\n");
        }
        writer.close();

        writer = new BufferedWriter(new FileWriter("magazynMP.csv", true));
        writer.append("sklepID, produktID, ilosc, czas\n");
        for (int i = 0; i < ileStanowMagazynowych; i++) {
            writer.append(String.valueOf(i % ileSklepow));
            writer.append(",");
            writer.append(String.valueOf(i % ileProduktow));
            writer.append(",");
            writer.append(String.valueOf((i % 10) * 10));
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
        writer.close();

        writer = new BufferedWriter(new FileWriter("zakupMP.csv", true));
        writer.append("id,sklepID,data,typ_platnosci,kasaID,pracownikID\n");
        for (int i = 0; i < ileZakupow; i++) {
            writer.append(String.valueOf(i));
            writer.append(",");

            writer.append(String.valueOf(i % ileSklepow));
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
            writer.append(",");
            writer.append(String.valueOf(i));
            writer.append(",");
            writer.append(String.valueOf(i));
            writer.append("\n");
        }
        writer.close();


        writer = new BufferedWriter(new FileWriter("zakup_produktMP.csv", true));
        writer.append("zakupID,produktID,ilosc\n");
        for (int i = 0; i < ileZakupow; i++) {
            writer.append(String.valueOf(i % ileZakupow));
            writer.append(",");
            writer.append(String.valueOf(i % ileProduktow));
            writer.append(",");
            writer.append(String.valueOf((i % 10) + 1));
            writer.append("\n");
        }
        writer.close();


        writer = new BufferedWriter(new FileWriter("reklamacjaMP.csv", true));
        writer.append("produktID,pracownikID,data,kasaID,zakupID,ilosc\n");
        for (int i = 0; i < ileReklamacji; i++) {
            if (i % 2 == 0) {
                writer.append(String.valueOf(i % ileProduktow));
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
                writer.append(String.valueOf(i));
                writer.append(",");
                writer.append(String.valueOf(i % ileZakupow));
                writer.append(",");
                writer.append(String.valueOf(i + 1));
                writer.append("\n");
            }
        }
        writer.close();
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