import 'package:alab_technology/controllers/login_controller.dart';
import 'package:alab_technology/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:alab_technology/screens/signup_screen.dart';
import 'package:alab_technology/screens/login_screen.dart';
import 'package:alab_technology/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "",
      appId: "",
      messagingSenderId: "",
      projectId: "",
      storageBucket: "",
    ),
  );

  // Initialize the controllers
  Get.put(LoginController());
  Get.put(SignupController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> getInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedIn = FirebaseAuth.instance.currentUser != null;
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // First-time user should start at the signup screen
      await prefs.setBool('isFirstTime', false);
      return '/signup';
    }
    return isSignedIn ? '/home' : '/login';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Show a loading indicator
        }

        return GetMaterialApp(
          title: 'Alab Technology',
          theme: ThemeData(
            primaryColor: const Color(0xFFD5715B),
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: snapshot.data as String,
          getPages: [
            GetPage(
              name: '/signup',
              page: () => SignUpScreen(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: '/login',
              page: () => LoginScreen(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: '/home',
              page: () => Home(),
              transition: Transition.fadeIn,
              middlewares: [RouteGuard()],
            ),
          ],
          defaultTransition: Transition.fadeIn,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// Middleware to protect routes
class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = FirebaseAuth.instance;
    // Redirect to login if user is not authenticated and trying to access '/home'
    if (auth.currentUser == null && route == '/home') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
