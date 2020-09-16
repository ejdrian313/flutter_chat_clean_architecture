import 'package:chatr/core/network/network_info.dart';
import 'package:chatr/features/chat/data/datasources/firebase_chat_repository.dart';
import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:chatr/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseChatRepository firebaseChatRepository;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    @required this.firebaseChatRepository,
    @required this.networkInfo,
  });

  @override
  Future deleteMessage(String id) {
    return firebaseChatRepository.deleteMessage(id);
  }

  @override
  Stream<List<MessageEntity>> getMessages() {
    return firebaseChatRepository.messages();
  }

  @override
  Future sendMessage(MessageEntityModel m) {
    return firebaseChatRepository.sendMessage(m);
  }
}
