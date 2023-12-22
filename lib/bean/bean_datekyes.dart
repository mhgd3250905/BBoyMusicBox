import 'dart:convert' show json;

class DateKeys {

  List<String>? keys;

  DateKeys.fromParams({this.keys});

  factory DateKeys(Object jsonStr) => jsonStr is String ? DateKeys.fromJson(json.decode(jsonStr)) : DateKeys.fromJson(jsonStr);

  static DateKeys? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : DateKeys(jsonStr);

  DateKeys.fromJson(jsonRes) {
    keys = jsonRes['keys'] == null ? null : [];

    for (var keysItem in keys == null ? [] : jsonRes['keys']){
      keys!.add('$keysItem');
    }
  }

  @override
  String toString() {
    var list=keys!.map((e) => "\"$e\"").toList();
    return '{"keys": $list}';
  }

  String toJson() => this.toString();
}