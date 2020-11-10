import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/CityBean.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 银行卡 筛选页面
class CardLetterSearch extends StatelessWidget {
  CardLetterSearch({
    Key key,
    this.data,
    this.letterWidth = 30,
    this.letterHeight = 25,
    this.listParentHeight = 35,
    this.listChildHeight = 40,
  }) : super(key: key);

  //列表数据源
  List<CityBean> data;

  //滚动控制器
  ScrollController _scrollController = ScrollController();

  //当前右边字母选中的位置 -1 表示不需要提示
  int _currentIndex = -1;

  //筛选字母 宽、高度设置 默认是40
  double letterHeight;
  double letterWidth;

  //list title ABC等的高度设置
  double listParentHeight;

  //list 具体内容高度的设置
  double listChildHeight;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(data.length, (index) {
      Widget child = Center(child: Text('${data[index].letter.toUpperCase()}'));
      return SizedBox(width: letterWidth, height: letterHeight, child: child);
    });
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          data == null || data.length == 0
              ? Text("")
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: listParentHeight,
                          alignment: Alignment.centerLeft,
                          color: Colors.grey[100],
                          padding: EdgeInsets.only(left: 16),
                          child: Text(data[index].letter.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              )),
                        ),
                        ListView.builder(
                            itemBuilder: (BuildContext context, int index2) {
                              return Container(
                                height: listChildHeight,
                                child: GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Image.network(
                                          data[index].child[index2].img,
                                          width: 30,
                                          height: 30,
                                          fit:BoxFit.fitWidth,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "${data[index].child[index2].name}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pop(data[index].child[index2].name);
                                  },
                                ),
                              );
                            },
                            itemCount: data[index].child.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics()) //禁用滑动事件),
                      ],
                    );
                  }),
          Positioned(
              // alignment: new FractionalOffset(1.0, 0.5),
              right: 15,
              child: GestureDetector(
                child: Column(
                  children: children,
                ),
                onVerticalDragDown: (detail) {
                  _currentIndex = -1;
                  _indexChange(detail.localPosition.dy);
                },
                onVerticalDragUpdate: (detail) {
                  _indexChange(detail.localPosition.dy);
                },
                onVerticalDragEnd: (detail) {
                  print('onVerticalDragEnd ');
                },
                onVerticalDragCancel: () {
                  print('onVerticalDragCancel  ');
                },
              ))
        ],
      ),
    );
  }

  int _getIndex(double ySet) {
    for (int i = 0, length = data.length; i < length; i++) {
      double a = letterHeight * i;
      double b = letterHeight * (i + 1);
      print('_getIndex $ySet == $a -- $b');
      if (ySet >= a && ySet <= b) {
        return i;
      }
    }
    return -1;
  }

  void _indexChange(double dy) {
    int index = _getIndex(dy);
    print('_indexChange $index ');
    if (index == -1) return;
    // 如果是当前正在提示的则无需提示
    if (_currentIndex != index) {
      _currentIndex = index;
      var height = _currentIndex * listParentHeight;
      for (int i = 0; i < _currentIndex; i++) {
        height += data[i].child.length * listChildHeight;
      }
      _scrollController.jumpTo(height);
      //取消上一个提示选中的字母 显示现在的
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: data[_currentIndex].letter,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG);
    }
  }
}
