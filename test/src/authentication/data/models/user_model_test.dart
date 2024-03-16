import 'dart:convert';
import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', () {
    test('should return a [UserModel] with the correct data', () {
      // arrange

      // act

      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  group('fromJson', () {
    test('should return a [UserModel] with the correct data', () {
      // arrange

      // act

      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the correct data', () {
      final result = tModel.toMap();

      // arrange

      // act
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the correct data', () {
      final result = tModel.toJson();

      // arrange
      final tJson = jsonEncode({
        "id": "_empty_string",
        "createdat": "_empty_string",
        "name": "_empty_string",
        "avatar": "_empty_string",
      });

      // act
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'paul');

      expect(result.name, equals('paul'));
    });
  });
}
