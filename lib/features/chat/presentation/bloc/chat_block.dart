import 'package:chatr/core/usecases/usecase.dart';
import 'package:chatr/features/chat/domain/usecases/delete_message.dart' as dm;
import 'package:chatr/features/chat/domain/usecases/get_messages.dart' as gm;
import 'package:chatr/features/chat/domain/usecases/send_message.dart' as sm;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:meta/meta.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final sm.SendMessage sendMessage;
  final dm.DeleteMessage deleteMessage;
  final gm.GetMessages getMessages;

  ChatBloc({
    @required this.sendMessage,
    @required this.deleteMessage,
    @required this.getMessages,
  })  : assert(sendMessage != null),
        assert(deleteMessage != null),
        assert(getMessages != null);

  @override
  ChatState get initialState => Empty();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is GetMessagesEvent) {
      yield Loading();
      yield Loaded(messages: getMessages(NoParams()));
    } else if (event is SendMessageEvent) {
      final result = await sendMessage(sm.Params(message: event.message));
    } else if (event is DeleteMessageEvent) {
      final result = await deleteMessage(dm.Params(id: event.messageEntity.id));
    }
  }
}
