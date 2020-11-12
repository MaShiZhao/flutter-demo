import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/page/car/car_detail.dart';
import 'package:flutter_demo/page/car/car_list.dart';

class HomeCarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 1)
            ]),
        child: Stack(
          children: [
            Positioned(
              left: 1,
              right: 1,
              top: 1,
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CarDetail();
                    }));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.network(
                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604580906229&di=811d0c3c2e565e78528f6182c906fd6f&imgtype=0&src=http%3A%2F%2Fimg4.cache.netease.com%2Fphoto%2F0008%2F2012-08-22%2F89HAR42F294U0008.jpg",
                            height: 120,
                            fit: BoxFit.fitWidth),
                        alignment: Alignment.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '长安 CSSS PLUS',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 6),
                        child: Text(
                          '指导价：19-22.222w',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 20),
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(5)),
                            child: Flex(direction: Axis.horizontal, children: [
                              Expanded(
                                  flex: 1,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '20%',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 14)),
                                      TextSpan(
                                          text: '\n首付',
                                          style: TextStyle(
                                              color: Colors.black,
                                              height: 1.5,
                                              fontSize: 12)),
                                    ]),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '0%',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 14)),
                                      TextSpan(
                                          text: '\n利率',
                                          style: TextStyle(
                                              color: Colors.black,
                                              height: 1.5,
                                              fontSize: 12)),
                                    ]),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '20',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 14)),
                                      TextSpan(
                                          text: '\n期数',
                                          style: TextStyle(
                                              color: Colors.black,
                                              height: 1.5,
                                              fontSize: 12)),
                                    ]),
                                  ))
                            ])),
                      ),
                    ],
                  )),
            ),
            Positioned(
                left: 20,
                top: 1,
                child: Icon(Icons.turned_in, color: Colors.red)),
          ],
        ));
  }
}
