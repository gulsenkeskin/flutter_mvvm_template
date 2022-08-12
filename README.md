# flutter_mvvm_template

Dependencies:


mobx: MobX, uygulamanızın reaktif verilerini kullanıcı arayüzüne bağlamayı kolaylaştıran bir state yönetimi kitaplığıdır.


MOBX İÇİN ÜÇ ÖNEMLİ KAVRAM


-Observables


-Reaction


-Action


Observables: Observables uygulamanızın rektif durumunu temsil eder. Uygulamanın durumunu observables ağacı olarak tanımlayarak UI'ın ya da uygulamadaki diğer observer'ların tükettiği(consume) bir reactive-state-tree ortaya çıkarabilirsiniz.


Readonly: Kodunuzu azaltmak istiyorsanız, @observable yerine @readonly kullanabilirsiniz.Her private değişken için, store'un client'ının değerini değiştiremeyeceği şekilde bir public getter oluşturur.

Uygulamanızın durumu core-state (temel durum) ve derived-state'den (türetilmiş durum) oluşur.
Örneğin bir Contact entity'e sahip olduğunuzu düşünürsek: firstName ve lastName  ilgili contact'ın core-state'ini oluşturur.
Ancak fullName derived-state dşr ve firstName ve lastName birleştirilerek elde edilir.


derived-state'e ve core-state e bağlı olan bu tür derived-state'e Computed Observable denir. Temeldeki observables değiştiğinde otomatik olarak senkronize tutulur.


State in MobX = Core-State + Derived-State


```
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Contact = ContactBase with _$Contact;

abstract class ContactBase with Store {
  @observable
  String firstName;

  @observable
  String lastName;

  @computed
  String get fullName => '$firstName, $lastName';

}
```

Yukarıdaki örnekte, firstName  ve/veya lastName değişirse fullName otomatik olarak eşitlenir.


Actions:
Actions observable'ları nasıl değiştirdiğinizdir. Örneğin, yalnızca value++ yapmak yerine, bir increment() eylemini başlatmak daha fazla anlam taşır. Actions tüm bildirimleri toplar ve değişikliklerin ancak tamamlandıktan sonra bildirilmesini sağlar. Böylece observables sadece eylemin otomatik olarak tamamlanması üzerine bilgilendirilir.

Action'ların iç içe olabileceğini unutmayın bu gibi bir durumda en üstteki action tamamlandığında bildirimler gönderilir.

```

final counter = Observable(0);

final increment = Action((){
  counter.value++;
});
```

bir sınıf içinde action oluşturma örneği


```
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
```


Reactions:

Tepkiler, MobX'in observables, actions ve reactions üçlüsünü tamamlar.
Reaction'lar , reaktif sistemin observer'larıdırlar ve izledikleri bir observer değiştiğinde haberdar olurlar.


ReactionDisposer=> reaktion'ı ortadan kaldırmak için çağrılır


ReactionDisposer autorun(Function(Reaction) fn)




Reaction'lar tüm observable'ları otomatik olarak izler.
```
import 'package:mobx/mobx.dart';

final greeting = Observable('Hello World');

final dispose = autorun((_){
  print(greeting.value);
});

greeting.value = 'Hello MobX';

// Done with the autorun()
dispose();


// Prints:
// Hello World
// Hello MobX
```

ReactionDisposer reaction<T>(T Function(Reaction) fn, void Function(T) effect)

fn() işlevi içinde kullanılan observable'ları izler ve fn() işlevi farklı bir değer döndürdüğünde effect()'i çalıştırır. Yalnızca fn() içindeki observable'lar izlenir.


```
import 'package:mobx/mobx.dart';

final greeting = Observable('Hello World');

final dispose = reaction((_) => greeting.value, (msg) => print(msg));

greeting.value = 'Hello MobX'; // Cause a change

// Done with the reaction()
dispose();


// Prints:
// Hello MobX
```

ReactionDisposer when(bool Function(Reaction) predicate, void Function() effect)


Predicate() içinde kullanılan observable'ları izler ve true döndüğünde effect()'i çalıştırır. Efekt() çalıştırıldıktan sonra, otomatik olarak kendini yok eder.

```
import 'package:mobx/mobx.dart';

final greeting = Observable('Hello World');

final dispose = when((_) => greeting.value == 'Hello MobX', () => print('Someone greeted MobX'));

greeting.value = 'Hello MobX'; // Causes a change, runs effect and disposes


// Prints:
// Someone greeted MobX
```

Future<void> asyncWhen(bool Function(Reaction) predicate)


Future'a benzer, ancak predicate() true döndürdüğünde yerine getirilen bir Future döndürür.Bu, predicate() true olmasını beklemenin uygun bir yoludur.


```
final completed = Observable(false);

void waitForCompletion() async {
  await asyncWhen(() => _completed.value == true);

  print('Completed');
}
```



Observer

Observer widget'ı (flutter_mobx paketinin bir parçasıdır), builder fonksiyonunda kullanılan observable'ların ayrıntılı bir observer'ını sağlar.



```
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({Key key}) : super(key: key);

  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Observer(
                  builder: (_) => Text(
                        '${_counter.value}',
                        style: const TextStyle(fontSize: 20),
                      )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}


```


























