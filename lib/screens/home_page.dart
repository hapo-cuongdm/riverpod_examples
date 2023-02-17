import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/screens/counter_screen.dart';
import 'package:riverpod_examples/screens/paginate_screen.dart';
import 'package:riverpod_examples/screens/post_list_screen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Example'),
            ),
            ListTile(
              title: const Text('Notifier Provider'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CounterScreen(),
                    ));
              },
            ),
            ListTile(
              title: const Text('State Provider'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaginateScreen()));
              },
            ),
            ListTile(
              title: const Text('Post List'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostListScreen()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Riverpod Examples"),
      ),
    );
  }
}
