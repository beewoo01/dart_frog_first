import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  switch(method) {
    case HttpMethod.post:
      final formData = await context.request.formData();
      return Response.json(
        body: {
          'formData.type': '${formData.runtimeType}',
          'formData.fields': formData.fields,
          'formData.fields type': '${formData.fields.runtimeType}',
          'formData.files': formData.files,
          'formData.files type': '${formData.fields.runtimeType}'
        }
      );
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
