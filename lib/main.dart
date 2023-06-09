import 'package:flutter/material.dart';
import 'package:plnr_api_integration_pagination/views/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/api_provider.dart';
import 'utils/di_container.dart' as di;
import 'views/screens/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => di.sl<ApiProvider>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Details',
        initialRoute: SplashScreen.route,
        routes: {
          HomeScreen.route: (context) => const HomeScreen(),
          SplashScreen.route: (context) => const SplashScreen(),
        });
  }
}
