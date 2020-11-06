import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceItem extends StatelessWidget {
  IconData icon;
  Color iconColor;
  String label;
  GestureTapCallback click;

  ServiceItem({this.icon, this.iconColor, this.label, this.click});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Ink(
        height: 50.0,
        color: Colors.white,
        // margin: EdgeInsets.only(top: 15),
        child: InkWell(
          onTap: this.click,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  this.icon,
                  color: this.iconColor,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(this.label),
                  )),
              Padding(
                padding: EdgeInsets.only(right: 26),
                child:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
