package com;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

public class Main {

    private static int maxDniDoZwrotu = 14;

    private static int ileProduktow = 2000;
    private static int ileSklepow = 250;
    private static int maxPrzechowanychProduktow = 30;
    private static int ilehistoryczniePrzechowanychDanych = 15;
    private static int ileRodzajiEkspozycji = 300;
    private static int ileTransakcji = 1000 * 1000;
    private static int maxIloscRoznychProduktowNaTransakcje = 10;
    private static int iloscZakupionegoTowaru = 10;
    private static int procentZwrotow = 20;
    private static int ileOpisowEkspozycji = 10;


    public static void main(String[] args) {
        try {
            produktCSV();
            sklepCSV();
            produktSklepCSV();
            ekspozycjaCSV();
            ekspozycjaProduktCSV();
            zamowienieZwrotyProuktCSV();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void zamowienieZwrotyProuktCSV() throws IOException {

        BufferedWriter writerOrder = new BufferedWriter(new FileWriter("dr_order.csv", true));
        writerOrder.append("\"ORDER_ID\",\"STORE_ID\",\"PAYMENT_METHOD\",\"TIME\"");

        BufferedWriter writerOrderedProdukt= new BufferedWriter(new FileWriter("dr_ordered_product.csv", true));
        writerOrderedProdukt.append("\"PRODUCT_ID\",\"ORDER_ID\",\"QUANTITY\"");

        BufferedWriter writerReturn = new BufferedWriter(new FileWriter("dr_return.csv", true));
        writerReturn.append("\"PRODUCT_ID\",\"ORDER_ID\",\"TIME\",\"Qty\"");

        for (int i = 0; i < ileTransakcji; i++) {
            DateDR dataZakupu = new DateDR();

            writerOrder.append("\n\"" + i + "\",");
            writerOrder.append("\"" + (losuj(ileSklepow)-1) + "\",");

            writerOrder.append("\"" + pobierzRodzajPlatnosci() + "\",");
            writerOrder.append("\"" + dataZakupu.getDateYYYY_MM_DD_HH_MM_SS() + "\"");

            //--------------------------------
            int wylosowanyProdukt = 0;
            int liczbaSztuk = 0;
            for (int k = 0; k < maxIloscRoznychProduktowNaTransakcje; k++){
                int rozrzutProduktow = ileProduktow/maxIloscRoznychProduktowNaTransakcje;
                if(rozrzutProduktow < 1) rozrzutProduktow = 1;

                wylosowanyProdukt += losuj(rozrzutProduktow);
                writerOrderedProdukt.append("\n\"" + (wylosowanyProdukt-1) + "\",");
                writerOrderedProdukt.append("\"" + i + "\",");
                liczbaSztuk = losuj(iloscZakupionegoTowaru);
                writerOrderedProdukt.append("\"" + liczbaSztuk + "\"");

                if(losuj(100) <= procentZwrotow){
                    writerReturn.append("\n\"" + wylosowanyProdukt + "\",");
                    writerReturn.append("\"" + i + "\",");
                    writerReturn.append("\"" + new DateDR(dataZakupu, maxDniDoZwrotu).getDateYYYY_MM_DD_HH_MM_SS() + "\",");
                    writerReturn.append("\"" + losuj(liczbaSztuk) + "\"");
                }
            }
        }
        writerOrder.close();
        writerReturn.close();
        writerOrderedProdukt.close();
    }

    private static String pobierzRodzajPlatnosci() {
        int wartosc = losuj(100);
        if (wartosc <= 45) {
            return "CARD";
        } else if (wartosc <= 80) {
            return "CASH";
        } else {
            return "LOAN";
        }
    }

    private static void ekspozycjaProduktCSV() throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter("dr_exposure_product.csv", true));
        writer.append("\"EXPOSURE_ID\",\"PRODUCT_ID\",\"START_EXPOSURE\",\"END_EXPOSURE\"");

        for (int i = 0; i < ileRodzajiEkspozycji; i++) {
            for (int j=0; j < ileProduktow; j++){
                DateDR dataPoczatkowa = new DateDR();

                writer.append("\n\"" + i + "\",");
                writer.append("\"" + j + "\",");

                writer.append("\"" + dataPoczatkowa.getDateYYYY_MM_DD() + "\",");
                writer.append("\"" + new DateDR(dataPoczatkowa, 0).getDateYYYY_MM_DD() + "\"");
            }
        }
        writer.close();
    }

