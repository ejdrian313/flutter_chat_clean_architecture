import 'package:chatr/core/usecases/usecase.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:chatr/features/chat/domain/usecases/delete_message.dart' as dm;
import 'package:chatr/features/chat/domain/usecases/get_messages.dart' as gm;
import 'package:chatr/features/chat/domain/usecases/send_message.dart' as sm;
import 'package:chatr/features/chat/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetMessages extends Mock implements gm.GetMessages {}

class MockDeleteMessage extends Mock implements dm.DeleteMessage {}

class MockSendMessage extends Mock implements sm.SendMessage {}

void main() {
  ChatBloc bloc;
  MockDeleteMessage mockDeleteMessage;
  MockSendMessage mockSendMessage;
  MockGetMessages mockGetMessages;

  setUp(() {
    mockGetMessages = MockGetMessages();
    mockSendMessage = MockSendMessage();
    mockDeleteMessage = MockDeleteMessage();

    bloc = ChatBloc(
      sendMessage: mockSendMessage,
      getMessages: mockGetMessages,
      deleteMessage: mockDeleteMessage,
    );
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });
  group('tests events', () {
    final message = MessageEntity(id: "asd", text: "null", author: "13", timestamp: 1122);
    final messages = List<MessageEntity>();
    final messageStream = Stream.fromIterable([messages]);
    test(
      'should get messaged from use case',
      () async {
        // arrange
        when(mockGetMessages(any)).thenAnswer((_) => messageStream);
        // act
        bloc.add(GetMessagesEvent());
        await untilCalled(mockGetMessages(any));
        // assert
        verify(mockGetMessages(NoParams()));
      },
    );

    test(
      'should send message',
      () async {
        // arrange
        when(mockSendMessage(any)).thenAnswer((_) async => Right(null));
        // act
        bloc.add(SendMessageEvent(message.text));
        await untilCalled(mockSendMessage(any));
        // assert
        verify(mockSendMessage(sm.Params(message: message.text)));
      },
    );

    test(
      'should delete message',
      () async {
        // arrange
        when(mockDeleteMessage(any)).thenAnswer((_) async => Right(null));
        // act
        bloc.add(DeleteMessageEvent(message));
        await untilCalled(mockDeleteMessage(any));
        // assert
        verify(mockDeleteMessage(dm.Params(id: message.id)));
      },
    );
  });
}
