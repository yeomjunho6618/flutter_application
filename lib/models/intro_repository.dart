// service
import 'package:flutter_application/services/http_service.dart';
import 'package:flutter_application/helper/constants/api_path.dart';

class AjaxIntro {
  Future<dynamic> get() async {
    final response = await getEx(intro['INTRO']!);

    return response;
  }
}
