import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const DrivaApp(),
    ),
  );
}

import 'package:flutter/material.dart';

// Confirmation Dialog for user actions
Future<bool> showConfirmationDialog(BuildContext context, String action) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Action'),
        content: Text('Are you sure you want to \$action?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User canceled
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  ) ?? false;
}

import 'package:flutter/material.dart';

// Date Picker
Future<void> showDatePickerDialog(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (selectedDate != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected Date: \$selectedDate')),
    );
  }
}

// Time Picker
Future<void> showTimePickerDialog(BuildContext context) async {
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected Time: \$selectedTime')),
    );
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize Notifications
void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Show Local Notification
Future<void> showLocalNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'reminder_channel',
    'Reminders',
    'Channel for reminder notifications',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Reminder',
    'This is a local notification alert!',
    platformChannelSpecifics,
  );
}
