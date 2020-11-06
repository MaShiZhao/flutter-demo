import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_utils.dart';
import 'package:flutter_demo/widgets/page/mine_grid_item.dart';
import 'package:flutter_demo/widgets/page/mine_list_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
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
    List listData = [
      MineListItem(
          icon: Icons.phone,
          iconColor: Colors.blue,
          label: '客服电话',
          click: () => startPage("客服电话")),
      MineListItem(
          icon: Icons.line_weight,
          iconColor: Colors.green,
          label: '车主公众号',
          click: () => startPage("车主公众号")),
      MineListItem(
          icon: Icons.help,
          iconColor: Colors.red,
          label: '帮助中心',
          click: () => startPage("帮助中心")),
    ];
    return Column(
      children: [
        Container(
          color: ColorUtils.primaryColor,
          height: 200,
          padding: EdgeInsets.only(top: 80),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/ic_launcher_app.png'))),
              ),
              Expanded(
                flex: 1,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '你好，马世钊！',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    TextSpan(
                        text: '\n153****4882',
                        style: TextStyle(
                            fontSize: 14, color: Colors.white, height: 2)),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 15),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          height: 180,
          child: GridView(
            padding: EdgeInsets.all(0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 0, crossAxisSpacing: 10),
            children: [
              MineGridItem(
                  icon: Icons.list,
                  iconColor: ColorUtils.primaryColor,
                  label: '我的账单',
                  click: () => startPage("我的账单")),
              MineGridItem(
                  icon: Icons.content_copy_rounded,
                  label: '我的合同',
                  click: () => startPage("我的合同")),
              MineGridItem(
                  icon: Icons.money,
                  label: '提前还款',
                  click: () => startPage("提前还款")),
              MineGridItem(
                  icon: Icons.offline_bolt,
                  label: '保险相关',
                  click: () => startPage("保险相关")),
              MineGridItem(
                  icon: Icons.credit_card,
                  label: '还款卡',
                  click: () => startPage("还款卡")),
              MineGridItem(
                  icon: Icons.local_library_outlined,
                  label: '修改地址',
                  click: () => startPage("修改地址")),
              MineGridItem(
                  icon: Icons.my_library_books_sharp,
                  label: '解压',
                  click: () => startPage("解压")),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          height: 152,
          child: ListView.separated(
            padding: EdgeInsets.all(0),

            itemBuilder: (BuildContext context, int index) {
              return listData[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey,
                height: 0,
              );
            },
            itemCount: listData.length,
          ),
        ),
      ],
    );
  }
}
