import 'package:chatr/features/chat/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageControlsWidget extends StatefulWidget {
  @override
  _MessageControlsWidgetState createState() => _MessageControlsWidgetState();
}

class _MessageControlsWidgetState extends State<MessageControlsWidget> {
  final controller = TextEditingController();

  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          textInputAction: TextInputAction.send,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write a message',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<ChatBloc>(context)
        .add(SendMessageEvent(inputStr));
  }
}
