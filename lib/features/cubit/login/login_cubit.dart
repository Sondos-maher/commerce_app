
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String pass) async {
    emit(AuthLoading());

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: pass,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code}');

      Get.snackbar(
        'Login Failed',
        _getErrorMessage(e.code),
      );

      emit(AuthError());
    } catch (e) {
      print(e.toString());

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
      );

      emit(AuthError());
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Email or password is incorrect.';
      case 'invalid-email':
        return 'Please enter a valid email.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}
