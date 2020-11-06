import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 16, top: 30),
      height: 90,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Text(
            '易鑫金融',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 14, left: 14),
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                  ),
                  Text(
                    '输入查询内容',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Text(
                  '北京',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(
                Icons.local_library_outlined,
                size: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
