import 'package:dart_frog/dart_frog.dart';

class NeverInvoked {
  final String neverInvoked = 'NeverInvoked'; 
}

Handler middleware(Handler handler) {
  return handler.use(neverInvokedProvider());
}


Middleware neverInvokedProvider() {
  return provider<NeverInvoked>((context) {
    print('neerInvoked create callback');
    return NeverInvoked();
  });
}
