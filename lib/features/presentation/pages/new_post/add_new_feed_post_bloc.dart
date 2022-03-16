import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_demo/features/domain/usecase/add_new_feed_post_usecase.dart';
import 'package:meta/meta.dart';

part 'add_new_feed_post_event.dart';

part 'add_new_feed_post_state.dart';

class AddNewFeedPostBloc
    extends Bloc<AddNewFeedPostEvent, AddNewFeedPostState> {
  final AddNewFeedPostUseCase _addNewFeedPostUseCase;

  AddNewFeedPostBloc(
      {required final AddNewFeedPostUseCase addNewFeedPostUseCase})
      : _addNewFeedPostUseCase = addNewFeedPostUseCase,
        super(AddNewFeedPostInitial()) {
    on<AddNewPostEvent>(_mapAddNewPostEvent);
  }

  void _mapAddNewPostEvent(final AddNewPostEvent event,
      final Emitter<AddNewFeedPostState> emitter) async {
    emitter(AddNewFeedPostLoadingState());
    final result = await _addNewFeedPostUseCase.call(AddNewFeedPostParams(
        id: event.id,
        title: event.title,
        description: event.description,
        mediaPath: event.mediaPath));
    result.fold((failure) {
      emitter(AddNewFeedPostErrorState());
    }, (loadedDataEntity) {
      emitter(AddNewFeedPostLoadedState());
    });
  }
}
