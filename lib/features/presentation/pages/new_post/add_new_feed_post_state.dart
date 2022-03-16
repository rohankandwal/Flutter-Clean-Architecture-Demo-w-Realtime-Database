part of 'add_new_feed_post_bloc.dart';

@immutable
abstract class AddNewFeedPostState extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class AddNewFeedPostInitial extends AddNewFeedPostState {}

class AddNewFeedPostLoadingState extends AddNewFeedPostState {}

class AddNewFeedPostLoadedState extends AddNewFeedPostState {}

class AddNewFeedPostErrorState extends AddNewFeedPostState {}

