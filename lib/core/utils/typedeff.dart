import 'package:education_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;
