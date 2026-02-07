import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/models/car.dart';

Response onRequest(RequestContext context) {
  try {
    final car = context.read<Car>();
    return Response(body: car.toString());
  } catch (e) {
    return Response(
      statusCode: HttpStatus.failedDependency,
      body: e.toString(),
    );
  }
}
