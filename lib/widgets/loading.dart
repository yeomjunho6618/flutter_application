import 'package:flutter/material.dart';

// loading
class Loading extends StatelessWidget {
  const Loading(this.isLoading, this.child, {super.key}); // 기본 생성자 추가

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Text('Loading...'));
    }

    return child;
  }
}
