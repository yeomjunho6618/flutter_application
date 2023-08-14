// library
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
// service
import 'package:flutter_application/pages/page3/list.dart';

import '../../helper/constants/constants.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        OutlinedButton(
          onPressed: () {
            context.go(ERoutes.ROOT_HOME);
          },
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text('Click Button333333'),
        ),
      ]),
      Row(children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text('Click Button'),
        ),
      ]),
      const Row(children: [Text('page3 ==> ')]),
      const ListWidget()
    ]);
  }
}
