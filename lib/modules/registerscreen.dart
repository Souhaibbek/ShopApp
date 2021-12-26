import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/registercubit/regcubit.dart';
import 'package:shopapp/shared/cubit/registercubit/regstates.dart';

import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var regNameController = TextEditingController();
  var regPhoneController = TextEditingController();
  var regEmailController = TextEditingController();
  var regPasswordController = TextEditingController();
  var regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              showToast(
                  msg: state.loginModel.message, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) => navigateAndFinish(context, ShopLayout()));
            } else {
              showToast(
                  msg: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: regFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            label: 'Username',
                            type: TextInputType.name,
                            controller: regNameController,
                            prefix: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Username';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: regEmailController,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Email';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            controller: regPasswordController,
                            prefix: Icons.lock,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Password';
                              }
                            },
                            isPass: ShopRegisterCubit.get(context).isPassShow,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context).changeSuffixIcon();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: regPhoneController,
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Insert Phone Number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ShopRegisterLoadingState,
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          widgetBuilder: (context) {
                            return defaultButton(
                              onPressed: () {
                                if (regFormKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: regEmailController.text,
                                      password: regPasswordController.text,
                                      username: regNameController.text,
                                      phone: regPhoneController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true,
                            );
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You Have An Account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopLoginScreen());
                              },
                              child: Text('Login!'.toUpperCase()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
