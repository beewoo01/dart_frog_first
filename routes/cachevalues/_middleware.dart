import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/repository/post_repository.dart';
import 'package:http/http.dart' as http;

Handler middleware(Handler handler) {
  return handler.use(postRepositoryProvider()).use(httpProvider());
}

http.Client? _httpClient;

Middleware httpProvider() {
  return provider<http.Client>((context) => _httpClient ??= http.Client());
}

PostRepository? _postRepository;

Middleware postRepositoryProvider() {
  return provider<PostRepository>(
    (context) => 
    _postRepository ??= PostRepository(
      context.read<http.Client>()
      ,),
  );
}
