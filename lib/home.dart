import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_tutorial/notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  NotificationService.showNotififation();
                },
                child: const Text('Show Notification')),
            ElevatedButton(
                onPressed: () {
                  NotificationService.showPeriodicNotification(
                      id: 0,
                      title: 'Period Per minute',
                      body: 'Period Body',
                      repeatInterval: RepeatInterval.everyMinute);
                },
                child: const Text('Show Period Notification')),
            ElevatedButton(
                onPressed: () {
                  NotificationService.stopNotification(id: 0);
                },
                child: const Text('Stop Period Notification')),
            ElevatedButton(
                onPressed: () {
                  NotificationService.setScheduledNotification(
                      id: 1,
                      title: 'Schedule Notification',
                      body: 'Schedule Body',
                      payload: 'Schedule Payload',
                      start: DateTime.now(),
                      end: DateTime.now().add(const Duration(seconds: 10)));
                },
                child: const Text('Will show about 10 seconds')),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
