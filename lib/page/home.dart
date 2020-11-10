import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/page/car/car_list.dart';
import 'package:flutter_demo/utils/color_utils.dart';
import 'package:flutter_demo/widgets/custom_banner.dart';
import 'package:flutter_demo/widgets/page/home_car_item.dart';
import 'package:flutter_demo/widgets/page/home_card_item.dart';
import 'package:flutter_demo/widgets/page/home_search.dart';
import 'package:flutter_demo/widgets/page/home_title.dart';

import 'card/card_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List tabs = ["推荐", "玛莎拉蒂", "兰博基尼", "保时捷", "劳斯莱斯", "迈巴赫", "宾利", "小牛"];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: this.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      color: Colors.white,
      child: Column(children: [
        HomeSearch(),
        Divider(
          color: Colors.grey,
          height: 1,
        ),
        Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: CustomBanner(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 4, right: 16),
                    child: TabBar(
                        controller: this._tabController,
                        isScrollable: true,
                        labelColor: Colors.deepOrange,
                        indicatorColor: Colors.deepOrange,
                        indicatorWeight: 1,
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.black,
                        tabs: tabs.map((e) => Tab(text: e)).toList()),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HomeTitle(
                      "大家都在看",
                          () =>
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return CarList();
                            }))
                      }),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                  sliver: SliverGrid(
                    //Grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //Grid按两列显示
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 0.63,
                          crossAxisSpacing: 20.0),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          //创建子widget
                          return HomeCarItem();
                        },
                        childCount: 6,
                      )),
                ),
                SliverToBoxAdapter(
                  child: HomeTitle("合作银行", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return CardList();
                        }));
                  }),
                ),
                SliverPadding(
                  padding:
                  EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 30),
                  sliver: SliverGrid(
                    //Grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //Grid按两列显示
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 2.3,
                          crossAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          //创建子widget
                          return HomeCardItem();
                        },
                        childCount: 6,
                      )),
                ),
              ],
            ))
      ]),
    );
  }
}
