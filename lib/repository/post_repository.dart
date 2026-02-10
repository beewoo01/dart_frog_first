import 'dart:convert';

import 'package:dart_frog_first/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  const PostRepository(this.client);

  final http.Client client;

  Future<Post> getPost(int id) async {
    try {
      print('id is $id');
      final response = await client.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/$id',
        ),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Accept': 'application/json',
        },
      );
      print('response.statusCode is ${response.statusCode}');
      if (response.statusCode != 200) {
        throw Exception('Fail to fetch post');
      }

      final jsonPost = jsonDecode(response.body) as Map<String, dynamic>;

      final post = Post.fromJson(jsonPost);

      return post;
    } catch (e) {
      rethrow;
    }
  }
}
