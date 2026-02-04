import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final queryParameters = context.request.uri.queryParameters;
  return Response.json(
    body: {
      'queryParameters' : queryParameters
    }
  );
}
