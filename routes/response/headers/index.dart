import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final headers = {
    ...context.request.headers,
    'token': DateTime.now().toIso8601String(),
  };

  return Response.json(headers: headers, body: headers);
}
