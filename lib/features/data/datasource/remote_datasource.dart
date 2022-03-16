
import 'package:clean_demo/features/data/client/client.dart';

/// Abstract class to get/push data from Remote Server
abstract class RemoteDataSource {}

/// Implementation class to get/push data from Remote Server
class RemoteDataSourceImpl extends RemoteDataSource {
  final RestClient client;

  RemoteDataSourceImpl({required this.client});
}