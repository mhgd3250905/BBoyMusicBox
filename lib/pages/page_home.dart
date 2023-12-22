import 'dart:ffi';

import 'package:bboymusics/bean/bean_music_manager.dart';
import 'package:bboymusics/bean/bean_music_query.dart';
import 'package:bboymusics/controllers/ctrl_home.dart';
import 'package:bboymusics/controllers/ctrl_play.dart';
import 'package:bboymusics/controllers/ctrl_query.dart';
import 'package:bboymusics/pages/page_play.dart';
import 'package:bboymusics/pages/page_upload.dart';
import 'package:bboymusics/res/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animController;
  late PageController pageController;
  late TabController tabController;

  // 子项集
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    QueryCtrl.to.queryMusics();

    animController = AnimationController(vsync: this)
      ..drive(Tween(begin: 0, end: 1))
      ..duration = Duration(milliseconds: 500);

    // 初始化子项集合
    children = [
      UploadView(title: 'Upload'),
      UploadView(title: 'Left'),
      PlayView(),
      UploadView(title: 'right'),
      UploadView(title: 'menu'),
    ];

    // 初始化控制器
    pageController = PageController(initialPage: 2);
    tabController = TabController(
        initialIndex: 2,
        animationDuration: Duration(milliseconds: 200),
        length: 5,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MAIN_COLOR,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MAIN_COLOR,
          body: Container(
            child: Column(
              children: [
                buildTitleRow(),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    // 设置子项集
                    children: children,
                    // 添加页面滑动改变后，去改变索引变量刷新页面来更新底部导航
                    onPageChanged: (value) {
                      HomeCtrl.to.pageIndex.value = value;
                      HomeCtrl.to.pageIndex.refresh();
                      tabController.index=value;
                    },
                  ),
                ),
                // buildPlayRow(),
              ],
            ),
          ),
          bottomNavigationBar: buildBottomMenu(),
        ),
      ),
    );
  }

  void buildMenuTapListener(i) {
    switch (i) {
      case 0:
        //上传音乐
        break;
      case 1:
        //上一曲
        break;
      case 2:
        //播放、暂停
        playAndPause();
        break;
      case 3:
        //下一曲
        break;
      case 4:
        //列表
        break;
    }
  }

  Widget buildBottomMenu() {
    return ConvexAppBar.builder(
      backgroundColor: BORDER_COLOR,
      initialActiveIndex: 2,
      onTap: buildMenuTapListener,
      controller: tabController,
      itemBuilder: ItemBuilder(
        animController: animController,
        pageController: pageController,
        tabController: tabController,
      ),
      // onTapNotify: (i) {
      // return i == 2;
      // },
      count: 5,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Image.asset(
                "assets/img/png_app_title.png",
                width: 300.0,
                fit: BoxFit.fitWidth,
              ),
            )),
      ],
    );
  }

  void playAndPause() async {
    Music? music = PlayCtrl.to.selectMusic.value.music;
    if (music == null) return;
    await PlayCtrl.to.playOrPause(music);
  }
}

class ItemBuilder extends DelegateBuilder {
  AnimationController? animController;
  PageController? pageController;
  TabController? tabController;

  ItemBuilder({this.animController, this.pageController, this.tabController});

  @override
  Widget build(BuildContext context, int index, bool active) {
    switch (index) {
      case 0:
        Widget child = Icon(
          Icons.upload_file,
          key: ValueKey('$index-$active'),
          color: MENU_0,
          size: 25.0,
        );
        if (active) {
          child = Container(
            key: ValueKey('$index-$active'),
            margin: const EdgeInsets.all(10.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: MENU_0,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Icon(
                Icons.upload_file,
                color: BORDER_COLOR,
                size: 30.0,
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            pageController!.jumpToPage(0);
            tabController!.index = 0;
          },
          child: child,
        );
      case 1:
        Widget child = Icon(
          Icons.first_page_outlined,
          key: ValueKey('$index-$active'),
          color: MENU_1,
          size: 25.0,
        );
        if (active) {
          child = Container(
            key: ValueKey('$index-$active'),
            margin: const EdgeInsets.all(10.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: MENU_1,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Icon(
                Icons.first_page_outlined,
                color: BORDER_COLOR,
                size: 30.0,
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            pageController!.jumpToPage(1);
            tabController!.index = 1;
          },
          child: child,
        );
      case 2:
        Widget child = InkWell(
          onTap: () {
            pageController!.jumpToPage(2);
            tabController!.index = 2;
          },
          child: Icon(
            Icons.play_arrow,
            key: ValueKey('$index-$active'),
            color: MENU_2,
            size: 25.0,
          ),
        );
        if (active) {
          child = Obx(() {
            bool isPlaying = PlayCtrl.to.isPlaying.value;
            isPlaying ? animController!.forward() : animController!.reverse();
            return Container(
              margin: const EdgeInsets.all(10.0),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: MENU_2,
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Center(
                child: AnimatedIcon(
                  color: BORDER_COLOR,
                  size: 30.0,
                  icon: AnimatedIcons.play_pause,
                  progress: animController!,
                ),
              ),
            );
          });
        }
        return child;
      case 3:
        Widget child = Icon(
          Icons.last_page_outlined,
          key: ValueKey('$index-$active'),
          color: MENU_3,
          size: 25.0,
        );
        if (active) {
          child = Container(
            key: ValueKey('$index-$active'),
            margin: const EdgeInsets.all(10.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: MENU_3,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Icon(
                Icons.last_page_outlined,
                color: BORDER_COLOR,
                size: 30.0,
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            pageController!.jumpToPage(3);
            tabController!.index = 3;
          },
          child: child,
        );
      case 4:
        Widget child = Icon(
          Icons.menu,
          key: ValueKey('$index-$active'),
          color: MENU_4,
          size: 25.0,
        );
        if (active) {
          child = Container(
            key: ValueKey('$index-$active'),
            margin: const EdgeInsets.all(10.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: MENU_4,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Icon(
                Icons.menu,
                color: BORDER_COLOR,
                size: 30.0,
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            pageController!.jumpToPage(4);
            tabController!.index = 4;
          },
          child: child,
        );
    }
    return Icon(
      Icons.upload_file,
      color: Colors.white,
      size: 25.0,
    );
  }
}
