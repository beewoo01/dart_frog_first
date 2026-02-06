import 'package:dart_frog/dart_frog.dart';

import '_middleware.dart';

Response onRequest(RequestContext context) {
  final neverInvoked = context.read<NeverInvoked>();
  return Response.json(body: {
    'hashCode': neverInvoked.hashCode,
  },);
}
