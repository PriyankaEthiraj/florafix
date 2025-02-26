import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class WaterReminderScreen extends StatefulWidget {
  @override
  _WaterReminderScreenState createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  TimeOfDay? _selectedTime;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(initializationSettings);
  }

  // Function to select time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });

      _scheduleReminder(picked);
    }
  }

  // Schedule reminder logic using timezone
  void _scheduleReminder(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    _showNotification();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reminder set for ${time.format(context)}"),
      ),
    );
  }

  void _showNotification() {
    if (Platform.isAndroid || Platform.isIOS) {
      _notificationsPlugin.show(
        0,
        'Water Reminder 💧',
        'It\'s time to water your plants!',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'water_reminder_channel',
            'Water Reminder',
            channelDescription: 'Reminds you to water your plants',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Reminder 💧"),
        backgroundColor: const Color(0xFF008080), // Deep Teal
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_active,
                size: 80,
                color: Color(0xFFFFD700), // Soft Mint
              ),
              const SizedBox(height: 20),
              Text(
                _selectedTime == null
                    ? 'No reminder set yet!'
                    : 'Reminder set for: ${_selectedTime!.format(context)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008080), // Deep Teal
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Soft Mint
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Set Water Reminder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
