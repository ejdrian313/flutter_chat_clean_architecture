import 'package:chatr/core/error/failures.dart';
import 'package:chatr/core/usecases/usecase.dart';
import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:chatr/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shortid/shortid.dart';

class SendMessage implements UseCase<MessageEntity, Null> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Null>> call(Params params) async {
    var message = MessageEntityModel(
      id: shortid.generate(),
      text: params.message,
      author: "Me",
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    return await repository.sendMessage(message);
  }
}

class Params extends Equatable {
  final String message;

  Params({@required this.message});

  @override
  List<Object> get props => [message];
}
