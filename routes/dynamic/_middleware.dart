import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(_dynamicRoutesMiddleware);
}

Handler _dynamicRoutesMiddleware(Handler handler) {
  Future<Response> dynamicRoutesMiddleware(RequestContext context) async {
    print('[dynamic] before rquest');

    final request = await handler(context);
    
    print('[dynamic] before rquest');

    return request;
  }

  return dynamicRoutesMiddleware;
}
