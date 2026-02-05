import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (RequestContext context) async {
    print('[post] before request: ');

    final response = await handler(context);

    print('[post] after request: ');

    return response;
  };
}
