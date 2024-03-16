import 'package:education_app/core/utils/typedeff.dart';

abstract class UseCasewithParams<Type,Params> {
  ResultFuture<Type> call(Params params);
}

abstract class UseCasewithoutParams<Type> {
  ResultFuture<Type> call();
}
