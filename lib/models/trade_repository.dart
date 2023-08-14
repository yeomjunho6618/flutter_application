// service
import 'package:flutter_application/services/http_service.dart';
import 'package:flutter_application/helper/constants/api_path.dart';

class AjaxTradeData {
  // api trade-data
  String? url =
      '${trade['TRADE-DATA']}?/coin=ALL&crncCd=C0100&crncCd=C0101&lists=%7B%22ticker%22%3A%7B%22coinType%22%3A%22ALL%22%2C%22tickType%22%3A%22MID%22%7D%2C%22transaction%22%3A%7B%22limit%22%3A31%7D%7D&type=custom';

  Future<dynamic> get() async {
    final response = await getPub(url!);

    return response;
  }
}

class AjaxQuote {
  // api quote
  String? url = '${trade['QUOTE']}/C0101-C0100?limit=30';

  Future<dynamic> get() {
    final response = getEx(url!).toJson();

    return response;
  }
}
