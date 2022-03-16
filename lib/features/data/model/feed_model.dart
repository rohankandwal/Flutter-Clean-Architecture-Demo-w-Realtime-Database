import 'package:hive/hive.dart';

part 'feed_model.g.dart';

@HiveType(typeId: 0)
class FeedModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String mediaPath;
  @HiveField(4)
  int isLiked;
  @HiveField(5)
  int isFavorite;

  FeedModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.mediaPath,
      this.isLiked = 0,
      this.isFavorite = 0}); // 0 means false, 1 is true

}
