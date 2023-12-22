import 'package:bboymusics/main.dart';
import 'package:dio/dio.dart';

class HttpManager {
  static final _instance = HttpManager._();

  factory HttpManager.getInstance() => _instance;

  Dio? _dio;

  HttpManager._() {
    BaseOptions options = BaseOptions(
      // headers: {
      //   HttpHeaders.userAgentHeader:
      //       'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Mobile Safari/537.36',
      // },
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    _dio = new Dio(options);

    tesDio();
  }

  void tesDio() async {
    var response = await _dio!.get('$BASE_HOST/mark/v1/');
    print(response.data);
  }

  Dio? get dio => _dio;
}
