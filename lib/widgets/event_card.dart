import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int attendeeCount;
  final bool isGoing;
  final VoidCallback onToggle;

  const EventCard({
    super.key,
    required this.event,
    required this.attendeeCount,
    required this.isGoing,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateText = DateFormat('EEE, MMM d, h:mm a').format(event.date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.event, text: dateText),
            const SizedBox(height: 4),
            _InfoRow(icon: Icons.place_outlined, text: event.location),
            if (event.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(event.description, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.people_outline,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text(
                  attendeeCount == 1 ? '1 attending' : '$attendeeCount attending',
                  style: theme.textTheme.labelLarge,
                ),
                const Spacer(),
                isGoing
                    ? OutlinedButton.icon(
                        onPressed: onToggle,
                        icon: const Icon(Icons.check),
                        label: const Text("You're going"),
                      )
                    : FilledButton(
                        onPressed: onToggle,
                        child: const Text('RSVP'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
