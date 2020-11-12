import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/CityBean.dart';
import 'package:flutter_demo/resources/dimens.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:flutter_demo/widgets/card_letter_search.dart';
import 'package:flutter_demo/widgets/page/home_car_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardList extends StatefulWidget {
  @override
  createState() => CardListSate();
}

class CardListSate extends State<CardList> with SingleTickerProviderStateMixin {
  List<CityBean> cityBeans;

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    cityBeans = List();
    List<CityBeanChild> childs = List();
    CityBeanChild child = CityBeanChild();
    child.name = "工商银行";
    child.img =
        "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2726460193,3793507388&fm=26&gp=0.jpg";
    childs.add(child);
    childs.add(child);
    childs.add(child);
    childs.add(child);
    childs.add(child);
    childs.add(child);
    childs.add(child);

    CityBean cityBean = CityBean();
    cityBean.letter = 'A';
    cityBean.child = childs;
    CityBean cityBean2 = CityBean();
    cityBean2.letter = 'B';
    cityBean2.child = childs;

    CityBean cityBean3 = CityBean();
    cityBean3.letter = 'C';
    cityBean3.child = childs;
    CityBean cityBean4 = CityBean();
    cityBean4.letter = 'D';
    cityBean4.child = childs;
    CityBean cityBean5 = CityBean();
    cityBean5.letter = 'E';
    cityBean5.child = childs;
    CityBean cityBean6 = CityBean();
    cityBean6.letter = 'F';
    cityBean6.child = childs;
    CityBean cityBean7 = CityBean();
    cityBean7.letter = 'G';
    cityBean7.child = childs;

    cityBeans.add(cityBean);
    cityBeans.add(cityBean2);
    cityBeans.add(cityBean3);
    cityBeans.add(cityBean4);
    cityBeans.add(cityBean5);
    cityBeans.add(cityBean6);
    cityBeans.add(cityBean7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('全部资方',
                style: TextStyle(
                    fontSize: Dimens.fontBarSize, fontWeight: FontWeight.bold)),
            toolbarHeight: Dimens.barHeight,
            elevation: 4),
        backgroundColor: Colors.white,
        body: Flex(
          direction: Axis.vertical,
          children: [
            Container(
               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[800],
                    size: 18,
                  ),
                  hintText: '输入关键字检索',
                  hintStyle: TextStyle(fontSize: 14),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: InputBorder.none
                ),
                cursorColor: Colors.blue,
                onSubmitted: (text){
                  Fluttertoast.showToast(msg: text);
                  controller.text='';
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: CardLetterSearch(data: cityBeans),
            )
          ],
        ));
  }
}
