import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [BoxShadow(color: Colors.grey)]),
        child: Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=705813691,3853120050&fm=26&gp=0.jpg"));
  }
}
