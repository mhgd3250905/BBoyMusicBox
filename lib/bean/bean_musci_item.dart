
import 'package:bboymusics/bean/bean_music_query.dart';

class MusicItem{
  int flag;//标记0 -> folderName 1-> Music
  String folderName="";
  Music music=Music.fromParams();

  MusicItem(this.flag,this.folderName, this.music);

}