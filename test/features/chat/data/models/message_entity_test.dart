import 'dart:convert';

import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('ChatEntity test', () {
    test('not equal', () async {
      final one = MessageEntityModel(
          id: "Mzc4e3tmg", author: "Me", text: "example", timestamp: 1122);
      final two = MessageEntityModel(
          id: "diffrent", author: "Me", text: "example", timestamp: 1122);

      expect(one == two, equals(false));
    });

    test('equal', () async {
      final one = MessageEntityModel(
          id: "Mzc4e3tmg", author: "Me", text: "example", timestamp: 1122);
      final two = MessageEntityModel(
          id: "Mzc4e3tmg", author: "Me", text: "example", timestamp: 1122);

      expect(one == two, equals(true));
    });
  });

  MessageEntityModel messageEntity;
  setUp(() {
    messageEntity = MessageEntityModel(
      id: "Mzc4e3tmg",
      author: "Me",
      text: "example",
      timestamp: 1122,
    );
  });

  group('test json serialization', () {
    test(
      'should return a valid model from Json',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('message.json'));

        final result = MessageEntityModel.fromJson(jsonMap);

        expect(result, messageEntity);
      },
    );

    test(
      'should return a JSON map containing the proper data',
      () async {
        final result = messageEntity.toJson();
        final Map<String, dynamic> expectedMap = {
          "id": "Mzc4e3tmg",
          "text": "example",
          "author": "Me",
          "timestamp": 1122
        };

        expect(result, expectedMap);
      },
    );
  });
}
