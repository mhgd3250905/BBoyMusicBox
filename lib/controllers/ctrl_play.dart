import 'package:audioplayers/audioplayers.dart';
import 'package:bboymusics/bean/bean_music_manager.dart';
import 'package:bboymusics/bean/bean_music_query.dart';
import 'package:get/get.dart';

class PlayCtrl extends GetxController {
  static PlayCtrl get to => Get.find();

  final isPlaying = false.obs;
  final player = AudioPlayer();
  final selectMusic = MusicManger().obs;

  @override
  void onInit() {
    player.onDurationChanged.listen((Duration d) {
      selectMusic.value.duration = d.inSeconds;
      selectMusic.refresh();
    });

    player.onPositionChanged.listen((Duration p) {
      selectMusic.value.seek = p.inSeconds;
      selectMusic.refresh();
    });

    player.onPlayerStateChanged.listen((PlayerState s) {
      print('Current player state: $s');
    });

    player.onPlayerComplete.listen((_) {});

    player.onLog.listen(
          (String message) {
        print("log:$message");
      },
      onError: (Object e, [StackTrace? stackTrace]) async {
        print("log:$e,$stackTrace");
        if (isPlaying.value) {
          await tryToResume();
        }
      },
    );

    ever(isPlaying, (bool isPlay) async {
      if (isPlay) {
        await tryToResume();
      } else {
        await player.pause();
      }
    });
  }

  Future<void> tryToResume() async {
    await player
        .setSourceUrl(Uri.encodeFull(selectMusic.value.music!.url!,),);
    await player.resume();
  }

  Future<void> playOrPause(Music music, {bool? reset}) async {
    selectMusic.value.music = music;
    selectMusic.refresh();
    bool curIsPlay = isPlaying.value;
    isPlaying.value = (reset ?? false) ? true : !curIsPlay;
    isPlaying.refresh();
  }

  @override
  void dispose() async {
    await player.dispose();
    super.dispose();
  }

  void seek(int seconds) async {
    await player.seek(Duration(seconds: seconds));
  }
}
