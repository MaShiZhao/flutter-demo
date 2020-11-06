import 'package:flutter/material.dart';
import 'package:flutter_demo/resources/dimens.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:flutter_demo/widgets/page/service_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServicePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

 void startPage(String carCalculator) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "点击了 $carCalculator");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the HomePage object that was created by
          // the App.build method, and use it to set our appbar title.
            title: Text(Strings.personService,
                style: TextStyle(
                    fontSize: Dimens.fontBarSize, fontWeight: FontWeight.bold)),
            toolbarHeight: Dimens.barHeight,
            elevation: 0),
        body: Column(
          children: [
            ServiceItem(
              icon: Icons.calculate,
              iconColor: Colors.blue,
              label: Strings.carCalculator,
              click:  () =>  startPage(Strings.carCalculator),
            ),
            ServiceItem(
              icon: Icons.money_off,
              iconColor: Colors.yellow,
              label: Strings.carValuation,
              click:  () => startPage(Strings.carValuation),
            ),
            ServiceItem(
              icon: Icons.nightlife,
              iconColor: Colors.green,
              label: Strings.cardLife,
              click: () =>  startPage(Strings.cardLife),
            ),
            ServiceItem(
              icon: Icons.car_repair,
              iconColor: Colors.red,
              label: Strings.carMaintenance,
              click: () => startPage(Strings.carMaintenance),
            ),
          ],
        ));
  }
}


