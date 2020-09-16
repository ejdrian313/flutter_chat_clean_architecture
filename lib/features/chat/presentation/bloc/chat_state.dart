import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ChatState {}

class Loading extends ChatState {}

class Loaded extends ChatState {
  final Stream<List<MessageEntity>> messages;

  Loaded({@required this.messages});

  @override
  List<Object> get props => [messages];
}

class Error extends ChatState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}