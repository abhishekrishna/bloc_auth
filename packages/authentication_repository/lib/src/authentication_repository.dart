import 'dart:async';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  final dio = Dio();

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    print("fire function");
    //call backend api
    var response = await dio.post(
        'https://2f27-152-59-143-206.ngrok-free.app/auth/users',
        data: {'email': username});
    print(response.data);
    print("fire function");
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
