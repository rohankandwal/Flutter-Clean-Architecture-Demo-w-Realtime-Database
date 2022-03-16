import 'package:dartz/dartz.dart';
import 'package:clean_demo/core/error/failures.dart';
import 'package:clean_demo/core/network/network_info.dart';
import 'package:clean_demo/features/data/datasource/local_datasource.dart';
import 'package:clean_demo/features/data/datasource/remote_datasource.dart';
import 'package:clean_demo/features/data/model/feed_model.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/domain/repositories/repository.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  Future<Either<Failure, Stream<List<FeedEntity>>>> getFeedStream() async {
    return Right(localDataSource.getFeeds().asBroadcastStream().map((event) {
      return List.generate(event.length, (index) {
        final FeedModel feedModel = event.elementAt(index);
        return FeedEntity(
            id: feedModel.id,
            title: feedModel.title,
            description: feedModel.description,
            mediaPath: feedModel.mediaPath);
      });
    }));
  }

  @override
  Future<Either<Failure, bool>> addNewFeedPost({
    required final int id,
    required final String title,
    required final String description,
    required final String mediaPath,
  }) async {
    final success = await localDataSource.addNewFeedPost(
        id: id, title: title, description: description, mediaPath: mediaPath);
    return Right(success);
  }

  @override
  Future<Either<Failure, List<FeedEntity>>> getFeeds() async {
    final items = localDataSource.getFeedPosts().map((e) => FeedEntity(
        id: e.id,
        title: e.title,
        description: e.description,
        mediaPath: e.mediaPath)).toList();
    return Right(items);
  }
}
