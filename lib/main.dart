import 'package:flutter/material.dart';
import 'package:notification_tutorial/notification_service.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize notification settings
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Notification'),
    );
  }
}
