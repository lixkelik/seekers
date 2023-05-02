import 'package:flutter/material.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/view/main_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      
      home: const MainPage(),
    );
  }
}
