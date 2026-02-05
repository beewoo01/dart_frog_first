import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(
  RequestContext context,
  String userId,
  String postId,
) {
  final method = context.request.method;
  switch (method) {
    case HttpMethod.get:
      return Response.json(
        body: {
          'routeParameters': {
            'userId': userId,
            'postId': postId,
          },
        },
      );
      case _:
        return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
