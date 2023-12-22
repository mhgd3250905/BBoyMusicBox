import 'package:bboymusics/controllers/ctrl_home.dart';
import 'package:bboymusics/controllers/ctrl_play.dart';
import 'package:bboymusics/controllers/ctrl_query.dart';
import 'package:bboymusics/controllers/ctrl_upload.dart';
import 'package:bboymusics/pages/page_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const String BASE_HOST = 'http://marklife.love';

void main() async {
  await GetStorage.init();
  // //顶部状态栏透明
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      home: App(),
      routingCallback: (routing) {},
      onInit: () {
        Get.put(HomeCtrl());
        Get.put(QueryCtrl());
        Get.put(PlayCtrl());
        Get.put(UploadCtrl());
        // Get.put(ScheduleCtrl());
        // Get.put(TrophyCtrl());
        // Get.put(StatisticCtrl());
      },
      theme: ThemeData(fontFamily: "MiSansBold"),
      builder: (context, widget) {
        return MediaQuery(
          //设置文字大小不随系统设置改变
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    ),
  );
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

