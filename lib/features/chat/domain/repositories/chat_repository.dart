import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages();
  Future sendMessage(MessageEntityModel message);
  Future deleteMessage(String id);
}