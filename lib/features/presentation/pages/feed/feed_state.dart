part of 'feed_bloc.dart';

@immutable
abstract class FeedState extends Equatable {

  @override
  List<Object> get props {
    return [];
  }
}

class FeedInitial extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedErrorState extends FeedState {}

class FeedLoadedState extends FeedState {
  final List<FeedEntity> feeds;

  FeedLoadedState(this.feeds);

}
