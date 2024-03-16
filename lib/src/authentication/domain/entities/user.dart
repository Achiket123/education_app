import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createdat;
  final String name;
  final String avatar;

  const User(
      {required this.id,
      required this.createdat,
      required this.name,
      required this.avatar});

  const User.empty()
      : this(
            avatar: '_empty_.string',
            name: '_empty_.string',
            id: '1',
            createdat: '_empty_.string');

  @override
  List<Object?> get props => [id, name, avatar];
}
