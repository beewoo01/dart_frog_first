import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../routes/request/body/form/urlencoded.dart' as route;

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

  group('POST /request/body/form/urlencoded', () {
    final contentTypeFormUrlEncodedHeader = {
      HttpHeaders.contentTypeHeader: ContentType(
        'application',
        'x-www-form-urlencoded',
      ).mimeType,
    };

    const tEmptyFormData = FormData(fields: {}, files: {});

    const tFormData = FormData(
      fields: {
        'username': 'john',
        'password': '123456',
      },
      files: {},
    );

    test('should respond with 200 and empty formData', () async {
      final request = Request.post(
        Uri.parse('http://localhost/'),
        headers: contentTypeFormUrlEncodedHeader,
      );
      when(() => context.request).thenReturn(request);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.json(),
        completion(
          equals(
            {
              'formData.type': 'FormData',
              'formData.fields': const <String, String>{},
              'formData.fields type': 'UnmodifiableMapView<String, String>',
              'formData.files': const <String, dynamic>{},
              'formData.files type':
                  'UnmodifiableMapView<String, UploadedFile>',
            },
          ),
        ),
      );
    });

    test('should respond with 200 and empty formData with MockRequest',
        () async {
      final request = _MockRequest();
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.headers).thenReturn(contentTypeFormUrlEncodedHeader);
      when(request.formData).thenAnswer((_) async => tEmptyFormData);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.json(),
        completion(
          equals(
            {
              'formData.type': 'FormData',
              'formData.fields': const <String, String>{},
              'formData.fields type': 'UnmodifiableMapView<String, String>',
              'formData.files': const <String, dynamic>{},
              'formData.files type':
                  'UnmodifiableMapView<String, UploadedFile>',
            },
          ),
        ),
      );
    });

    test('should respond with 200, formDataType, formData', () async {
      final request = Request.post(
        Uri.parse('http://localhost/'),
        headers: contentTypeFormUrlEncodedHeader,
        body: 'username=john&password=123456',
      );
      when(() => context.request).thenReturn(request);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.json(),
        completion(
          equals(
            {
              'formData.type': 'FormData',
              'formData.fields': {
                'username': 'john',
                'password': '123456',
              },
              'formData.fields type': 'UnmodifiableMapView<String, String>',
              'formData.files': const <String, dynamic>{},
              'formData.files type':
                  'UnmodifiableMapView<String, UploadedFile>',
            },
          ),
        ),
      );
    });

    test('should respond with 200, formDataType, formData with MockRequest',
        () async {
      final request = _MockRequest();
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.headers).thenReturn(contentTypeFormUrlEncodedHeader);
      when(request.formData).thenAnswer((_) async => tFormData);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.json(),
        completion(
          equals(
            {
              'formData.type': 'FormData',
              'formData.fields': {
                'username': 'john',
                'password': '123456',
              },
              'formData.fields type': 'UnmodifiableMapView<String, String>',
              'formData.files': const <String, dynamic>{},
              'formData.files type':
                  'UnmodifiableMapView<String, UploadedFile>',
            },
          ),
        ),
      );
    });
  });
}
