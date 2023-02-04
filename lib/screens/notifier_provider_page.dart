import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increase() {
    state++;
  }
}

class NotifierProviderPage extends ConsumerWidget {
  NotifierProviderPage({super.key});
  final counterProvder = NotifierProvider<Counter, int>(Counter.new);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("notifier_provider")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'A Provider which exposes a Notifier and listens to it.'),
            Consumer(builder: (context, ref, child) {
              return Text('count: ${ref.watch(counterProvder)}');
            })
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () => ref.read(counterProvder.notifier).increase(),
        child: const Text("Add"),
      ),
    );
  }
}
