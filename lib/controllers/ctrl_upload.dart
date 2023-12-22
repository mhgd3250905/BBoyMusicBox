import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bboymusics/bean/bean_music_info.dart';
import 'package:bboymusics/bean/bean_music_query.dart';
import 'package:bboymusics/main.dart';
import 'package:bboymusics/network/enum_connect_state.dart';
import 'package:bboymusics/network/http_client.dart';
import 'package:bboymusics/network/state_request.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;

class UploadCtrl extends GetxController {
  static UploadCtrl get to => Get.find();

  final player = AudioPlayer();

  final uploadProgress = 0.0.obs; //新增记号时候的进度
  final nearbyQueryState = ConnectState.none.obs; //查询附近记号的状态

  final uploadState = ConnectState.none.obs; //刷新的状态
  final musicsLive = MusicQueryBean.fromParams().obs;

  final fileLive = File.fromUri(Uri.file("")).obs;
  final fileNameLive = "".obs;
  final filePathLive = "".obs;
  final durationLive = 0.obs;

  ///发送添加mark请求
  void uploadMusicFile(
    List<File> fileList,
    MusicInfoListBean? musicInfoList,
  ) async {
    uploadState.value = ConnectState.waiting;
    uploadState.refresh();

    var formData;

    List<DIO.MultipartFile> fileParams = [];
    for (var i = 0; i < fileList.length; i++) {
      fileParams.add(await DIO.MultipartFile.fromFile(
        fileList[i].path,
        filename: musicInfoList!.list![i]!.name!,
      ));
    }

    formData = DIO.FormData.fromMap({
      "music": fileParams,
      "music_infos": musicInfoList!.toJson(),
    });

    String url = '$BASE_HOST/music/upload';

    try {
      var response = await HttpManager.getInstance()
          .dio!
          .post(url, data: formData, onSendProgress: (int count, int data) {
        print('add mark count: $count, data: $data');
        uploadProgress.value = count * 1.0 / data;
        uploadProgress.refresh();
      });

      MusicQueryBean result = new MusicQueryBean(response.data);
      if (result.err == RequestState.SUCCESS) {
        musicsLive.value = result;
        musicsLive.refresh();
        uploadState.value = ConnectState.done;
        uploadState.refresh();
      } else {
        uploadState.value = ConnectState.err;
        uploadState.refresh();
      }
    } catch (e) {
      print(e);
      uploadState.value = ConnectState.err;
      uploadState.refresh();
    }
  }

  void loadMusic(File file) {
    player.onDurationChanged.listen((Duration d) {
      UploadCtrl.to.durationLive.value = d.inSeconds;
      UploadCtrl.to.durationLive.refresh();
    });
    UploadCtrl.to.player.setSourceDeviceFile(file.path);
  }
}
