import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(
  RequestContext context,
  String id,
) {
  switch (context.request.method) {
    case HttpMethod.get:
      return Response.json(
        body: {
          'id': id,
          'message': 'Post with $id',
          'queryParameter': context.request.uri.queryParameters,
        },
      );
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
