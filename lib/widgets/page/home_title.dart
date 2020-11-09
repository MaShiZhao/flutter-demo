import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  String label;
  Function _onTap;

  HomeTitle(this.label, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Text(
              this.label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: this._onTap,
                  child: Row(
                    children: [
                      Text(
                        '更多',
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
