import 'package:clean_demo/core/config/db_provider.dart';
import 'package:clean_demo/core/config/my_shared_pref.dart';
import 'package:clean_demo/features/data/model/feed_model.dart';

/// Abstract class for saving/loading data from local storage
abstract class LocalDataSource {
  Stream<List<FeedModel>> getFeeds();

  List<FeedModel> getFeedPosts();

  Future<bool> addNewFeedPost({
    required final int id,
    required final String title,
    required final String description,
    required final String mediaPath,
  });
}

/// Implementation class used for saving/loading data from Local storage
class LocalDataSourceImpl extends LocalDataSource {
  final MySharedPref mySharedPref;
  final DBProvider dbProvider;

  LocalDataSourceImpl({
    required this.mySharedPref,
    required this.dbProvider,
  });

  @override
  Stream<List<FeedModel>> getFeeds() {
    return dbProvider.getFeedPostsDatabaseStream();
  }

  @override
  Future<bool> addNewFeedPost({
    required final int id,
    required final String title,
    required final String description,
    required final String mediaPath,
  }) {
    return dbProvider.addFeedItem(feedModel: FeedModel(id: id, title: title, description: description, mediaPath: mediaPath));
  }

  @override
  List<FeedModel> getFeedPosts() {
    return dbProvider.getFeedPosts();
  }
}
