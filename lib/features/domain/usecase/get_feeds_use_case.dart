import 'package:dartz/dartz.dart';
import 'package:clean_demo/core/error/failures.dart';
import 'package:clean_demo/core/usecase/usecase.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/domain/repositories/repository.dart';

class GetFeedsUseCase extends UseCase<List<FeedEntity>, NoParams> {
  final Repository _repository;


  GetFeedsUseCase(this._repository);

  @override
  Future<Either<Failure, List<FeedEntity>>> call(NoParams params) {
    return _repository.getFeeds();
  }


}