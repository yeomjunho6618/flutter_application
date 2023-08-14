import 'package:flutter/material.dart';
import 'package:flutter_application/models/trade_repository.dart';

// trade['TRADE-DATA']
class TradeDataProvider with ChangeNotifier {
  // api 호출할 친구
  final AjaxTradeData _ajaxTradeData = AjaxTradeData();
  Map<String, dynamic> _tradeData = {};
  Map<String, dynamic> get tradeData => _tradeData;

  void getApiTradeData() async {
    var response = await _ajaxTradeData.get();
    setTradeData(response.data);
  }

  void setTradeData(Map<String, dynamic> date) {
    _tradeData = date;

    // 데이터 업데이트가 되었다! 구독자에게 알림.
    notifyListeners();
  }
}

// trade['QUOTE']
class QuoteProvider with ChangeNotifier {
  // api 호출할 친구
  final AjaxQuote _ajaxQuote = AjaxQuote();
  Map<String, dynamic> _quote = {};
  Map<String, dynamic> get quote => _quote;

  void getApiQuote() async {
    Map<String, dynamic> quote = await _ajaxQuote.get();

    setQuote(quote);
  }

  void setQuote(Map<String, dynamic> date) {
    _quote = quote;
    // 데이터 업데이트가 되었다! 구독자에게 알림.
    notifyListeners();
  }
}
