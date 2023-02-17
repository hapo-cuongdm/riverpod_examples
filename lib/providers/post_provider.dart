import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/services/post.service.dart';
import 'package:riverpod_examples/models/post.dart';

class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increase() {
    state++;
  }
}

final pageIndexProvider = StateProvider<int>((ref) => 2);

final canGoToPreviousPageProvider = Provider<bool>((ref) {
  return ref.watch(pageIndexProvider) != 0;
});

final canGoToForwardPageProvider = Provider<bool>((ref) {
  return ref.watch(pageIndexProvider) != 4;
});

final postListProvider = FutureProvider.autoDispose<List<Post>>((ref) {
  return PostService().getPostList();
});

final postDetailProvider = FutureProvider.autoDispose.family((ref, id) {
  return PostService().getPostDetail(id);
});

final postProvider =
    StateNotifierProvider.autoDispose<PostService, List<Post>>((ref) {
  return PostService();
});
