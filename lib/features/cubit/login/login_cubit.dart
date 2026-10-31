
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/helpers/hive_helper.dart';
import '../../../core/helpers/network/api_const.dart';
import '../../../core/helpers/network/network_helper.dart';
import '../../model/login_model.dart';
import '../../view/home_screen.dart';
import 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  LoginModel loginModel = LoginModel();

  void login(String email, String pass) async {
    emit(AuthLoading());

    try {
      final result = await NetworkHelper.postData(
        path: ApiConst.login,
        body: {
          "email": email,
          "password": pass,
        },
      );

      loginModel = LoginModel.fromJson(result.data);

      if (loginModel.statusCode == 200) {
        /// Navigate To Home
        HiveHelper.setToken(loginModel.data?.token ?? "");

        Get.offAll(HomePage());

        emit(AuthSuccess());
      } else {
        Get.snackbar(
          "Error",
          loginModel.message ?? "",
          backgroundColor: Colors.red,
        );

        emit(AuthError());
      }
    } catch (e) {
      print(e.toString());
      emit(AuthError());
    }
  }
}
