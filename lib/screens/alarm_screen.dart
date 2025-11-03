import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_assesment/constants/text_strings.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants/image_strings.dart';

class AlarmScreen extends StatefulWidget {
  final String locationName;
  final DateTime dateTime;

  const AlarmScreen({
    super.key,
    required this.locationName,
    required this.dateTime,
  });

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime dateTime = DateTime(2025, 11, 3, 1, 33);

  final List<Widget> _list = []; // notification data list

  @override
  void initState() {
    super.initState();
    ///Allow Notification
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Allow Notification'),
            content: const Text(
              'Our app would like to send your notifications',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Don't Allow",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  /// unique id generator
  int createUniqueId() =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);

  /// Create Notification + Add to list
  Future<void> createNotification() async {
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title:
              '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
          body: '${dateTime.year}-${dateTime.month}-${dateTime.day}',
          notificationLayout: NotificationLayout.Inbox,
        ),
      );

      Get.snackbar(
        'Hurrah!',
        'Notification Created Successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Update list to show on screen
      setState(() {
        _list.add(
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF082257),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${dateTime.year}/${dateTime.month}/${dateTime.day}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //Toggle switch
                        ToggleSwitch(
                          minWidth: 40.0,
                          minHeight: 30,
                          cornerRadius: 20.0,
                          activeBgColors: [
                            [Colors.white!],
                            [Colors.white!],
                          ],
                          activeFgColor: Colors.white,
                          inactiveBgColor: const Color(0xFF012C77),
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          radiusStyle: true,
                          onToggle: (index) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Background color
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF0A2D73)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                /// Selected location Text
                Text(
                  nSelected,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                /// Add your location Button
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFFFFF),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.asset(location, height: 30, color: Colors.white54),
                      Expanded(
                        child: Text(
                          widget.locationName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),

                ///Alarms
                const SizedBox(height: 20),
                Text(
                  nAlarm,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ///Alarms Button
                const SizedBox(height: 20),
                /// Display list
                Expanded(child: ListView(children: _list)),
              ],
            ),
          ),
        ),
        ///Bottom right
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Color(0xFF5200FF),
          foregroundColor: Colors.white,
          onPressed: () async {
            await _pickDateTime();
            await createNotification();
           
          },
          child: Icon(Icons.add, size: 24),
        ),
      ),
    );
  }

  ///show Date and Time both
  Future<void> _pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      this.dateTime = dateTime;
    });
  }

  ///show Date picker only
  Future<DateTime?> pickDate() => showDatePicker(
    initialDate: dateTime,
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  ///show Time picker only
  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
  );
}

