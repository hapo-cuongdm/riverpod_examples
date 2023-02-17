import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/providers/post_provider.dart';

class PaginateScreen extends ConsumerWidget {
  const PaginateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider.notifier);
    final canGotoPreviousPage = ref.watch(canGoToPreviousPageProvider);
    final canGotoForwardPage = ref.watch(canGoToForwardPageProvider);

    void goToPreviousPage() {
      ref.read(pageIndexProvider.notifier).update((state) => state - 1);
    }

    void goToForwardPage() {
      ref.read(pageIndexProvider.notifier).update((state) => state + 1);
    }

    void updatePaginate() {
      ref.read(pageIndexProvider.notifier).update((state) => state + 2);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: canGotoPreviousPage ? goToPreviousPage : null,
                child: const Text("Previous"),
              ),
              const SizedBox(
                width: 5,
              ),
              Text('${pageIndex.state}'),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                onPressed: canGotoForwardPage ? goToForwardPage : null,
                child: const Text("Forward"),
              ),
            ],
          ),
          TextButton(
              onPressed: () => updatePaginate(), child: const Text('Update'))
        ],
      ),
    );
  }
}
