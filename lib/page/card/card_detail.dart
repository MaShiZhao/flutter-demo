import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/resources/dimens.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:flutter_demo/widgets/page/home_car_item.dart';

class CardDetail extends StatefulWidget {
  @override
  createState() => CarListSate();
}

class CarListSate extends State<CardDetail>
    with SingleTickerProviderStateMixin {
  List tabs = ["新车", "二手车"];
  TabController _tabController;

  List titleData = ['客户信息', '车辆信息', '融资信息'];
  List childData = [
    ['年龄 [岁]', '担保人模式'],
    ['年龄 [岁]', 'LCV车型', '新能源车型'],
    ['融资比例', '融资额 [万元]', '融资期限 [期]']
  ];
  List childContentData = [
    ['18-60（不含融资期限）', '支持'],
    ['≤12.5]', '支持', '支持'],
    ['成交价≤10万，总融资额≤实际成交价的100%', '2-30', '12、24、36']
  ];

  @override
  void initState() {
    _tabController = TabController(length: this.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('微众银行',
            style: TextStyle(
                fontSize: Dimens.fontBarSize, fontWeight: FontWeight.bold)),
        toolbarHeight: Dimens.barHeight,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 15),
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
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItem(titleData[index], childData[index],
                    childContentData[index]);
              },
              itemCount: titleData.length,
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildItem(titleData, List childData, childContentData) {
  List<TableRow> tableRow = List();
  for (int i = 0; i < childData.length; i++) {
    tableRow.add(TableRow(children: [
      Container(
        height: 44,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Text(
          childData[i],
          style: TextStyle(fontSize: 14),
        ),
      ),
      Container(
        height: 44,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Text(
          childContentData[i],
          style: TextStyle(fontSize: 14),
        ),
      )
    ]));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(left: 18,right: 18, top: 15),
        child: Text(
          titleData,
          style: TextStyle(fontSize: 20),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Table(
            children: tableRow,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(
              color: Colors.grey[300],
              width: 1.0,
              style: BorderStyle.solid,
            )),
      )
    ],
  );
}
