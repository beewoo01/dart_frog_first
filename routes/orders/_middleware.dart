import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_first/models/car.dart';
import 'package:dart_frog_first/models/wheel.dart';

Handler middleware(Handler handler) {
  return handler.use(carProvider()).use(wheelProvider());
}

final _wheel = Wheel();

Middleware wheelProvider() {
  return provider<Wheel>((_) => _wheel);
}

Middleware carProvider() {
  return provider<Car>(
    (context) => Car(wheel: context.read<Wheel>()),
  );
}
