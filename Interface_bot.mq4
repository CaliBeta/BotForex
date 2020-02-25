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

color cBal = clrDodgerBlue;   //Color para mostrar el balance
color cEqu = clrDodgerBlue;   //Color para mostrar la equidad

short iXpos = 50; //Posicion inicial en X de la interface grafica
short iYpos = 25; //Posicion inicial en Y de la interface grafica
short fSize = 12; //Tamaño de fuente para datos de la cuenta
//+------------------------------------------------------------------+
//|            Funcion de inicio del Script                          |
//+------------------------------------------------------------------+
void OnStart(){
   balance = NormalizeDouble(AccountBalance(), 2);
   equity = NormalizeDouble(AccountEquity(), 2);
   string dbl2str_1 = DoubleToStr(balance, 2);
   string dbl2str_2 = DoubleToStr(equity, 2);
   string msg_1 = "Balance: " + dbl2str_1;
   string msg_2 = "Equity: " + dbl2str_2;
   
   if(equity/balance>0.85){
      cEqu = clrDodgerBlue;
   }
   else if(equity/balance>0.7){
      cEqu = clrDeepSkyBlue;
   }
   else if(equity/balance>0.55){
      cEqu = clrGold;
   }
   else if(equity/balance>0.4){
      cEqu = clrOrangeRed;
   }
   else if(equity/balance>0.25){
      cEqu = clrCrimson;
   }
   else{ 
      cEqu = clrRed;
   }
      
   graficText("balance", iXpos, iYpos, font1, fSize, msg_1, cBal);
   graficText("equity", iXpos, iYpos + 20, font1, fSize, msg_2, cEqu);

   Sleep(1000);
}
//+------------------------------------------------------------------+
//|                  Funcion graficar texto                          |
//+------------------------------------------------------------------+
void graficText(string nombre, int xPos,int yPos, string font, int size, string text, color colTxt){
   ObjectDelete(nombre);
   ObjectCreate(nombre, OBJ_LABEL, 0, 0, 1.0);
   ObjectSet(nombre, OBJPROP_CORNER, 1);   //Esquina superior izquierda
   ObjectSet(nombre, OBJPROP_XDISTANCE, xPos);
   ObjectSet(nombre, OBJPROP_YDISTANCE, yPos);
   ObjectSetText(nombre, text, size, font, colTxt);
}
//+------------------------------------------------------------------+