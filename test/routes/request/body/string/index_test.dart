import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../../../../routes/request/body/string/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

void main() {
  late RequestContext context;

  setUp(() {
    context = _MockRequestContext();
  });

  group('for methods other than POST', () {
    test('should response with 405', () async {
      final request = Request.get(
        Uri.parse('http://localhost/'),
      );

      when(() => context.request).thenReturn(request);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
      expect(response.body(), completion(isEmpty));
    });

    test('should respond with 405 with MockRequest', () async {
      final request = _MockRequest();
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.get);
      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
      await expectLater(response.body(), completion(isEmpty));
    });
  });

  group('for methods other thanm POST', () {});

  group('POST /requyest/body/string', () {
    final contentTypeTextPlainHeader = {
      HttpHeaders.contentTypeHeader: ContentType('text', 'plain').mimeType,
    };

    test(
        'should response with a 200, with bodyType and content with MockRequest',
        () async {
      // final context = _MockRequestContext();
      final request = _MockRequest();
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.headers).thenReturn(contentTypeTextPlainHeader);
      when(request.body).thenAnswer((_) async => 'String type body');
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
          equals('bodyType: String, content: String type body'),
        ),
      );
    });
  });
}
