import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String _route) {
    navigatorKey.currentState?.pushNamed(_route);
  }

  void removeAndNavigateTo(
    String _route,
  ) {
    navigatorKey.currentState?.popAndPushNamed(_route);
  }

  void navigateToPage(Widget _page) {
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (BuildContext _context) => _page));
  }

  voidgoBack() {
    navigatorKey.currentState?.pop();
  }
}
