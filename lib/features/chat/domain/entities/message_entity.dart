import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String author;
  final int timestamp;
  final String date;

  MessageEntity({
    @required this.id,
    @required this.text,
    @required this.author,
    this.date,
    this.timestamp,
  });

 @override
  List<Object> get props => [id, text, author, timestamp];
}