import 'package:firebase_core/firebase_core.dart';
import 'package:visiontalk/restart_app.dart';
import 'package:visiontalk/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDEK48meceM4XpLTeRKrB6S8eZRq1OvpBI",
        appId: "1:810730734394:android:fded3c38b96142f9e84603",
        messagingSenderId: "810730734394",
        projectId: "vision-talk"),
  );
  runApp(const RestartWidget(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Vision Talk",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        primaryColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.checkConnectivity,
      onGenerateRoute: RouteGenerator.generatRoute,
    );
  }
}
