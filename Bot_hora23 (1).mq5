//Codigo c++
//Incluir librerias
#include<Trade/Trade.mqh>
//Instanciar 
CTrade trade;
//Declaración de Variables
ulong trade_ticket = 0;
//Lista de velas
MqlRates candles[];
//bandera
bool time_flag = true;

double get_lotage(){
   /*
      balance:
   */
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   /*
      lotage:cantidad de dinero a invertir
   */
   double lotage = NormalizeDouble((balance/100)*0.01,2);
   return lotage <=50 ? lotage : 50;
}

void OnInit(){
   ArraySetAsSeries(candles, true);
}

bool alcista(int pos){
   return candles[pos].close-candles[pos].open > pos;
}

void OnTick() {

  MqlDateTime time;
  TimeCurrent(time);
  
  if (
    time.hour < 22 || 
    time.min < 58 ||
    time.min >= 59 ||
    time.sec < 59 ||
    time.sec < 58 ||
    time.hour >= 23 ||
    (time.hour == 22 && time.min == 58 && time.sec == 57) )
    return;
    
    Print("En hora");
    OnEntryTick();
}


void OnEntryTick() {
   CopyRates(_Symbol, _Period, 0, 3, candles);
   
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   
   trade.Sell(get_lotage(), _Symbol, bid);
   
   /*
   if (alcista(1) && !alcista(0) && trade_ticket <=0 && time_flag) {
   
    double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   
    trade.Sell(get_lotage(), _Symbol, bid);
   
   }
   */
}