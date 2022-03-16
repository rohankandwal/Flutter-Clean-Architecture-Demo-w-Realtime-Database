import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_demo/core/usecase/usecase.dart';
import 'package:clean_demo/core/utils/constants.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/domain/usecase/get_feed_stream_usecase.dart';
import 'package:clean_demo/features/domain/usecase/get_feeds_use_case.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';

part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedsUseCase _getFeedsUseCase;
  final GetFeedStreamUseCase _getFeedStreamUseCase;

  StreamSubscription<List<FeedEntity>>? _feedSubscription;

  FeedBloc(
      {required final GetFeedsUseCase getFeedsUseCase,
      required final GetFeedStreamUseCase getFeedStreamUseCase})
      : _getFeedsUseCase = getFeedsUseCase,
        _getFeedStreamUseCase = getFeedStreamUseCase,
        super(FeedInitial()) {
    on<GetFeedStreamEvent>(_mapGetFeedsState);
    on<GetAllFeedsEvent>(_mapGetAllFeedState);
    on<AllFeedEventLoaded>(_mapAllFeedLoadedState);
  }

  _mapGetFeedsState(
      final GetFeedStreamEvent getFeedsEvent, final Emitter<FeedState> emit) {
    _feedSubscription?.cancel();
    emit(FeedLoadingState());
    _getFeedStreamUseCase.call(NoParams()).then((event) {
      event.fold((l) => Left(Constants.NO_DATA), (r) {
        _feedSubscription = r.listen(
          (data) {
            add(AllFeedEventLoaded(data));
          },
        );
      });
    });
  }

  _mapGetAllFeedState(final GetAllFeedsEvent getAllFeedsEvent,
      final Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    final result = await _getFeedsUseCase.call(NoParams());
    result.fold((l) => emit(FeedErrorState()), (r) => add(AllFeedEventLoaded(r)/*emit(FeedLoadedState(r)*/));
  }

  _mapAllFeedLoadedState(final AllFeedEventLoaded eventLoaded, final Emitter<FeedState> emit) {
    print("Is Emitter done = ${emit.isDone}");
    /// For some reason, emitting only 1 state is not working..
    emit(FeedLoadingState());
    emit(FeedLoadedState(eventLoaded.feeds));
  }


  @override
  Future<void> close() {
    _feedSubscription?.cancel();
    return super.close();
  }
}
