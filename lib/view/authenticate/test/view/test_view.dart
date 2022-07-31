import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/base/state/base_state.dart';
import 'package:flutter_mvvm_template/core/base/view/base_widget.dart';
import 'package:flutter_mvvm_template/view/authenticate/test/viewmodel/text_view_model.dart';

class TestsView extends StatefulWidget {
  const TestsView({Key? key}) : super(key: key);

  @override
  BaseState<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends BaseState<TestsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TestViewModel>(
        viewModel: TestViewModel(),
        onPageBuilder: (context, value) => Text("data"));
  }
}
