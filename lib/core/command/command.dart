import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';

abstract class Command<TResult, Params> {
  Future<Result<Failure, TResult>> execute(Params params);
}

