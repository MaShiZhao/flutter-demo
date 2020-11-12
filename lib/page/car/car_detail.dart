import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CarDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
      body: MainPage(
        rpx: rpx,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.rpx});

  final double rpx;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  //整个页面滚动的距离
  double distanceOfPageScroll = 0;

  //banner移动的距离
  double distanceOfBannerScroll = 0;

  // 单次滚动时记录上次滚动的位置 每次触发滚动之前要置位0
  double prevdy;

  // 图片的适应方式
  BoxFit fitType;

  // 动画控制器
  AnimationController animationcontroller;

  // 动画
  Animation<double> animation;

  // banner图片的高度
  double bannerHeight;

  @override
  void initState() {
    super.initState();
    prevdy = 0;
    fitType = BoxFit.fitWidth;
    animationcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300)); // 动画时间
    animation =
        Tween(begin: 0.0, end: 0.0).animate(animationcontroller); // 效果绑定动画时间
  }

  // 手饰点击的时候执行
  calculatorScrollHeight(dy) {
    // 如果初始点击位置为0，那么记录传入进来的点击的值
    // 如果之前没有点过，那么首次点击的位置就是手饰按下去的位置
    if (prevdy == 0) {
      prevdy = dy;
    }
    //计算图片应该变化的高度
    // 图片容器增长的高度 += 改变的高度坐标 - 鼠标上一个点的坐标（也就代表一直增长）
    distanceOfPageScroll += dy - prevdy;
    //更新本次计算完的数据
    prevdy = dy;
  }

  // 手饰点击的时候执行
  updatePicHeight() {
    // 如果下拉过了200后，就修改图片的适应格式
    // if (extraPicHeight >= 200 * widget.rpx) {
    //   fitType = BoxFit.fitHeight;
    // } else {
    //   fitType = BoxFit.fitWidth;
    // }
    if (distanceOfPageScroll > 0 || distanceOfPageScroll.abs() < bannerHeight) {
      setState(() {
        distanceOfBannerScroll = distanceOfPageScroll;
        // print('extraPicHeight：$distanceOfPageScroll');
      });
    }
  }

  // 手饰抬起的时候执行
  runAnimate() {
    setState(() {
      animation = Tween(begin: distanceOfPageScroll, end: 0.0)
          .animate(animationcontroller)
            ..addListener(() {
              // if (extraPicHeight >= 200 * widget.rpx) {
              //   fitType = BoxFit.fitWidth;
              // } else {
              //   fitType = BoxFit.fitHeight;
              // }
              setState(() {
                distanceOfBannerScroll = animation.value;
                distanceOfPageScroll = distanceOfBannerScroll;
                fitType = fitType;
              });
            });
      // 执行完回弹之后，初始点击变化值 再次初始化为0（保证移动-鼠标位置 = 增长的高度）
      //（避免保留着上一次的鼠标点击值，造成下一次点击的时候，移动的高度比点击的位置小）
      prevdy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    bannerHeight = rpx * 300;

    return Listener(
      onPointerDown: (_) {
        prevdy = 0;
      },
      onPointerMove: (result) {
        // print('position = ${result.position.dy}');
        calculatorScrollHeight(result.position.dy);
        updatePicHeight();
      },
      onPointerUp: (_) {
        if (distanceOfPageScroll > bannerHeight) {
          runAnimate();
          animationcontroller.forward(from: 0);
        }
      },
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildAppBar(),
          _buildBanner(bannerHeight, distanceOfBannerScroll),
          _buildTopView(this),
          _buildContent()
        ],
      ),
    );
  }
}

// appBar view
_buildAppBar() {
  return SliverAppBar(
    pinned: true,
    floating: true,
    title: Text('153人感兴趣'),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          Icons.share,
          size: 16,
        ),
      )
    ],
  );
}

