import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/providers/post_provider.dart';
import 'package:riverpod_examples/screens/form_add_post.dart';
import 'package:riverpod_examples/screens/form_update_post.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {

  void deletePost(id) {
    ref.read(postNotifierData.notifier).deletePost(id);
  }

  void navigateToFormUpdate(id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormUpdatePost(id: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post List"),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormAddPost()))
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(postListProvider);
          await ref.read(postListProvider.future);
        },
        child: Center(
          child: data.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(data[index].title!),
                    subtitle: Text(data[index].body!),
                    tileColor:
                        index % 2 == 0 ? Colors.amber[100] : Colors.green[100],
                    trailing: TextButton(
                      onPressed: () => deletePost(data[index].id),
                      child: const Text("Delete"),
                    ),
                    onTap: () => navigateToFormUpdate(data[index].id),
                  );
                },
              );
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
