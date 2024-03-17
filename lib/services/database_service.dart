import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = 'users';
const String CHAT_COLLECTION = 'chats';
const String MESSAGE_COLLECTION = 'messages';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService() {}
  Future<void> createUser(
    String _uid,
    String _email,
    String _name,
    String _imageURL,
  ) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).set({
        "name": _name,
        "email": _email,
        "imageUrl": _imageURL,
        "lastActive": DateTime.now().toUtc(),
      });
    } catch (e) {}
  }

  Future<DocumentSnapshot> getUser(String _uid) {
    return _db.collection(USER_COLLECTION).doc(_uid).get();
  }

  Future<void> updateUserLastSeenTime(String _uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update({
        "lastActive": DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }
}