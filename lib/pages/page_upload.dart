import 'dart:io';

import 'package:bboymusics/bean/bean_music_info.dart';
import 'package:bboymusics/controllers/ctrl_upload.dart';
import 'package:bboymusics/res/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadView extends StatefulWidget {
  String? title;

  UploadView({Key? key, this.title}) : super(key: key);

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: CARD_COLOR, width: 1.0),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildFileNameText(),
                      ),
                      MaterialButton(
                        color: CARD_COLOR,
                        onPressed: () async {
                          await pickMusicFile();
                        },
                        child: Container(
                          child: Text('选择文件'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: buildMusicInfoColumn(),
          )
        ],
      ),
    );
  }

  //构建音乐信息部分
  Widget buildMusicInfoColumn() {
    return Obx(() {
      bool isSelected = UploadCtrl.to.fileNameLive.value.isNotEmpty;
      double progress = UploadCtrl.to.uploadProgress.value;
      return Visibility(
        visible: isSelected,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '音乐名称',
                    style: TextStyle(
                      color: CARD_COLOR,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    child: Obx(() {
                      return Text(
                        UploadCtrl.to.fileNameLive.value,
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: 16.0,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '音乐时长',
                    style: TextStyle(
                      color: CARD_COLOR,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    child: Obx(() {
                      int secs = UploadCtrl.to.durationLive.value;
                      return Text(
                        '${(secs ~/ 60).toString().padLeft(2, '0')}'
                        ':${(secs / 60).toInt().toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: 16.0,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '音乐路径',
                    style: TextStyle(
                      color: CARD_COLOR,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    child: Obx(() {
                      return Text(
                        UploadCtrl.to.filePathLive.value,
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: 16.0,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      child: MaterialButton(
                        padding: const EdgeInsets.only(
                          left: 60.0,
                          right: 60.0,
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        color: TEXT_DARK_COLOR,
                        onPressed: () async {
                          List<File> files = [];
                          File file = UploadCtrl.to.fileLive.value;
                          int duration = UploadCtrl.to.durationLive.value;
                          String fileName = UploadCtrl.to.fileNameLive.value;
                          files.add(UploadCtrl.to.fileLive.value);
                          List<MusicInfo> musicInfos = [];
                          musicInfos.add(MusicInfo.fromParams(
                              duration: duration,
                              name: fileName,
                              desc: "APP Desc",
                              uploader: "Bboy AKai"));
                          MusicInfoListBean musicInfoListBean =
                              new MusicInfoListBean.fromParams(
                                  list: musicInfos);
                          UploadCtrl.to
                              .uploadMusicFile(files, musicInfoListBean);
                        },
                        child: Container(
                          child: Text(
                            '点击上传',
                            style: TextStyle(
                              color: TEXT_HIGHLIGHT_COLOR,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: progress > 0,
                      child: Positioned(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  color: TEXT_HIGHLIGHT_COLOR,
                                  fontSize: 8.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: Center(
                                child: LinearProgressIndicator(
                                  backgroundColor: TEXT_DARK_COLOR,
                                  valueColor:
                                      const AlwaysStoppedAnimation(TEXT_COLOR),
                                  value: progress,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40.0),
          ],
        ),
      );
    });
  }

  Widget buildFileNameText() {
    return Obx(
      () {
        return Container(
          child: Text(
            UploadCtrl.to.fileNameLive.value,
            style: TextStyle(
              color: TEXT_HIGHLIGHT_COLOR,
              fontSize: 18.0,
            ),
          ),
        );
      },
    );
  }

  Future<void> pickMusicFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      var single = result.files.single;
      String fileName = single.name;

      File file = File(result.files.single.path!);
      String path = file.path;

      UploadCtrl.to.fileLive.value = file;
      UploadCtrl.to.fileNameLive.value = fileName;
      UploadCtrl.to.filePathLive.value = path;
      UploadCtrl.to.refresh();

      UploadCtrl.to.loadMusic(file);
    } else {
      // User canceled the picker
    }
  }
}
