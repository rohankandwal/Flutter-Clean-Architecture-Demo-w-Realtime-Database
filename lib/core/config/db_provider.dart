import 'package:hive_flutter/hive_flutter.dart';
import 'package:clean_demo/features/data/model/feed_model.dart';

import '../utils/constants.dart';

class DBProvider {
  Box<FeedModel>? _feedBox;

  DBProvider() {
    Hive.registerAdapter<FeedModel>(FeedModelAdapter());
    _initializeHiveBox();
  }

  _initializeHiveBox() async {
    _feedBox = await Hive.openBox(Constants.FEED_DB);
  }

  Stream<List<FeedModel>> getFeedPostsDatabaseStream() {
    if (_feedBox == null) {
      _initializeHiveBox();
    }
    return _feedBox!.watch().map((event) => List<FeedModel>.generate(
        _feedBox!.values.length, (index) => _feedBox!.getAt(index)!));
  }

  List<FeedModel> getFeedPosts() {
    return _feedBox?.values.toList() ?? List.empty(growable: true);
  }

  Future<bool> addFeedItem({required final FeedModel feedModel}) async {
    if (_feedBox == null) {
      _initializeHiveBox();
    }
    await _feedBox?.add(feedModel);
    print(_feedBox?.toMap());
    return Future.value(true);
  }

  void changeFavorite() {}

  void changeLike() {}


/* /// Initializing the database
  _initDB() async {
    return await openDatabase(Constants.DB_NAME, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          // await db.execute("CREATE TABLE ${Constants.TABLE_USER} (");
        });
  }*/
}
