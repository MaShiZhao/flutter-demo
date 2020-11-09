import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/resources/dimens.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:flutter_demo/widgets/page/home_car_item.dart';

class CarList extends StatefulWidget {
  @override
  createState() => CarListSate();
}

class CarListSate extends State<CarList> with SingleTickerProviderStateMixin {
  List tabs = ["全部", "0息购车"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: this.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('分期购车',
              style: TextStyle(
                  fontSize: Dimens.fontBarSize, fontWeight: FontWeight.bold)),
          toolbarHeight: Dimens.barHeight,
          elevation: 4),
      backgroundColor: Colors.white,
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 0),
            child: TabBar(
                controller: this._tabController,
                isScrollable: true,
                labelColor: Colors.deepOrange,
                indicatorColor: Colors.deepOrange,
                indicatorWeight: 1,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 16),
                tabs: tabs.map((e) => Tab(text: e)).toList()),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Grid按两列显示
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.63,
                    crossAxisSpacing: 20.0),
                itemBuilder: (BuildContext context, int index) {
                  return HomeCarItem();
                },
                itemCount: 16,
              ),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //     width: 100,
    //     height: 100,
    //     child: Column(
    //       children: [
    //         AppBar(
    //             title: Text('分期购车',
    //                 style: TextStyle(
    //                     fontSize: Dimens.fontBarSize,
    //                     fontWeight: FontWeight.bold)),
    //             toolbarHeight: Dimens.barHeight,
    //             elevation: 4),
    //         TabBar(
    //             controller: this._tabController,
    //             isScrollable: true,
    //             labelColor: Colors.deepOrange,
    //             indicatorColor: Colors.deepOrange,
    //             indicatorWeight: 1,
    //             indicatorSize: TabBarIndicatorSize.label,
    //             unselectedLabelColor: Colors.black,
    //             tabs: tabs.map((e) => Tab(text: e)).toList()),
    //       ],
    //     ));
  }
}
