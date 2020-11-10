import 'dart:async';
import 'dart:ffi';

import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatefulWidget {
  List<String> data = [
    'http://pic1.win4000.com/wallpaper/2017-11-02/59fae3ef00f41.jpg',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2105352548,1613982024&fm=26&gp=0.jpg',
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1843403844,3825446496&fm=26&gp=0.jpg',
    'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1463337004,1928567526&fm=26&gp=0.jpg',
  ];

  double height = 220;

  // CustomBanner(this.data);

  @override
  _CustomBannerSate createState() => _CustomBannerSate();
}

class _CustomBannerSate extends State<CustomBanner> {
  int _curIndex = 0;
  PageController _controller;

  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: _curIndex);
    //定时器
    _initTimer();
  }

  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 3), (t) {
        _curIndex++;
        _controller.animateToPage(
          _curIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.linearToEaseOut,
        );
      });
    }
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          PageView.builder(
              itemCount: int64MaxValue,
              controller: _controller,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTapUp: (detail) => _initTimer(),
                    onTapCancel: () => _initTimer(),
                    onTapDown: (detail) => _cancelTimer(),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(4)),
                        clipBehavior: Clip.antiAlias,
                        child:
                        FadeInImage.assetNetwork(
                          placeholder: "images/ic_launcher_app.png",
                          image: widget.data[index % widget.data.length],
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                        )
                    ));
              },
              onPageChanged: (position) => {
                    setState(() {
                      this._curIndex = position;
                    })
                  }),
          _buildIndicator()
        ]));
  }

  Widget _buildIndicator() {
    var length = widget.data.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget.data.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipOval(
              child: Container(
                width: 8,
                height: 8,
                color: s == widget.data[_curIndex % length]
                    ? Colors.redAccent
                    : Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
