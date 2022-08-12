import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mvvm_template/core/base/state/base_state.dart';
import 'package:flutter_mvvm_template/core/base/view/base_widget.dart';
import 'package:flutter_mvvm_template/view/authenticate/test/viewmodel/test_view_model.dart';
import 'package:mobx/mobx.dart';

class TestsView extends StatefulWidget {
  const TestsView({Key? key}) : super(key: key);

  @override
  BaseState<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends BaseState<TestsView> {
  TestViewModel? viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<TestViewModel>(
        viewModel: TestViewModel(),
        onModelReady: (model) {
          viewModel = model;
        },
        onPageBuilder: (context, value) => Text("data"));
  }

  //get hızlı set işlemi olmadığı için işlevi sadece ekrana çizmek
  Widget get scaffoldBody => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => viewModel?.incrementNumber(),
        ),
        body: textNumber,
      );

  Widget get textNumber {
    return Observer(
      builder: (context) => Text(viewModel?.number.toString() ?? ""),
    );
  }
}
