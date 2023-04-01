import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) 
  {
    return MaterialApp(
        title: 'Material App',
        initialRoute: HomeScreen.route,
        routes: {
          HomeScreen.route: (context) => const HomeScreen(),
        });
  }
}
