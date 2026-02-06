import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/models/user.dart';

Handler middleware(Handler handler) {
  return handler
  .use(userProvider())
  .use(asyncUserProvider())
  .use(anotherUserProvider());
}

Middleware userProvider() {
  return provider<User>((context) => const User(
    id: '1',
    username: 'john',
    email: 'john@email.com',
    ),
  );
}

Middleware anotherUserProvider() {
  return provider<User>((context) => const User(
    id: '10',
    username: 'ironman',
    email: 'ironman@email.com',
    ),
  );
}

Middleware asyncUserProvider() {
  return provider<Future<User>>((context) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return const User(
      id: '2', 
      username: 'jane', 
      email: 'jane@email.com',
      );
  });
}
