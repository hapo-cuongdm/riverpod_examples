import 'package:dio/dio.dart';
import 'package:riverpod_examples/constants/app_constants.dart';
import 'package:riverpod_examples/models/post.dart';

class PostService {
  final url = AppConstants.apiUrl;

  Future<List<Post>> getPostList() async {
    try {
      Response response = await Dio().get('$url/posts');
      // final result = jsonDecode(response.data) as List;
      // final posts = result.map((e) {
      //   return Post.fromJson(e);
      // }).toList();
      List<Post> posts = [];
      for (var item in response.data) {
        posts.add(Post.fromJson(item));
      }
      return posts;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Response> addPost(title, body) async {
    try {
      final response =
          await Dio().post('$url/posts', data: {'title': title, 'body': body});
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Response> deletePost(id) async {
    try {
      final response = await Dio().delete('$url/posts/$id');
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Post> getPostDetail(id) async {
    try {
      final response = await Dio().get('$url/posts/$id');
      Post post = Post(id: '', title: '', body: '');
      if (response.statusCode == 200) post = Post.fromJson(response.data);
      return post;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Response> updatePost(id, title, body) async {
    try {
      final response = await Dio().put('$url/posts/$id', data: {
        'title': title,
        'body': body,
      });
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }
}
