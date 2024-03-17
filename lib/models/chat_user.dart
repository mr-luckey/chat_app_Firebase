class ChatUser {
  final String name;
  final String uid;
  final String email;
  final String imageUrl;
  late DateTime lastActive;

  ChatUser({
    required this.name,
    required this.uid,
    required this.email,
    required this.imageUrl,
    required this.lastActive,
  });
  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      name: json['name'],
      uid: json['uid'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      lastActive: json['lastActive'].toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "uid": uid,
      "imageUrl": imageUrl,
      "lastActive": lastActive,
    };
  }

  String lastDayActive() {
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  bool wasRecentlyActive() {
    return DateTime.now().difference(lastActive).inHours < 2;
  }
}
