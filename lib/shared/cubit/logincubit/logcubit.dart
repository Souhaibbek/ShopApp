import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/network/endpoints.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/cubit/logincubit/logstates.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({

    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassShow = true;

  void changeSuffixIcon() {
    isPassShow = !isPassShow;
    suffix = isPassShow ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginPasswordChangeVisibilityState());
  }
}
