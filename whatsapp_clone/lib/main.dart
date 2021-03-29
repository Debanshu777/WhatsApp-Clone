import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Screens/CameraScreen.dart';
import 'Screens/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: Color(0xFF075E54),
          accentColor: Color(0xFF128C7E)),
      home: HomeScreen(),
    );
  }
}
