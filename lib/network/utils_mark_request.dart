/*
 * 这个类用来书写有关mark请求相关的工具
 */
import 'package:get/get.dart';

String buildImageUrl(String downUrl, int width, int height) {
  //缩放
  String url = '$downUrl?imageMogr2/thumbnail/${width}x';
  return url;
}

int getThumbImageWidth() {
  return 200;
}

int getGridImageWidth() {
  return Get.context!.mediaQueryShortestSide *
      Get.context!.devicePixelRatio ~/
      3;
}

int getThumbWidth() {
  return Get.context!.mediaQueryShortestSide *
      Get.context!.devicePixelRatio ~/
      8;
}

int getPageImageWidth() {
  return Get.context!.mediaQueryShortestSide *
      Get.context!.devicePixelRatio ~/
      1;
}