//banner的位置布局包含 banner 和 车名介绍
_buildBanner(double bannerHeight, double distanceOfBannerScroll) {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: bannerHeight + distanceOfBannerScroll,
          color: Colors.white,
          child: (Image.network(
              "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3601935830,4052334604&fm=26&gp=0.jpg",
              height: bannerHeight + distanceOfBannerScroll / 2,
              fit: BoxFit.fitHeight)),
        ),
        Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, -2),
                    blurRadius: 2,
                    spreadRadius: 0)
              ]),
          child: Stack(
            children: [
              Text('法拉利 NB', style: TextStyle(fontSize: 16)),
              Positioned(
                  child: Text(
                    '厂商指导价 160w-270w',
                    style: TextStyle(fontSize: 12),
                  ),
                  bottom: 0),
              Positioned(
                child: Text(
                  '所在地: 吉林',
                  style: TextStyle(fontSize: 12),
                ),
                bottom: 0,
                right: 0,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

//置顶内容
_buildTopView(TickerProvider tickerProvider) {
  List tabs = ["方案", "车辆", '车商', '流程'];
  TabController _tabController =
      TabController(length: tabs.length, vsync: tickerProvider);
  return SliverPersistentHeader(
    pinned: true,
    delegate: _SliverAppBarDelegate(
      maxHeight: 50,
      minHeight: 50,
      child: Container(
          color: Colors.white,
          child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.deepOrange,
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.grey[900],
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 18),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              tabs: tabs.map((e) => Tab(text: e)).toList())),
    ),
  );
}

_buildContent() {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        _buildContentPlan(),
        _buildContentCarInfo(),
        _buildContentCarShop(),
        _buildContentCarBuy(),
        Container(
          height: 50,
          color: Colors.white,
        )
      ],
    ),
  );
}

_buildContentPlan() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '分期方案',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Container(
          height: 200,
          width: double.infinity,
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 0)
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "images/ic_launcher_app.png",
                    width: 16,
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "舒益新",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                height: 18,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '20%起',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('0',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red)))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('24/26期',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red)))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('2万起',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red)))),
                ],
              ),
              Container(
                height: 6,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '首付比例',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('利率',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black)))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('期数',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black)))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('融资额度',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black)))),
                ],
              ),
              Container(height: 16),
              Text(
                '易鑫金融与长安汽车，联合推出【舒鑫融】分期购车方案。首付20%起，最低享受0息购车。',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Container(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.privacy_tip,
                    size: 14,
                    color: Colors.grey,
                  ),
                  Text(
                    '  详情咨询当地4S经销商',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_buildContentCarInfo() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '车辆信息',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    '厂商',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '指导价（万）',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  '长安汽车',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  '10.6-111万',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    '发动机',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '变速箱',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  '1.5T 直列 4缸 涡轮增压',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  '6档 手动',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    '长*宽*高(mm）',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    '综合油耗(L/100km)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  '4670*1865*1700',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  '6.6',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
          ],
        ),
      ],
    ),
  );
}

_buildContentCarShop() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '车商信息',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        _buildContentShopItem("4S-北京庆长风商贸有限公司", "北京市朝阳区小红门肖村南四环东路97号"),
        _buildContentShopItem("4S-北方新兴汽车销售有限公司", "北京市朝阳区G1辅路与双桥路交汇处"),
        _buildContentShopItem("4S-北京燕兴宏达汽车销售有限公司", "北京市顺义区顺西路30号"),
      ],
    ),
  );
}

_buildContentShopItem(String name, String location) {
  return Container(
    height: 66,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
            top: 12,
            child: Text(name,
                style: TextStyle(color: Colors.black, fontSize: 15))),
        Positioned(
            bottom: 12,
            child: Text(location,
                style: TextStyle(color: Colors.grey, fontSize: 12))),
        Positioned(
            right: 0,
            child: Icon(
              Icons.phone,
              color: Colors.blue,
              size: 16,
            )),
        Positioned(
            right: 30,
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 16,
            )),
        Positioned(
          bottom: 1,
          right: 0,
          left: 0,
          child: Container(
            height: 1,
            color: Colors.grey[200],
          ),
        ),
      ],
    ),
  );
}

_buildContentCarBuy() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '购车流程',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "1、线上咨询或到店咨询（4S经销商）",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "2、与金融顾问沟通产品方案",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "3、提交购车申请，最快当天提车",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "4、按月支付租金",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
