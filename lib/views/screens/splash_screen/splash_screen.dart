import 'package:flutter/material.dart';
import 'package:plnr_api_integration_pagination/controllers/api_provider.dart';
import 'package:plnr_api_integration_pagination/utils/dimensions.dart';
import 'package:plnr_api_integration_pagination/views/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static final String route = 'splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false)
          .getUserData(pageNumber: 1);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 1.0,
      upperBound: 10.0,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(builder: (context, apiProvider, child) {
      if (apiProvider.firstLoading) {
        return Center(
            child: ScaleTransition(
          scale: _animationController,
          child: const FlutterLogo(
            size: Dimensions.FLUTTER_LOGO_SIZE,
          ),
        ));
      } else {
        return const HomeScreen();
      }
    });
  }
}
