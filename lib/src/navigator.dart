import 'package:flutter/cupertino.dart';
import 'package:stateful_nav/src/navHandlers.dart';

class ZENavigator extends Navigator{
  ZENavigator({
    required NavHandler navHandler,
    String? initialRoute
  }) :super(
      key: navHandler.navigatorKey,
      onGenerateRoute: navHandler.generateRoute,
      initialRoute: initialRoute??((navHandler is StatefulNavHandler)?navHandler.currentScreen:'/')
  ){
    print(navHandler.toString() +' '+ (navHandler is StatefulNavHandler).toString());
  }
}