import 'package:flutter/material.dart';

import 'chat_message.dart';
import 'chat_user.dart';

class chat {
  final String uid;
  final String currentUserID;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> message;
  late final List<ChatUser> _recipients;
  chat({
    required this.uid,
    required this.currentUserID,
    required this.activity,
    required this.group,
    required this.members,
    required this.message,
  }) {
    _recipients = members.where((_i) => _i.uid != currentUserID).toList();
  }
  List<ChatUser> recepitents() {
    return _recipients;
  }

  String title() {
    return !group
        ? _recipients.first.name
        : _recipients.map((_user) => _user.name).join(",");
  }

  String imageURL() {
    return !group ? _recipients.first.imageUrl : "";
  }
}
