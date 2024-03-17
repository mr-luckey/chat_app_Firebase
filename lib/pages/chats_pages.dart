import 'package:chat_app/Wiget/Custom_listview.dart';
import 'package:chat_app/Wiget/top_bar.dart';
import 'package:chat_app/providers/chats_page_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth_provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double _height;
  late double _width;
  late ChatPageProvide _pageProvider;
  late Authprovider _auth;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _auth = Provider.of<Authprovider>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider<ChatPageProvide>(
        create: (_) {
          return ChatPageProvide(_auth);
        },
      ),
    ], child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext _context) {
      _pageProvider = _context.watch<ChatPageProvide>();
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: _width * 0.03, vertical: _height * 0.02),
        height: _height * 0.98,
        width: _width * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Topbar(
              'chats',
              primaryAction: IconButton(
                onPressed: () {
                  _auth.logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(0, 82, 218, 1.0),
                ),
              ),
            ),
            _chatsList(),
          ],
        ),
      );
    });
  }

  Widget _chatsList() {
    return Expanded(child: _chatTile());
  }

  Widget _chatTile() {
    return CustomListView(
        height: _height * 0.10,
        title: "Naseer Ahmed",
        subtitle: "hello naseer ahmed",
        imagePath: "https://i.pravatar.cc/150?img=3",
        isActive: true,
        isActivity: false,
        onTap: () {});
  }
}
