import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Ensure Firebase is initialized with correct options
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const DrivaApp(),
    ),
  );
}

// Utility Functions

// Confirmation Dialog for user actions
Future<bool> showConfirmationDialog(BuildContext context, String action) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Action'),
            content: Text('Are you sure you want to $action?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Confirm'),
              ),
            ],
          );
        },
      ) ??
      false;
}

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
      SnackBar(content: Text('Selected Date: ${selectedDate.toString()}')),
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
      SnackBar(content: Text('Selected Time: ${selectedTime.format(context)}')),
    );
  }
}

// Notifications Setup

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showLocalNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'reminder_channel',
    'Reminders',
    channelDescription: 'Channel for reminder notifications',
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
