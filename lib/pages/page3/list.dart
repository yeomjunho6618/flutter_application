import 'package:flutter/material.dart';
import 'package:flutter_application/providers/intro_provider.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  // row
  Widget _row(data) {
    debugPrint('[_row] $data');
    return const Row(children: [
      Expanded(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '123', // data.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ))
    ]);
  }

  // list
  Widget _listView(List<dynamic> data) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 300, color: Colors.white, child: _row(data[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // root model을 가져옵니다.
    final model = Provider.of<IntroProvider>(context);
    // root model에서 변수값 가져오기.
    final Map<String, dynamic> introData = model.getItroData;

    debugPrint('[list][][][] $introData');

    // Provider.of를 통해 데이터를 접근한다. builder만을 업데이트 하기 위해 listen은 false로 한다.
    //_introProvider = Provider.of<IntroProvider>(context, listen: true);
    //debugPrint('/1//// ${_introProvider.introData}');
    return Consumer<IntroProvider>(builder: (context, provider, wideget) {
      // print(provider.introData);
      // 데이터가 있으면 _makeListView에 데이터를 전달
      debugPrint('/2/// ${provider.apiCall}');

      debugPrint('${context.read<IntroProvider>().getItroData}');
      if (provider.getItroData != {} && provider.getItroData.isNotEmpty) {
        //   //return _listView(provider.tradeData);
      }

      // 데이터가 없으면 CircularProgressIndicator 수행(로딩)
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
