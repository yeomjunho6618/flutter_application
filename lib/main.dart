// library
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// service
import 'package:flutter_application/services/socket_service.dart';
import 'package:flutter_application/providers/intro_provider.dart';
import 'package:flutter_application/providers/trade_data_provider.dart';
import 'package:flutter_application/providers/example_provider.dart';
import 'package:flutter_application/config/routes/route.dart';

void main() {
  runApp(MultiProvider(providers: [
    // intro
    ChangeNotifierProvider(create: (_) => IntroProvider()),
    // trade
    ChangeNotifierProvider(create: (_) => TradeDataProvider()),
    // example
    ChangeNotifierProvider(create: (_) => ExampleModel())
  ], child: const MyApp()));
}

// app -> createState
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// app -> initState + provider
class _MyAppState extends State<MyApp> {
  // intro준비완료!
  bool isIntroRead = true;

  // initState에서는 초기 값 설정 (1회만 실행됨)
  @override
  void initState() {
    super.initState();
    debugPrint('[initState] ===============');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getInitData(context).then((_) {
        debugPrint('[initState 준비완료]');

        setState(() {
          isIntroRead = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[MyAppState]');

    // MultiProvider를 통해 여러가지 Provider를 관리
    return MyAppChild(isIntroRead);
  }
}

// ChangeNotifierProvider -> child (사실상 내용)
// ignore: must_be_immutable
class MyAppChild extends StatelessWidget {
  bool isIntroRead;

  MyAppChild(this.isIntroRead, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 애플리케이션의 라우팅 경로입니다. (go_router 안에서 쓰는 router)
      routerConfig: Routes.routers(isIntroRead),

      // 애플리케이션의 제목입니다.
      title: 'test :)',

      // 애플리케이션의 테마입니다.
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.cyan,
        primarySwatch: Colors.green,
      ),

      //  디버그 모드 배너를 표시하는 여부입니다.
      debugShowCheckedModeBanner: false,
    );
  }
}

// init
Future<void> _getInitData(context) async {
  // websocket연결
  final oSocket = WebSocketConnection(wssPublic, eventSink).connect();

  oSocket.then((socket) {
    socket.sink.add(eventSink);
    socket.stream.listen((message) {
      //  debugPrint('[socket message] $message');
    }, onDone: () {
      debugPrint('[socket onDone]');
    }, onError: (error) {
      debugPrint('[socket error] : $error');
    });
  });

  // 초기 api
  Provider.of<ExampleModel>(context, listen: false).increaseCount();
  Provider.of<IntroProvider>(context, listen: false).getApiIntro();
  Provider.of<TradeDataProvider>(context, listen: false).getApiTradeData();
}
