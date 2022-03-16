part of 'add_new_feed_post_bloc.dart';

@immutable
abstract class AddNewFeedPostEvent extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class AddNewPostEvent extends AddNewFeedPostEvent {
  final int id;
  final String title;
  final String description;
  final String mediaPath;
  final bool isLiked;
  final bool isFavorite;

  AddNewPostEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaPath,
    required this.isLiked,
    required this.isFavorite,
  });
}
