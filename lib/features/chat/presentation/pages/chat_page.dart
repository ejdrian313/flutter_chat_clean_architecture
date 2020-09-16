import 'package:chatr/core/usecases/usecase.dart';
import 'package:chatr/features/chat/data/models/message_entity_model.dart';
import 'package:chatr/features/chat/domain/entities/message_entity.dart';
import 'package:chatr/features/chat/presentation/bloc/bloc.dart';
import 'package:chatr/features/chat/presentation/widgets/message_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../injection_container.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global chat'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<ChatBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return StreamBuilder(
                    stream: BlocProvider.of<ChatBloc>(context)
                        .getMessages(NoParams()),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return new Text("Error!");
                      } else if (asyncSnapshot.hasData) {
                        var streamOfMessages =
                            asyncSnapshot?.data as List<MessageEntity>;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: streamOfMessages.length,
                          itemBuilder: (BuildContext cnt, int index) {
                            final message = streamOfMessages[index];
                            return ListTile(
                              title: Text(message.author),
                              subtitle: Text(message.text),
                              trailing: Text(message.date),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: SpinKitFoldingCube(
                            color: Colors.green,
                            size: 50.0,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              MessageControlsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
