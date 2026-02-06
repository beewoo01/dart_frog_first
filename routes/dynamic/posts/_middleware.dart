import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(_postsRoutesMiddleware);
}

Handler _postsRoutesMiddleware(Handler handler) {
  return (RequestContext context) async {
    print('[post] before request: ');

    final response = await handler(context);

    print('[post] after request: ');

    return response;
  };
}
