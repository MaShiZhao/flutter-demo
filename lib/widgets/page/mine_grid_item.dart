import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/resources/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MineGridItem extends StatelessWidget {
  IconData icon;
  Color iconColor;
  String label;
  GestureTapCallback click;

  MineGridItem({this.icon, this.iconColor, this.label, this.click});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: EdgeInsets.only(top: 15),
      child: Ink(
        height: 90.0,
        // color: Colors.white,
        // margin: EdgeInsets.only(top: 15),
        child: InkWell(
          onTap: this.click,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                this.icon,
              ),
              Text(
                this.label,
                style: TextStyle(
                  height: 2,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
