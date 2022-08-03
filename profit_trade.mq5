//+------------------------------------------------------------------+
//|                                                 profit_trade.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+

#include <account_position.mqh>

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
void OnTick()
{
   double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
   
   string signal=entrySignal();
   int type=getOrderType();
   
   Comment("Signal  : "+signal + "\n",
           "I'm in a position of: "+type);
   
   
   //------------------------------------Order buy------------------------------------//
   if(signal=="Hammer_Buy" && PositionsTotal()==0) 
   trade.Buy(0.02,_Symbol,ask,ask-100* _Point,ask+500* _Point,0);
   
   if(entrySignal()=="BullishEngulfing_Buy" && PositionsTotal()==0) 
   trade.Buy(0.02,_Symbol,ask,ask-100* _Point,ask+500* _Point,0);
   
   if(entrySignal()=="Doji_Buy" && PositionsTotal()==0) 
   trade.Buy(0.02,_Symbol,ask,ask-100* _Point,ask+500* _Point,0);

   //------------------------------------Close order buy------------------------------------//  
   if(signal=="CrossDownClose" && getOrderType()==0)
   trade.PositionClose(PositionGetTicket(0));
   
   if(entrySignal()=="Doji_Above_Close" && getOrderType()==0)
   trade.PositionClose(PositionGetTicket(0));
   
   if(entrySignal()=="TurnDown" && getOrderType()==0)
   trade.PositionClose(PositionGetTicket(0));
   
   //------------------------------------Order SELL------------------------------------//
   if(signal=="MorningStar_Sell" && PositionsTotal()==0)
   trade.Sell(0.02,_Symbol,bid,bid+100* _Point,bid-400* _Point,0);
   
   if(entrySignal()=="Doji_Sell" && PositionsTotal()==0)
   trade.Sell(0.02,_Symbol,bid,bid+100* _Point,bid-400* _Point,0);

   //------------------------------------Close order SELL------------------------------------//
   if(signal=="TurnUp" && getOrderType()==1)
   trade.PositionClose(PositionGetTicket(0));

   if(entrySignal()=="HammerClose" && getOrderType()==1)
   trade.PositionClose(PositionGetTicket(0));
   
   if(entrySignal()=="CrossUpClose" && getOrderType()==1)
   trade.PositionClose(PositionGetTicket(0));
}
