import 'package:flutter/material.dart';
import '../services/rsvp_service.dart';
import 'events_list_view.dart';

class HomeScreen extends StatefulWidget {
  final RsvpService service;
  const HomeScreen({super.key, required this.service});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_index == 0 ? 'Events' : 'My Events'),
        actions: [
          Center(
            child: Text('ID: ${widget.service.studentId}',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          IconButton(
            tooltip: 'Switch student ID',
            icon: const Icon(Icons.logout),
            onPressed: widget.service.clearStudent,
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          EventsListView(service: widget.service, onlyMine: false),
          EventsListView(service: widget.service, onlyMine: true),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'My Events',
          ),
        ],
      ),
    );
  }
}
