import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';

// ignore: constant_identifier_names
const String USER_COLLECTION = 'users';

class CloudStorageSercive {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageSercive() {}
  Future<String?> saveUserImage(String _uid, File _file) async {
    try {
      Reference _ref = _storage.ref().child('images/users/$_uid/pic.${_file}');

      /// The line `UploadTask _uploadTask = _ref.putBlob(File(fileToBytes(_file), _file.name));` is
      /// uploading a file to the Firebase Storage. Here's a breakdown of what each part is doing:
      UploadTask _uploadTask = _ref.putFile(_file);
      //  String fileName = path.basename(_file!.path);
      // UploadTask _uploadTask =;
      return await _uploadTask.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> saveChatImage(
      String _chatID, String _userID, File _file) async {
    try {
      Reference _ref = _storage.ref().child(
          'images/chats/$_chatID/${_userID}_${Timestamp.now().millisecondsSinceEpoch}.${_file}');
      UploadTask _uploadTask = _ref.putFile(_file);
      return await _uploadTask.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {}
  }
}
