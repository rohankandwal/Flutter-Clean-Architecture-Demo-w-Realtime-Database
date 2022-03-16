import 'package:dartz/dartz.dart';
import 'package:clean_demo/core/error/failures.dart';
import 'package:clean_demo/core/usecase/usecase.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/domain/repositories/repository.dart';

class GetFeedStreamUseCase extends UseCase<Stream<List<FeedEntity>>, NoParams> {
  final Repository _repository;


  GetFeedStreamUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<FeedEntity>>>> call(NoParams params) {
    return _repository.getFeedStream();
  }


}