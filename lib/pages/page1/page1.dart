import 'package:flutter/material.dart';
import 'package:flutter_application/providers/intro_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application/providers/example_provider.dart';
import 'package:flutter_application/helper/constants/constants.dart';

//import 'package:flutter_application/pages/page2/page2.dart';
// ignore: must_be_immutable
class Page1 extends StatelessWidget implements IPage1 {
  @override
  String coinType = '123';
  Page1({super.key, coinType});

  @override
  Widget build(BuildContext context) {
    // root model을 가져옵니다.
    final model = Provider.of<ExampleModel>(context);
    // root model에서 변수값 가져오기.
    final int exampleCounter = model.counter;

    // root model을 가져옵니다.
    final model2 = Provider.of<IntroProvider>(context);
    // root model에서 변수값 가져오기.
    final Map<String, dynamic> introData = model2.getItroData;

    debugPrint('[page1][][][] $introData');

    return Scaffold(
        body: Center(
            child: Column(children: [
      Row(children: [
        OutlinedButton(
          onPressed: () {
            context.go(ERoutes.PAGE2);
            //Navigator.of(context).pushNamed(ERoutes.PAGE2);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const Page2()));
          },
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text('Click Button11111'),
        ),
      ]),
      Row(children: [Text('page1 ㅁㄴㅇㅁㄴㅇ = $exampleCounter')])
    ]))

        // child: body 속성의 자식 위젯입니다.
        // decoration: body 속성의 배경 장식입니다.
        // padding: body 속성의 여백입니다.
        // constraints: body 속성의 제약 조건입니다.
        // margin: body 속성의 여백입니다.
        );
  }
}

// page1 interface
class IPage1 {
  String coinType = '';
}
