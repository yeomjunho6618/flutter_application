// library
import 'package:flutter/material.dart';

// ChangeNotifier: class안에 변화를 감지
// with : ChangeNotifier의 기능을 ExampleModel에 추가
class ExampleModel with ChangeNotifier {
  int counter = 0;

  increaseCount() {
    counter++;
    debugPrint('[ExampleModel counter] = $counter');
    notifyListeners();
  }
}