import 'dart:convert';

// json.decode 하기위해 추가
import 'package:http/http.dart' as http;
import 'package:flutter_application/services/base_host_service.dart';

// http.get 하기위해 추가

// fetchPost() async {
//   // http.get() 메서드를 사용하여 JSONPlaceholder 으로부터 샘플 Post를 가져올 것입니다
//   // http.get() 메서드는 Response를 포함하고 있는 Future를 반환합니다.
//   // Future는 비동기 연산에 사용되는 Dart의 핵심 클래스입니다. Future 객체는 미래의 특정 시점에 사용가능한 잠재적인 값이나 에러를 나타내기 위해 사용됩니다.
//   // http.Response 클래스는 http 요청이 성공했을 때 응답으로 받은 데이터를 갖고 있습니다.
//   const tradeQuote =
//       'https://gw.bithumb.com/exchange/v1/trade/quote/C0101-C0100?limit=30';
//   final response = await http.get(Uri.parse(tradeQuote));

//   if (response.statusCode == 200) {
//     // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // 만약 요청이 실패하면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }

// 네트워크 요청으로부터 받은 데이터를 지니고 있을 Post 클래스를 생성하세요. JSON으로부터 Post를 생성하는 factory 생성자를 포함할 것입니다.
class Post {
  final int status;
  final String code;
  final String message;
  final String data;

  Post(
      {required this.status,
      required this.code,
      required this.message,
      required this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}

getPub(String pUrl) async {
  final response = await http.get(Uri.parse('${BaseHost.hostPub1}$pUrl'));

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return GetPub.fromJson(jsonDecode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('[fetchGet] Failed to load post');
  }
}

getEx(String pUrl) async {
  final response = await http.get(Uri.parse('${BaseHost.hostExchange}$pUrl'));

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return GetEx.fromJson(jsonDecode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('[fetchGet] Failed to load post');
  }
}

// 네트워크 요청으로부터 받은 데이터를 지니고 있을 Post 클래스를 생성하세요. JSON으로부터 Post를 생성하는 factory 생성자를 포함할 것입니다.
//**
// pub1 => data, error, message
// ex => status, code, message, data
// */
class GetEx {
  final int status;
  final String code;
  final String message;
  final Map<String, dynamic> data;

  GetEx(
      {required this.status,
      required this.code,
      required this.message,
      required this.data});

  factory GetEx.fromJson(Map<String, dynamic> json) {
    return GetEx(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class GetPub {
  final String error;
  final String message;
  final dynamic data;

  GetPub({required this.error, required this.message, required this.data});

  factory GetPub.fromJson(Map<String, dynamic> json) {
    return GetPub(
      error: json['error'],
      message: json['message'],
      data: json['data'],
    );
  }
}
