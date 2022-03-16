part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent extends Equatable {

  @override
  List<Object> get props {
    return [];
  }
}

class GetFeedStreamEvent extends FeedEvent {}

class GetAllFeedsEvent extends FeedEvent {}

class AllFeedEventLoaded extends FeedEvent {
  final List<FeedEntity> feeds;

  AllFeedEventLoaded(this.feeds);
}