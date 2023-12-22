import 'package:bboymusics/bean/bean_musci_item.dart';
import 'package:bboymusics/bean/bean_music_manager.dart';
import 'package:bboymusics/bean/bean_music_query.dart';
import 'package:bboymusics/controllers/ctrl_play.dart';
import 'package:bboymusics/controllers/ctrl_query.dart';
import 'package:bboymusics/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlayView extends StatefulWidget {
  const PlayView({Key? key}) : super(key: key);

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  late RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: buildMusicBody()),
        buildPlayCard(),
      ],
    );
  }

  Widget buildMusicBody() {
    return Container(
      child: Obx(() {
        var queryBean = QueryCtrl.to.musicsLive.value;
        var musicBoxs = queryBean.data ?? MusicBoxs.fromParams(boxs: []);
        var boxs = musicBoxs.boxs;

        List<MusicItem> items = [];
        for (var i = 0; i < boxs!.length; i++) {
          var box = boxs[i];
          if (box!.musics == null || box.musics!.isEmpty) continue;
          items.add(MusicItem(0, box.folder_name!, Music.fromParams()));
          items.addAll(box.musics!.map((music) {
            return MusicItem(1, "", music!);
          }).toList());
        }

        return SmartRefresher(
          controller: controller,
          enablePullDown: true,
          header: ClassicHeader(
            refreshingText: '正在刷新',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
            releaseText: '松开即可刷新',
          ),
          onRefresh: _onRefresh,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 200.0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              MusicItem item = items[index];
              if (item.flag == 0) {
                return ListTile(
                  title: Container(
                    child: Text(item.folderName,style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 20.0,
                    ),),
                  ),
                );
              } else if (item.flag == 1) {
                var music = item.music;
                return InkWell(
                  onTap: () {
                    PlayCtrl.to.playOrPause(item.music, reset: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.0),
                        Container(
                          width: 5.0,
                          height: 20.0,
                          color: BORDER_COLOR,
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Image.network(music.img_url!),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  music.title ?? "",
                                  style: const TextStyle(
                                    color: TEXT_COLOR,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "- ${music.artist ?? ""}",
                                  style: const TextStyle(
                                    color: TEXT_DARK_COLOR,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            itemCount: items.length,
          ),
        );
      }),
    );
  }

  Widget buildPlayCard() {
    return Obx(() {
      MusicManger musicManager = PlayCtrl.to.selectMusic.value;
      bool isSelect = musicManager.music != null;
      return AnimatedPositioned(
        left: 20.0,
        right: 20.0,
        bottom: isSelect ? 40 : -100,
        duration: Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
              color: CARD_COLOR, borderRadius: BorderRadius.circular(10.0)),
          child: isSelect ? playCard(musicManager) : Container(),
        ),
      );
    });
  }

  Widget playCard(MusicManger manger) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "${manger.music!.title!}-${manger.music!.artist!}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: BORDER_COLOR,
                  ),
                ),
              ),
              Container(
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  manger.music!.desc!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: TEXT_DARK_COLOR,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '${(manger.seek ~/ 60).toString().padLeft(2, '0')}'
                  ':${(manger.seek % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Container(
                  child: SliderTheme(
                    data: SliderTheme.of(context),
                    child: Slider(
                      min: 0,
                      max: manger.duration.toDouble(),
                      value: manger.seek.toDouble(),
                      label: '${(manger.seek ~/ 60).toString().padLeft(2, '0')}'
                          ':${(manger.seek % 60).toString().padLeft(2, '0')}',
                      divisions: manger.duration == 0 ? 1 : manger.duration,
                      onChanged: (double value) {
                        PlayCtrl.to.seek(value.toInt());
                      },
                      activeColor: BORDER_COLOR,
                      inactiveColor: Colors.white70,
                      thumbColor: BORDER_COLOR,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${(manger.duration ~/ 60).toString().padLeft(2, '0')}'
                  ':${(manger.duration % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //下拉刷新加载数据
  void _onRefresh() async {
    print('下拉刷新');
    await QueryCtrl.to.queryMusics();
    print('完成刷新');
    controller.refreshCompleted();
  }
}
