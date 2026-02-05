import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (RequestContext context) async {
    print('[dynamic] before request: ');

    final response = await handler(context);

    print('[dynamic] after request: ');

    return response;
  };
}
