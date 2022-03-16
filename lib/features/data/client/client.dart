import 'package:dio/dio.dart';
import 'package:clean_demo/core/config/my_shared_pref.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Remote client for interacting with remote server
@RestApi(baseUrl: "https://example.com/")
abstract class RestClient {

  /// flutter pub run build_runner build --delete-conflicting-outputs
  factory RestClient(final Dio dio, final MySharedPref sharedPref) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (option, handler) {
        return handler.resolve(Response(requestOptions:option));
    }));
    return _RestClient(dio);
  }
}