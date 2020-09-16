import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:chatr/features/chat/domain/repositories/chat_repository.dart';
import 'package:chatr/features/chat/domain/usecases/send_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockChatRepository extends Mock
    implements ChatRepository {}

void main() {
  SendMessage usecase;
  MockChatRepository mockChatRepository;

  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = SendMessage(mockChatRepository);
  });

  final id = "asdasd";
  final message = MessageEntity(id: id, author: "abc" ,timestamp: 1, text: 'test');

  test(
    'send message to the repository',
    () async {
      // arrange
      when(mockChatRepository.sendMessage(message))
          .thenAnswer((_) async => null);
      // act
      final result = await usecase(Params(message: message.text));
      // assert
      expect(result, null);
      verify(mockChatRepository.sendMessage(message));
      verifyNoMoreInteractions(mockChatRepository);
    },
  );
}
