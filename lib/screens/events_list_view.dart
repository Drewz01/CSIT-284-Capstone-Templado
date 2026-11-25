import 'package:flutter/material.dart';
import '../data/seed_events.dart';
import '../services/rsvp_service.dart';
import '../widgets/event_card.dart';

/// Shared list used by both tabs.
/// When [onlyMine] is true, only events the student RSVP'd to are shown.
class EventsListView extends StatelessWidget {
  final RsvpService service;
  final bool onlyMine;

  const EventsListView({
    super.key,
    required this.service,
    required this.onlyMine,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        var events = buildSeedEvents()
          ..sort((a, b) => a.date.compareTo(b.date));
        if (onlyMine) {
          events = events.where((e) => service.isGoing(e.id)).toList();
        }

        if (events.isEmpty) {
          return const _EmptyMessage(
            text:
                "You haven't RSVP'd to any events yet. Find one on the Events tab.",
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: events.length,
          itemBuilder: (context, i) {
            final event = events[i];
            return EventCard(
              key: ValueKey(event.id),
              event: event,
              attendeeCount: service.attendeeCount(event),
              isGoing: service.isGoing(event.id),
              onToggle: () => service.toggleRsvp(event.id),
            );
          },
        );
      },
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  final String text;
  const _EmptyMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border,
                size: 56, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text(text,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
