import 'package:audioplayers/audioplayers.dart';
import 'package:bboymusics/bean/bean_music_query.dart';
import 'package:bboymusics/controllers/ctrl_home.dart';
import 'package:bboymusics/main.dart';
import 'package:bboymusics/network/enum_connect_state.dart';
import 'package:bboymusics/network/http_client.dart';
import 'package:bboymusics/network/state_request.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;

class QueryCtrl extends GetxController {
  static QueryCtrl get to => Get.find();

  final queryState = ConnectState.none.obs; //刷新的状态
  final musicsLive=MusicQueryBean.fromParams().obs;


  Future<void> queryMusics() async {
    queryState.value = ConnectState.waiting;
    queryState.refresh();

    try {
      var formData = DIO.FormData.fromMap({
        'folder_keys': HomeCtrl.to.dateKeys.toJson(),
      });

      String url = '$BASE_HOST/music/query';

      //这里为了显示加载过程，可退
      var response = await HttpManager.getInstance().dio!.post(
            url,
            data: formData,
          );
      MusicQueryBean result = MusicQueryBean(response.data);

      if (result.err == RequestState.SUCCESS) {
        musicsLive.value = result;
        musicsLive.refresh();
        queryState.value = ConnectState.done;
        queryState.refresh();
      }else{
        queryState.value = ConnectState.err;
        queryState.refresh();
      }
    } catch (e) {
      print(e);
      queryState.value = ConnectState.err;
      queryState.refresh();
    }
    print('查询音乐列表完毕');
  }
}