    private static void ekspozycjaCSV() throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter("dr_exposure.csv", true));
        writer.append("\"EXPOSURE_ID\",\"DESCRIPTION\",\"FLAG\",\"DISCOUNT_\"");

        for (int i = 0; i < ileRodzajiEkspozycji; i++) {
            int procentowaZnizka = nowaZnizka();

            writer.append("\n\"" + i + "\",");
            writer.append("\"" + losuj(ileOpisowEkspozycji) + "\",");
            writer.append("\"" + losuj(1) + "\",");
            writer.append("\"" + procentowaZnizka + "\"");
        }
        writer.close();
    }

    private static int nowaZnizka() {
        if(new Random().nextInt(100) < 30) return new Random().nextInt(30);
        else return 0;
    }

    private static void produktSklepCSV() throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter("dr_stored_product.csv", true));
        writer.append("\"STORE_ID\",\"PRODUCT_ID\",\"QUANTITY\",\"DATE\"");

        DateDR dataInwnetaryzacji;
        for (int i = 0; i < ileSklepow; i++) {
            for (int j = 0; j < ileProduktow; j++){
                dataInwnetaryzacji = new DateDR();
                for(int k = 0; k < ilehistoryczniePrzechowanychDanych; k++){
                    if(k == 0){
                        writer.append("\n\"" + i + "\",");
                        writer.append("\"" + j + "\",");
                        writer.append("\"" + losuj(maxPrzechowanychProduktow) + "\",");

                        //data
                        writer.append("\"" + dataInwnetaryzacji.getDateYYYY_MM_DD() + "\"");
                    }else{
                        dataInwnetaryzacji = new DateDR(dataInwnetaryzacji, losuj(7*2)+14);
                        writer.append("\n\"" + i + "\",");
                        writer.append("\"" + j + "\",");
                        writer.append("\"" + losuj(maxPrzechowanychProduktow) + "\",");

                        //data
                        writer.append("\"" + dataInwnetaryzacji.getDateYYYY_MM_DD() + "\"");
                    }

                }
            }
        }
        writer.close();
    }

    private static void sklepCSV() throws IOException {
        int ileKodowPocztowych = 70;
        int ileUlic = 150;
        int ileNumerowLokali = 40;
        int ileMiast = 15;
        String kraj = "JAPAN";
        int maxdystansOdCentrum = 15;
        int minPotencjalnychKlientow = 25 * 1000;
        int maxPotencjalnychKlientow = 75 * 1000;

        BufferedWriter writer = new BufferedWriter(new FileWriter("dr_store.csv", true));
        writer.append("\"STORE_ID\",\"ZIP_CODE\",\"STREET\",\"APARTMENT_NO\",\"CITY\",\"COUNTRY\",\"DISTANCE_TO_CENTER\",\"POTENTIAL_CUSTOMERS\"");

        for (int i = 0; i < ileSklepow; i++) {
            writer.append("\n\"" + i + "\",");
            writer.append("\"" + "ZIP_CODE_" + i % losuj(ileKodowPocztowych) + "\",");
            writer.append("\"" + "STREET_" + i % losuj(ileUlic) + "\",");
            writer.append("\"" + (i % losuj(ileNumerowLokali)) + "\",");
            writer.append("\"" + "CITY_" + i % losuj(ileMiast) + "\",");
            writer.append("\"" + kraj + "\",");
            writer.append("\"" + losuj(maxdystansOdCentrum) + "\",");
            writer.append("\"" + (losuj(maxPotencjalnychKlientow) + minPotencjalnychKlientow) + "\"");

        }
        writer.close();
    }

    private static void produktCSV() throws IOException {
        int ileModeli = 50;
        int ileMarek = 15;
        int ileProducentow = 5;
        int minCena = 420 * 10;
        int maxCena = 140 * 1000;
        int ileTypowProduktu = 40;
        int ileKategoriiPrduktu = 15;
        int ileKrajiProdukcji = 3;

        BufferedWriter writer = new BufferedWriter(new FileWriter("dr_product.csv", true));
        writer.append("\"PRODUCT_ID\",\"MODEL\",\"MARK\",\"MANUFACTURER\",\"PRICE_JPY\",\"PRODUCT_TYPE\",\"CATEGORY\",\"PRODUCTION_COUNTRY\",\"DESCRIPTION\",\"MARGIN\"");

        for (int i = 0; i < ileProduktow; i++) {
            int cenaProduktu = minCena + losuj(maxCena - minCena);
            int marzaZawartaWCenie = ((losuj(20)) + 20)*cenaProduktu/100;

            writer.append("\n\"" + i + "\",");
            writer.append("\"" + "MODEL_" + i % losuj(ileModeli) + "\",");
            writer.append("\"" + "MARK_" + i % losuj(ileMarek) + "\",");
            writer.append("\"" + "MANUFACTURER_" + i % losuj(ileProducentow) + "\",");
            writer.append("\"" + cenaProduktu + "\",");
            writer.append("\"" + "PRODUCT_TYPE_" + i % losuj(ileTypowProduktu) + "\",");
            writer.append("\"" + "CATEGORY_" + i % losuj(ileKategoriiPrduktu) + "\",");
            writer.append("\"" + "PRODUCTION_COUNTRY_" + i % losuj(ileKrajiProdukcji) + "\",");
            writer.append("\"" + "DESCRIPTION_" + i + "\",");
            writer.append("\"" + marzaZawartaWCenie + "\"");

        }
        writer.close();
    }
    private static int losuj(int max){
        return new Random().nextInt(max) + 1;
    }
}
