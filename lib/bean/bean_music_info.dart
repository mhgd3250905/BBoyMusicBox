import 'dart:convert' show json;

class MusicInfoListBean {

  List<MusicInfo?>? list;

  MusicInfoListBean.fromParams({this.list});

  factory MusicInfoListBean(Object jsonStr) => jsonStr is String ? MusicInfoListBean.fromJson(json.decode(jsonStr)) : MusicInfoListBean.fromJson(jsonStr);

  static MusicInfoListBean? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : MusicInfoListBean(jsonStr);

  MusicInfoListBean.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes){
      list!.add(listItem == null ? null : MusicInfo.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '$list';
  }

  String toJson() => this.toString();
}

class MusicInfo {

  int? duration;
  String? desc;
  String? name;
  String? uploader;

  MusicInfo.fromParams({this.duration, this.desc, this.name, this.uploader});

  MusicInfo.fromJson(jsonRes) {
    duration = jsonRes['duration'];
    desc = jsonRes['desc'];
    name = jsonRes['name'];
    uploader = jsonRes['uploader'];
  }

  @override
  String toString() {
    return '{"duration": $duration, "desc": ${desc != null?'${json.encode(desc)}':'null'}, "name": ${name != null?'${json.encode(name)}':'null'}, "uploader": ${uploader != null?'${json.encode(uploader)}':'null'}}';
  }

  String toJson() => this.toString();
}