import 'package:flutter/material.dart';
import 'package:flutter_application/models/intro_repository.dart';

// intro['INTRO']
class IntroProvider with ChangeNotifier {
  // api 호출할 친구
  final AjaxIntro _ajaxIntro = AjaxIntro();
  Map<String, dynamic> _introData = {};
  Map<String, dynamic> get getItroData => _introData;

  // test
  int apiCall = 0;
  Map<String, dynamic> introDataTest = {};

  Future<void> getApiIntro() async {
    var response = await _ajaxIntro.get();
    setIntroData(response.data);
  }

  void setIntroData(data) {
    _introData = data;
    introDataTest = data;
    apiCall += 1;

    debugPrint('setIntroData = $apiCall');
    // 데이터 업데이트가 되었다! 구독자에게 알림.
    notifyListeners();
  }
}
