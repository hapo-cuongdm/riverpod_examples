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

class PostNotifier extends StateNotifier<List<Post>> {
  PostNotifier():super([]);

  final _postService = PostService();

  void addPost(title, body) {
    _postService.addPost(title, body);
  }

  void deletePost(id) {
    _postService.deletePost(id);
  }

  void updatePost(id, title, body) {
    _postService.updatePost(id, title, body);
  }
}

final postNotifierData = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier();
});
