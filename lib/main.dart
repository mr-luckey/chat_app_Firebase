import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'models/routes.dart';
import 'pages/login.dart';
import 'services/navigation_service.dart';
import 'providers/Auth_provider.dart';

void main() {
  runApp(SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MainApp());
      }));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Authprovider>(
            create: (BuildContext _context) {
              return Authprovider();
            },
          ),
        ],
        child: GetMaterialApp(
          title: 'chatify',
          theme: ThemeData(
            backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
            scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
            navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Color.fromRGBO(30, 29, 37, 1.0)),
          ),
          getPages: [
            GetPage(name: AppRoutes.login, page: () => LoginView()),
            GetPage(
              name: AppRoutes.home,
              page: () => const HomePage(),
            ),
            GetPage(
              name: AppRoutes.register,
              page: () => const RegisterPage(),
            ),
          ],
          initialRoute: AppRoutes.login,
          navigatorKey: NavigationService.navigatorKey,
        ));
    // home: SplashPage(
    //   key: UniqueKey(),
    //   onInitializationComplete: () {},
    // ));
  }
}
