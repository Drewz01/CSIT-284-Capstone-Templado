import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/student_id_screen.dart';
import 'services/rsvp_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = RsvpService();
  await service.load();
  runApp(EventRsvpApp(service: service));
}

class EventRsvpApp extends StatelessWidget {
  final RsvpService service;
  const EventRsvpApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: ListenableBuilder(
        listenable: service,
        builder: (context, _) {
          if (service.studentId == null) {
            return StudentIdScreen(onSubmit: service.setStudent);
          }
          return HomeScreen(service: service);
        },
      ),
    );
  }
}
