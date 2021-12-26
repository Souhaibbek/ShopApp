import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/modules/registerscreen.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/logincubit/logcubit.dart';
import 'package:shopapp/shared/cubit/logincubit/logstates.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';

class ShopLoginScreen extends StatefulWidget {
  @override
  _ShopLoginScreenState createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var logEmailController = TextEditingController();
  var logPasswordController = TextEditingController();
  var logFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                showToast(
                    msg: state.loginModel.message, state: ToastStates.SUCCESS);
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data.token)
                    .then((value) {
                      token = state.loginModel.data.token;
                  navigateAndFinish(context, ShopLayout());
                });
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
                      key: logFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                              label: 'Email',
                              type: TextInputType.emailAddress,
                              controller: logEmailController,
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
                              controller: logPasswordController,
                              prefix: Icons.lock,
                              onSubmit: (value) {
                                if (logFormKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: logEmailController.text,
                                      password: logPasswordController.text);
                                }
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please Insert Password';
                                }
                              },
                              isPass: ShopLoginCubit.get(context).isPassShow,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context).changeSuffixIcon();
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                state is! ShopLoginLoadingState,
                            fallbackBuilder: (context) =>
                                Center(child: CircularProgressIndicator()),
                            widgetBuilder: (context) {
                              return defaultButton(
                                onPressed: () {
                                  if (logFormKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: logEmailController.text,
                                        password: logPasswordController.text);
                                  }
                                },
                                text: 'Login',
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
                              Text('D\'ont have an account ?'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text('Register !'.toUpperCase()),
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
        ));
  }
}
