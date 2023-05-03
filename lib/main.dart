import 'package:firebase_core/firebase_core.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/firebase_options.dart';
import 'package:seekers/view/authentication/login_page.dart';
import 'package:seekers/view/main_page.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _HomePageState();
}

class _HomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    User? user  = auth.currentUser;
    return MaterialApp(
      title: 'Seekers',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        navigationBarTheme:  NavigationBarThemeData(
          backgroundColor: appOrange,
          indicatorColor: selectedNavBar,
          indicatorShape: const CircleBorder(
            side: BorderSide(
              color: selectedNavBar,
              width: 15,
              strokeAlign: StrokeAlign.center,
            )
          ),
          labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )
            ), 
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              size: 39,
              color: Colors.white,
            )
          ),
          height: 90,
        )
      ),
      
      home: 
          (user != null)
            ? const MainPage()
            : const LoginPage()
    );
  }
}
