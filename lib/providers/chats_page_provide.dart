import 'dart:async';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'Auth_provider.dart';

class ChatPageProvide extends ChangeNotifier {
  late Authprovider _auth;
  late DatabaseService _db;
  List<chat>? chats;
  late StreamSubscription _chatsStream;
  ChatPageProvide(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream =
          _db.getChatsForUser(_auth.user.uid).listen((_snapshot) async {
        chats = await Future.wait(_snapshot.docs.map((_d) async {
          Map<String, dynamic> _chatData = _d.data as Map<String, dynamic>;
          List<ChatUser> _members = [];
          for (var _uid in _chatData["members"]) {
            DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
            Map<String, dynamic> _userData =
                _userSnapshot.data() as Map<String, dynamic>;
            _userData["uid"] = _userSnapshot.id;
            _members.add(ChatUser.fromJson(_userData));
          }
          List<ChatMessage> _messages = [];
          QuerySnapshot _chatMessage = await _db.getLastMessage(_d.id);
          if (_chatMessage.docs.isNotEmpty) {
            Map<String, dynamic> _messageData =
                _chatMessage.docs.first.data()! as Map<String, dynamic>;
            ChatMessage _message = ChatMessage.fromJSON(_messageData);
            _messages.add(_message);
          }
          return chat(
              uid: _d.id,
              currentUserID: _auth.user.uid,
              activity: _chatData["is_activity"],
              group: _chatData["is_group"],
              members: _members,
              message: _messages);
        }).toList());
        notifyListeners();
      });
    } catch (e) {}
  }
}
