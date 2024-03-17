import 'package:flutter/material.dart';

enum MessageType { TEXT, IMAGE, UNKNOWN }

class ChatMessage {
  final String senderID;
  final MessageType type;
  final String content;
  final DateTime sentTime;
  ChatMessage({
    required this.senderID,
    required this.type,
    required this.content,
    required this.sentTime,
  });
  factory ChatMessage.fromJSON(Map<String, dynamic> json) {
    MessageType _messageType;
    switch (json["type"]) {
      case 'text':
        _messageType = MessageType.TEXT;
        break;
      case 'image':
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }
    return ChatMessage(
      senderID: json['senderID'],
      type: _messageType,
      content: json['content'],
      sentTime: json['sentTime'].toDate(),
    );
  }
  Map<String, dynamic> tojson() {
    String _messageType;
    switch (type) {
      case MessageType.TEXT:
        _messageType = 'text';
        break;
      case MessageType.IMAGE:
        _messageType = 'image';
        break;
      default:
        _messageType = '';
    }
    return {
      'senderID': senderID,
      'type': _messageType,
      'content': content,
      'sentTime': sentTime,
    };
  }
}
