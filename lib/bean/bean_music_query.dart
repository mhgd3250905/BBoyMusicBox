import 'dart:convert' show json;

class MusicQueryBean {

  int? cursor;
  int? err;
  String? err_msg;
  String? token;
  MusicBoxs? data;

  MusicQueryBean.fromParams({this.cursor, this.err, this.err_msg, this.token, this.data});

  factory MusicQueryBean(Object jsonStr) => jsonStr is String ? MusicQueryBean.fromJson(json.decode(jsonStr)) : MusicQueryBean.fromJson(jsonStr);

  static MusicQueryBean? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : MusicQueryBean(jsonStr);

  MusicQueryBean.fromJson(jsonRes) {
    cursor = jsonRes['cursor'];
    err = jsonRes['err'];
    err_msg = jsonRes['err_msg'];
    token = jsonRes['token'];
    data = jsonRes['data'] == null ? null : MusicBoxs.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"cursor": $cursor, "err": $err, "err_msg": ${err_msg != null?'${json.encode(err_msg)}':'null'}, "token": ${token != null?'${json.encode(token)}':'null'}, "data": $data}';
  }

  String toJson() => this.toString();
}

class MusicBoxs {

  List<MusicBox?>? boxs;

  MusicBoxs.fromParams({this.boxs});

  MusicBoxs.fromJson(jsonRes) {
    boxs = jsonRes['boxs'] == null ? null : [];

    for (var boxsItem in boxs == null ? [] : jsonRes['boxs']){
      boxs!.add(boxsItem == null ? null : MusicBox.fromJson(boxsItem));
    }
  }

  @override
  String toString() {
    return '{"boxs": $boxs}';
  }

  String toJson() => this.toString();
}

class MusicBox {

  String? folder_name;
  List<Music?>? musics;

  MusicBox.fromParams({this.folder_name, this.musics});

  MusicBox.fromJson(jsonRes) {
    folder_name = jsonRes['folder_name'];
    musics = jsonRes['musics'] == null ? null : [];

    for (var musicsItem in musics == null ? [] : jsonRes['musics']){
      musics!.add(musicsItem == null ? null : Music.fromJson(musicsItem));
    }
  }

  @override
  String toString() {
    return '{"folder_name": ${folder_name != null?'${json.encode(folder_name)}':'null'}, "musics": $musics}';
  }

  String toJson() => this.toString();
}

class Music {

  int? duration;
  int? upload_time;
  String? artist;
  String? desc;
  String? img_url;
  String? key;
  String? name;
  String? title;
  String? uploader;
  String? url;

  Music.fromParams({this.duration, this.upload_time, this.artist, this.desc, this.img_url, this.key, this.name, this.title, this.uploader, this.url});

  Music.fromJson(jsonRes) {
    duration = jsonRes['duration'];
    upload_time = jsonRes['upload_time'];
    artist = jsonRes['artist'];
    desc = jsonRes['desc'];
    img_url = jsonRes['img_url'];
    key = jsonRes['key'];
    name = jsonRes['name'];
    title = jsonRes['title'];
    uploader = jsonRes['uploader'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"duration": $duration, "upload_time": $upload_time, "artist": ${artist != null?'${json.encode(artist)}':'null'}, "desc": ${desc != null?'${json.encode(desc)}':'null'}, "img_url": ${img_url != null?'${json.encode(img_url)}':'null'}, "key": ${key != null?'${json.encode(key)}':'null'}, "name": ${name != null?'${json.encode(name)}':'null'}, "title": ${title != null?'${json.encode(title)}':'null'}, "uploader": ${uploader != null?'${json.encode(uploader)}':'null'}, "url": ${url != null?'${json.encode(url)}':'null'}}';
  }

  String toJson() => this.toString();
}