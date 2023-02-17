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
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(postListProvider);
    print(data);

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
      body: Center(
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
                    onPressed: () {
                      ref
                          .read(postProvider.notifier)
                          .deletePost(data[index].id);
                    },
                    child: const Text("Delete"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormUpdatePost(id: data[index].id!)),
                    );
                  },
                );
              },
            );
          },
          error: (error, stack) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
