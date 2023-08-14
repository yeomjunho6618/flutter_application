import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/loading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application/helper/constants/constants.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:flutter_application/pages/page1/page1.dart';
import 'package:flutter_application/pages/page2/page2.dart';
import 'package:flutter_application/pages/page3/page3.dart';
import 'package:flutter_application/pages/page404/page404.dart';

// 아직 모르겠음.. 왜 rootNaviKey가 있어야 하는지.. 찾아보면 로그인 상태나 이런거관리가 쉽다고 하던대..
final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>();

class Routes {
  Routes._();

  static GoRouter routers(isIntroRead) {
    return GoRouter(
      // 라우터의 네비게이터 키
      navigatorKey: _rootNavKey,
      // 라우터가 시작할 때 로드할 URL
      initialLocation: ERoutes.ROOT,
      // 라우트를 정의
      routes: [
        GoRoute(
            path: ERoutes.ROOT,
            builder: (context, state) {
              return Loading(isIntroRead, const MyHomePage());
            },
            routes: [
              GoRoute(
                path: ERoutes.HOME,
                builder: (context, state) => const MyHomePage(),
              ),
            ]),
        GoRoute(
          // name:
          path: ERoutes.PAGE1,
          builder: (context, state) => Page1(),
          // sub router
          // routes: []
        ),
        GoRoute(
          path: ERoutes.PAGE2,
          builder: (context, state) => const Page2(),
        ),
        GoRoute(
          path: ERoutes.PAGE3,
          builder: (context, state) => const Page3(),
        ),
      ],
      // 라우터에서 예외가 발생할 때 호출
      onException: (context, state, router) => const Page404(),

      // errorPageBuilder: 라우터에서 예외가 발생하고 onException 함수가 호출되지 않을 때 표시되는 페이지를 빌드하는 함수
      // errorBuilder : 라우터에서 예외가 발생하고 onException 함수가 호출되지 않을 때 표시되는 위젯을 빌드하는 함수
      // redirect : 특정 경로로 리디렉션
      // refreshListenable : 라우터가 새로 고쳐질 때 호출되는 리스너
      // redirectLimit : 라우터가 리디렉션할 수 있는 최대 횟수
      // routerNeglect : 라우터가 예외를 무시할지 여부
      // initialExtra : 라우터가 시작할 때 사용할 추가 데이터
      // observers :
      // debugLogDiagnostics : 라우터의 디버그 로그를 활성화
      // restorationScopeId : 라우터의 복원 범위 ID
    );
  }
}
