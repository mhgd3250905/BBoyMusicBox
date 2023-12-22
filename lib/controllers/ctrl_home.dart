import 'package:audioplayers/audioplayers.dart';
import 'package:bboymusics/bean/bean_datekyes.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

class HomeCtrl extends GetxController {
  static HomeCtrl get to => Get.find();
  final pageIndex = 2.obs;

  DateKeys dateKeys = DateKeys.fromParams(keys: []);

  @override
  void onInit() async {
    super.onInit();
    for (var i = 0; i < 6; i++) {
      String dateKey = formatDate(
          DateTime.now().add(Duration(days: -1 * i)), [yyyy, '-', mm, '-', dd]);
      dateKeys.keys!.add(dateKey);
    }
    print('dateKeys.toString(): ${dateKeys.toString()}');
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
