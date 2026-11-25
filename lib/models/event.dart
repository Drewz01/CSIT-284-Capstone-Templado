class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;

  /// Pre-existing attendees (seed data). Your own RSVP is added on top.
  final int baseAttendees;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.baseAttendees = 0,
  });
}
