import 'dart:convert';

import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdat,
      required super.name,
      required super.avatar});

  const UserModel.empty()
      : this(
            avatar: "_empty_string",
            id: "_empty_string",
            createdat: "_empty_string",
            name: "_empty_string");

  UserModel.fromMap(DataMap map)
      : this(
            avatar: map['avatar'] as String,
            id: map['id'] as String,
            createdat: map['createdAt'] as String,
            name: map['name'] as String);

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() =>
      {"id": id, "createdAt": createdat, "name": name, "avatar": avatar};

  String toJson() => jsonEncode(toMap());

  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdat,
    String? name,
  }) {
    return UserModel(
        id: id ?? this.id,
        createdat: createdat ?? this.createdat,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar);
  }
}
