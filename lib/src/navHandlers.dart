import 'package:flutter/material.dart';

abstract class NavHandler {
  NavHandler(String _label) {
    navigatorKey = GlobalKey<NavigatorState>(debugLabel: _label);
  }

  late GlobalKey<NavigatorState> navigatorKey;
  NavigatorState? get navigatorState => navigatorKey.currentState;

  Route<dynamic> generateRoute(RouteSettings settings);
}



abstract class StatefulNavHandler extends NavHandler {
  StatefulNavHandler(String label, {String initialRoute='/'}) : super(label) {
    _order.add(initialRoute);
    currentScreen = initialRoute;
  }

  List<String> _order = [];

  late String currentScreen;

  Map<String, Object?> arguments = Map();

  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    currentScreen = name;
    _order.add(name);
    print(currentScreen);
    this.arguments[name] = arguments;
    return await navigatorState!.pushNamed<T>(name);
  }

  void pop<T>([T? result]) async {
    _order.removeLast();
    currentScreen = _order.last;
    print(currentScreen);
    navigatorState!.pop(result);
  }

  void popToNamed(String name, {Object? arguments}) {
    int index = _order.indexOf(name);
    _order.removeRange(index + 1, _order.length - 1);
    currentScreen = name;
    this.arguments[name] = arguments;
    navigatorState!
        .pushNamedAndRemoveUntil(name, (route) => route.settings.name == name);
  }

  Future<bool> maybePop() async {
    final result = navigatorState!.canPop();
    if (result) {
      _order.removeLast();
      print(_order.length);
      currentScreen = _order.last;
      print(currentScreen);
    }
    return navigatorState!.maybePop();
  }
}
