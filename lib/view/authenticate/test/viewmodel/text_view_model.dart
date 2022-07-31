import 'package:mobx/mobx.dart';
part "test_view_model.g.dart";

class TestViewModel = _TestViewModelBase with _$TestViewModel;

abstract class _TestViewModelBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

