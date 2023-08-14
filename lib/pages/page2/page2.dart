import 'dart:core';
import 'package:flutter_application/providers/intro_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application/providers/example_provider.dart';
import 'package:flutter_application/helper/constants/constants.dart';
//import 'package:flutter_application/pages/page3/page3.dart';

class Page2 extends StatelessWidget implements IPage2 {
  const Page2({super.key});

  @override
  void fnPage2() {
    debugPrint('page2');
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExampleModel>(context);
    final int exampleCounter = model.counter;

    // root model을 가져옵니다.
    final model2 = Provider.of<IntroProvider>(context);
    // root model에서 변수값 가져오기.
    final Map<String, dynamic> introData = model2.getItroData;

    debugPrint('[page2][][][] $introData');

    return Scaffold(
        body: Center(
            child: Column(children: [
      Row(children: [
        OutlinedButton(
          onPressed: () {
            context.push(ERoutes.PAGE3);
            // Navigator.of(context).pushNamed(ERoutes.PAGE3);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const Page3()));
          },
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text('Click Button222222'),
        ),
      ]),
      Row(children: [Text('page2 $exampleCounter')])
    ]))

        // child: body 속성의 자식 위젯입니다.
        // decoration: body 속성의 배경 장식입니다.
        // padding: body 속성의 여백입니다.
        // constraints: body 속성의 제약 조건입니다.
        // margin: body 속성의 여백입니다.
        );
  }
}

// page2 interface
class IPage2 {
  void fnPage2() {}
}
