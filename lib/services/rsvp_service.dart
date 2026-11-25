import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';

/// Keeps the current student ID and all RSVPs on the device.
/// RSVPs are stored as { studentId: [eventId, ...] }.
class RsvpService extends ChangeNotifier {
  static const _idKey = 'student_id';
  static const _rsvpKey = 'rsvps';

  late final SharedPreferences _prefs;
  String? _studentId;
  final Map<String, Set<String>> _rsvps = {};

  String? get studentId => _studentId;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _studentId = _prefs.getString(_idKey);

    final raw = _prefs.getString(_rsvpKey);
    if (raw != null) {
      try {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        decoded.forEach((student, ids) {
          _rsvps[student] = (ids as List).map((e) => e.toString()).toSet();
        });
      } catch (_) {
        // Corrupt data: start fresh instead of crashing.
        _rsvps.clear();
      }
    }
  }

  Future<void> setStudent(String id) async {
    _studentId = id;
    await _prefs.setString(_idKey, id);
    notifyListeners();
  }

  Future<void> clearStudent() async {
    _studentId = null;
    await _prefs.remove(_idKey);
    notifyListeners();
  }

  bool isGoing(String eventId) {
    final id = _studentId;
    if (id == null) return false;
    return _rsvps[id]?.contains(eventId) ?? false;
  }

  /// Seed attendees plus every student on this device who RSVP'd.
  int attendeeCount(Event event) {
    final rsvps = _rsvps.values.where((ids) => ids.contains(event.id)).length;
    return event.baseAttendees + rsvps;
  }

  Future<void> toggleRsvp(String eventId) async {
    final id = _studentId;
    if (id == null) return;

    final ids = _rsvps.putIfAbsent(id, () => <String>{});
    if (!ids.remove(eventId)) ids.add(eventId);

    await _prefs.setString(
      _rsvpKey,
      jsonEncode(_rsvps.map((k, v) => MapEntry(k, v.toList()))),
    );
    notifyListeners();
  }
}
