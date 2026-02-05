import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (RequestContext context) async {
    print('[root] before request: ');

    final response = await handler(context);

    print('[root] after request: ');

    return response;
  };
}
