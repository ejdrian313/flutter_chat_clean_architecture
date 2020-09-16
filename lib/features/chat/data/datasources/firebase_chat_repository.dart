import 'dart:async';

import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChatRepository {
  static final path = "global_messages";
  final Firestore _firestore;

  FirebaseChatRepository(this._firestore);

  Stream<List<MessageEntity>> messages() {
    return _firestore
        .collection(path)
        .orderBy('timestamp', descending: true)
        .limit(200)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        var date =
            new DateTime.fromMicrosecondsSinceEpoch(doc['timestamp'] * 1000)
                .toString();
        return MessageEntity(
          id: doc['id'],
          date: date,
          author: doc['author'],
          timestamp: doc['timestamp'],
          text: doc['text'],
        );
      }).toList();
    });
  }

  sendMessage(MessageEntityModel message) async {
    return _firestore
        .collection(path)
        .document(message.id)
        .setData(message.toJson());
  }

  deleteMessage(String id) async {
    return _firestore.collection(path).document(id).delete();
  }
}
