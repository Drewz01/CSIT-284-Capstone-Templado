import '../models/event.dart';

/// Hardcoded events (no admin UI needed). Edit freely.
List<Event> buildSeedEvents() {
  final now = DateTime.now();
  DateTime at(int days, int hour) =>
      DateTime(now.year, now.month, now.day + days, hour);

  return [
    Event(
      id: 'e1',
      title: 'Intramurals Opening Ceremony',
      description:
          'Parade of teams, torch lighting, and the opening game. Wear your team colors!',
      location: 'School Grounds',
      date: at(2, 8),
      baseAttendees: 124,
    ),
    Event(
      id: 'e2',
      title: 'Career Orientation Talk',
      description:
          'Alumni share their career paths in IT, business, and engineering.',
      location: 'Auditorium',
      date: at(4, 13),
      baseAttendees: 58,
    ),
    Event(
      id: 'e3',
      title: 'Programming Contest',
      description:
          'Solo problem-solving contest. Bring your own laptop. Open to all year levels.',
      location: 'Computer Lab 2',
      date: at(6, 9),
      baseAttendees: 31,
    ),
    Event(
      id: 'e4',
      title: 'Blood Donation Drive',
      description:
          'In partnership with the Red Cross. Eat breakfast and bring a valid ID.',
      location: 'Gymnasium',
      date: at(8, 8),
      baseAttendees: 42,
    ),
    Event(
      id: 'e5',
      title: 'Foundation Day Concert',
      description: 'Live performances from student bands and dance groups.',
      location: 'Open Court',
      date: at(12, 17),
      baseAttendees: 210,
    ),
    Event(
      id: 'e6',
      title: 'Library Book Fair',
      description: 'Discounted books and a used-book swap table.',
      location: 'Library Lobby',
      date: at(15, 10),
      baseAttendees: 17,
    ),
  ];
}
