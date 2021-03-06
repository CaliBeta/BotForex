//+------------------------------------------------------------------+
//|                                                Interface_bot.mq4 |
//|                                       Copyright 2020, CaliBetaFX |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, CaliBetaFX"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|             Variables globales necesarias                        |
//+------------------------------------------------------------------+
string font1 = "Arial Rounded MT Bold";

double balance;   //Balance de la cuenta
double equity;    //Equidad de la cuenta
double spread;    //Spread del Broker

color cBal = clrDodgerBlue;   //Color para mostrar el balance
color cEqu = clrLimeGreen;    //Color para mostrar la equidad
color cSpr = clrDarkOrange;   //Color para mostrar el spread

short iXpos = 50; //Posicion inicial en X de la interface grafica
short iYpos = 25; //Posicion inicial en Y de la interface grafica
short fSize = 12; //Tamaño de fuente para datos de la cuenta
//+------------------------------------------------------------------+
//|            Funcion de inicio del Script                          |
//+------------------------------------------------------------------+
void OnStart(){
   balance = NormalizeDouble(AccountBalance(), 2);
   equity = NormalizeDouble(AccountEquity(), 2);
   spread = MarketInfo(NULL,MODE_SPREAD); //(Ask - Bid) / Point;
   
   string dbl2str = DoubleToStr(balance, 2);
   string msg_1 = "Balance: " + dbl2str;
   dbl2str = DoubleToStr(equity, 2);
   string msg_2 = "Equity: " + dbl2str;
   dbl2str = DoubleToStr(spread, Digits - 4);
   string msg_3 = "Spread: " + dbl2str;
   
   //Comprara la equidad con el balance para indicar si la cuenta es saludable
   if(equity/balance>0.9)cEqu = clrLimeGreen;
   else if(equity/balance>0.75)cEqu = clrYellowGreen;
   else if(equity/balance>0.6)cEqu = clrGold;
   else if(equity/balance>0.45)cEqu = clrOrangeRed;
   else if(equity/balance>0.3)cEqu = clrCrimson;
   else cEqu = clrRed;
         
   graficText("balance", iXpos, iYpos, font1, fSize, msg_1, cBal);
   graficText("equity", iXpos, iYpos + 20, font1, fSize, msg_2, cEqu);
   graficText("spread", iXpos, iYpos + 40, font1, fSize, msg_3, cSpr);

   Sleep(1000);
}
//+------------------------------------------------------------------+
//|                  Funcion graficar texto                          |
//+------------------------------------------------------------------+
void graficText(string name, int xPos,int yPos, string font, int size, string text, color colTxt){
   ObjectDelete(name);
   ObjectCreate(name, OBJ_LABEL, 0, 0, 1.0);
   ObjectSet(name, OBJPROP_CORNER, 1);   //Esquina superior izquierda
   ObjectSet(name, OBJPROP_XDISTANCE, xPos);
   ObjectSet(name, OBJPROP_YDISTANCE, yPos);
   ObjectSetText(name, text, size, font, colTxt);
}
//+------------------------------------------------------------------+