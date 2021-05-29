import 'dart:async';

import 'package:time_tracker_flutter_course/app/services/auth.dart';

class SignInBloc {
  final Auth auth;

  SignInBloc({required this.auth});

  StreamController<bool> _isLoading = StreamController<bool>();

  Stream<bool> get isLoading => _isLoading.stream;

  void _setLoading(bool isLoading) => _isLoading.add(isLoading);

  void dispose() {
    _isLoading.close();
  }

  void _signIn(Future<void> Function() signInMethod) async {
    try {
      _setLoading(true);
      await signInMethod.call();
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }

  Future<void> signInAnnonymous() async => _signIn(auth.signInAnnonymous);

  Future<void> signInWithGoogle() async => _signIn(auth.signInWithGoogle);
}