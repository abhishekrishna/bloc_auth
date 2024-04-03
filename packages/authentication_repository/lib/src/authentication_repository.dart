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

  Future<void> signUp({
    required String username,
  }) async {
    print("fire function");
    //call backend api
    var response = await dio.post(
        'https://b975-2409-40e4-1093-332f-d5da-7a8a-535-419f.ngrok-free.app/auth/users',
        data: {'email': username});
    print(response.data);

    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
