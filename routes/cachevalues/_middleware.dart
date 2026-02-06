import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/repository/post_repository.dart';
import 'package:http/http.dart' as http;

Handler middleware(Handler handler) {
  return handler.use(postRepositoryProvider());
}

PostRepository? _postRepository;

Middleware postRepositoryProvider() {
  return provider<PostRepository>(
    (context) => _postRepository ??= PostRepository(http.Client()),
  );
}
