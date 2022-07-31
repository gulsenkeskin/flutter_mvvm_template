import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/base/state/base_state.dart';

class TestsView extends StatefulWidget {
  const TestsView({Key? key}) : super(key: key);

  @override
  BaseState<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends BaseState<TestsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: dynamicHeight(0.1),
      color: themeData.primaryColor,
      child: const Placeholder(

      ),

    );
  }
}
