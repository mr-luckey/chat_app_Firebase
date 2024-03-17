import 'package:chat_app/services/cloud_storage_service.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/mediac_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({required Key key, required this.onInitializationComplete})
      : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
        (_) => _Setup().then((_) => widget.onInitializationComplete()),
        onError: (error) => print(error));
    // _Setup().then((_) => widget.onInitializationComplete(),
    //     onError: (error) => print(error));

    // Future.delayed(Duration(seconds: 2), widget.onInitializationComplete);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'chatify',
        theme: ThemeData(
            backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
            scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0)),
        home: Scaffold(
            body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.png'), fit: BoxFit.contain)),
          ),
        )));
  }

  Future<void> _Setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance
        .registerSingleton<CloudStorageSercive>(CloudStorageSercive());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }
}
