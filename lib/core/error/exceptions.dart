import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final int statuscode;
  const ApiException({required this.message, required this.statuscode});

  @override
  List<Object?> get props => [message,statuscode];
}
