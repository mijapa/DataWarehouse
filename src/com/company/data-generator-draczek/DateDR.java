package com;

import java.time.YearMonth;
import java.util.Calendar;
import java.util.Random;

public class DateDR {
    int sekundy = 0;
    int minuty = 0;
    int godziny = 0;

    int dzien = 1;
    int miesiac = 1;
    int rok = 0;

    public DateDR() {
       this.sekundy = losujSekundy();
        this.minuty = losujMinuty();
        this.godziny = losujGodziny();
        this.rok = losujRok();
        this.miesiac = losujMiesiac();
        this.dzien = losujDzien(this.rok, this.miesiac);
    }

    public DateDR(DateDR staraData, int liczbaDni) {
        this.sekundy = losujSekundy();
        this.minuty = losujMinuty();
        this.godziny = losujGodziny();
        this.rok = staraData.rok;
        this.miesiac = staraData.miesiac;
        this.dzien = staraData.dzien;

        ustalAktualnaDate(liczbaDni);
    }

    private void ustalAktualnaDate(int liczbaDni) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.MONTH, this.miesiac);
        c.set(Calendar.DATE, this.dzien);
        c.set(Calendar.YEAR, this.rok);

        c.add(Calendar.DATE, liczbaDni);

        this.rok = c.get(Calendar.YEAR);
        this.miesiac =  c.get(Calendar.MONTH);
        this.dzien = c.get(Calendar.DATE);
    }

    private int losujRok() {
        return new Random().nextInt(10) + 1990;
    }

    private int losujDzien(int rok, int miesiac) {
        YearMonth yearMonthObject = YearMonth.of(rok, miesiac);
        return new Random().nextInt(yearMonthObject.lengthOfMonth()) + 1;
    }

    private int losujMiesiac() {
        return new Random().nextInt(12) + 1;
    }

    private int losujSekundy() {
        return new Random().nextInt(60);
    }

    private int losujMinuty() {
        return new Random().nextInt(60);
    }

    private int losujGodziny() {
        return new Random().nextInt(13) + 8;
    }

    public String getDateYYYY_MM_DD(){
        String date = "";

        date += (rok + "-");

        if(miesiac < 10) date += "0";
        date += (miesiac + "-");

        if(dzien < 10) date += "0";
        date += dzien;

        return date;
    }

    public String getDateYYYY_MM_DD_HH_MM_SS(){
        String date = "";

        date += (rok + "-");

        if(miesiac < 10) date += "0";
        date += (miesiac + "-");

        if(dzien < 10) date += "0";
        date += (dzien + " ");

        if(godziny < 10) date += "0";
        date += (godziny + ":");

        if(minuty < 10) date += "0";
        date += (minuty + ":");

        if(sekundy < 10) date += "0";
        date += sekundy;

        return date;
    }
}
