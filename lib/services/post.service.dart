import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/constants/app_constants.dart';
import 'package:riverpod_examples/models/post.dart';

class PostService extends StateNotifier<List<Post>> {
  PostService() : super([]);

  final url = AppConstants.apiUrl;
  Future<List<Post>> getPostList() async {
    Response response = await Dio().get('$url/posts');

    if (response.statusCode == 200) {
      // final List result = jsonDecode(response.data);
      // return result.map((e) => Post.fromJson(e)).toList();
      List<Post> posts = [];
      for (var item in response.data) {
        posts.add(Post.fromJson(item));
      }
      return posts;
    } else {
      throw Exception("error api");
    }
  }

  Future<Response> addPost(title, body) async {
    final response =
        await Dio().post('$url/posts', data: {'title': title, 'body': body});
    return response;
  }

  Future<Response> deletePost(id) async {
    final response = await Dio().delete('$url/posts/$id');
    return response;
  }

  Future<Post> getPostDetail(id) async {
    try {
      final response = await Dio().get('$url/posts/$id');
      Post post = Post(id: '', title: '', body: '');
      if (response.statusCode == 200) post = Post.fromJson(response.data);
      return post;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> updatePost(id, title, body) async {
    final response = await Dio().put('$url/posts/$id', data: {
      'title': title,
      'body': body,
    });
    return response;
  }
}
