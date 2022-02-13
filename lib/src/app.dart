import 'package:flutter/material.dart';
import 'package:lucky/src/theme/theme.dart';
import 'package:lucky/src/view/home/home_controller.dart';
import 'package:lucky/src/view/home/home_view.dart';
import 'package:provider/provider.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      supportedLocales: const [Locale('en', '')],
      theme: MyTheme.defaultTheme,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case HomeView.routeName:
              default:
                return ChangeNotifierProvider(
                  create: (context) => homeController,
                  child: const HomeView(),
                );
            }
          },
        );
      },
    );
  }
}
