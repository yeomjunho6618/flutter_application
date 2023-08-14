// file을 가져오기 위해 사용
import 'dart:io';
import 'package:flutter_application/providers/intro_provider.dart';
/** 
 * image file추가 하는 plugin
 * 
 * ios: ios -> Runner -> info.plist에 속성 추가 필요
 * (NSCameraUsageDescription, NSMicrophoneUsageDescription, NSPhotoLibraryUsageDescription, UILaunchStoryboardName)
 * */
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application/helper/constants/constants.dart';
import 'package:flutter_application/providers/example_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // image 추가
  final picker = ImagePicker();
  XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  // floationgActionButton click
  void _incrementCounter() {
    // root에 있는 ExampleModel 안에 함수 실행.
    context.read<ExampleModel>().increaseCount();

    // root에서 내려오는 setState에 저장
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // root model을 가져옵니다.
    final model = context.read<IntroProvider>();
    // root model에서 변수값 가져오기.
    final Map<String, dynamic> introData = model.getItroData;
    final apiCall =
        context.select<IntroProvider, int>((procider) => procider.apiCall);

    debugPrint('[home][][][] $introData');
    debugPrint('$apiCall');

    return Scaffold(
      // 상단 바
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('hi'),
        centerTitle: true, // title bar text 중앙정렬
        backgroundColor: Colors.deepOrange, // title bg color
        elevation: 3, // title bar가 떠있는 그림자 위치값
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            debugPrint(':) menu click');
          }, // event 함수
        ), // [왼쪽] 아이콘 넣을때사용
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              debugPrint(':) shopping_cart click');
              context.go(ERoutes.PAGE1);
              //Navigator.of(context).pushNamed('/page1');
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Page1()));
            },
          ), // 아이콘 넣을때사용
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              debugPrint(':) search click');
            },
          ), // [오른쪽] 아이콘 넣을때사용
        ],
      ),

      // 내용
      body: ListView(
        //backgroundColor: Colors.amber,
        //body: Center(
        padding: const EdgeInsets.fromLTRB(30, 40, 10, 40),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                  tag: 'Hero',
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 58.0,
                    child: Image.asset('assets/img/test.png'),
                  )),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: '이메일', border: OutlineInputBorder()),
              ),
              Column(children: [
                // 이미지
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/img/test.png'),
                    radius: 60,
                  ),
                ),

                // 회색줄
                Divider(
                  height: 60,
                  color: Colors.grey[850],
                  thickness: 0.5,
                  endIndent: 30,
                ),

                // 글씨
                const Text(
                  ' ssssave pushed the button this many times:',
                ),
                Text('$_counter',
                    // Theme.of(context).textTheme.headlineMedium,
                    style: const TextStyle(
                        color: Colors.black12, letterSpacing: 2.0)),

                // 빈공간
                const SizedBox(height: 20),
                const Text('rrr'),
                const SizedBox(height: 30),
              ]),

              // 가로 정렬
              const Row(
                children: [
                  Icon(Icons.check_circle_outline),
                  SizedBox(width: 20),
                  Text('junsss', style: TextStyle(fontSize: 16)),
                ],
              ),

              // 가로 정렬
              const Row(
                children: [
                  Icon(Icons.check_circle_outline),
                  SizedBox(width: 20),
                  Text('jun2ddd', style: TextStyle(fontSize: 16)),
                ],
              ),

              // 가운대 정렬
              Center(
                // 원형이미지 출력
                child: CircleAvatar(
                  backgroundImage: const AssetImage('assets/img/test.png'),
                  radius: 40,
                  backgroundColor: Colors.amber[800],
                ),
              ),

              //카메라로 촬영하기
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: IconButton(
                      onPressed: () async {
                        image =
                            await picker.pickImage(source: ImageSource.camera);
                        //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                        if (image != null) {
                          setState(() {
                            images.add(image);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.white,
                      ))),

              //갤러리에서 가져오기
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: IconButton(
                      onPressed: () async {
                        multiImage = await picker.pickMultiImage();
                        setState(() {
                          //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                          images.addAll(multiImage);
                        });
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 30,
                        color: Colors.white,
                      ))),

              // 사진보여주기
              Container(
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount:
                      images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                    childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                    mainAxisSpacing: 10, //수평 Padding
                    crossAxisSpacing: 10, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit:
                                      BoxFit.cover, //사진 크기를 Container 크기에 맞게 조절
                                  image: FileImage(File(images[index]!
                                          .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                      )))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //삭제 버튼
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 15),
                            onPressed: () {
                              //버튼을 누르면 해당 이미지가 삭제됨
                              setState(() {
                                images.remove(images[index]);
                              });
                            },
                          ),
                        ),
                        Row(children: [Text('$index')])
                      ],
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),

      // 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      // bottomNavigationBar: 바텀 네비게이션 바입니다.
      // drawer: 서랍입니다.
      // persistentFooterButtons: 영구적인 푸터 버튼입니다.
      // backgroundColor: 배경색입니다.
      // elevation: 앱바, 바텀 네비게이션 바, 플로팅 액션 버튼의 높이입니다.
      // floatingActionButtonLocation: 플로팅 액션 버튼의 위치입니다.
      // drawerScrimColor: 서랍의 스크림 색입니다.
      // drawerEdgeDragWidth: 서랍을 드래그할 수 있는 너비입니다.
      // resizeToAvoidBottomInset: 바텀 네비게이션 바가 화면 하단에 겹치지 않도록 조정하는 여부입니다.
      // scaffoldMessenger: Scaffold 위젯에서 발생하는 메시지를 처리하는 객체입니다.
    );
  }
}
