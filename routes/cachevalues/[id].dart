import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/repository/post_repository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  final method = context.request.method;

  return switch (method) {
    HttpMethod.get => _handleGet(context, id),
    _ => Future.value(
      Response(statusCode: HttpStatus.methodNotAllowed),
    ),
  };
}


Future<Response> _handleGet(
  RequestContext context,
  String id,
) async {
  try {
    print('?????????');
    final postRepository = context.read<PostRepository>();
    final postId = int.parse(id);
    final post = await postRepository.getPost(postId);
    return Response.json(body: post);
  } on FormatException {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'message': '$id is not valid integer'},
    );
  } catch (e) {
    print(e);
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'message': 'Server error, try later'},
    );
  }
}
