import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopstates.dart';
import 'loginscreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).profileModel;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return Center(
          child: Conditional.single(
              fallbackBuilder: (BuildContext context) =>
                  CircularProgressIndicator(),
              conditionBuilder: (BuildContext context) =>
                  ShopCubit.get(context).profileModel != null,
              context: context,
              widgetBuilder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is ShopLoadingUpdateUserDataState)
                            LinearProgressIndicator(
                              color: Colors.blue,
                              backgroundColor: Colors.grey,
                            ),
                          SizedBox(height: 10.0),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0),
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 150.0,
                          ),
                          defaultFormField(
                            label: 'Name',
                            type: TextInputType.name,
                            controller: nameController,
                            prefix: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Name Must Not Be Empty';
                              }
                            },
                          ),
                          defaultFormField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email Must Not Be Empty';
                              }
                            },
                          ),
                          defaultFormField(
                            label: 'Phone',
                            type: TextInputType.phone,
                            controller: phoneController,
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Phone Must Not Be Empty';
                              }
                            },
                          ),
                          defaultButton(
                              onPressed: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  if (value) {
                                    CacheHelper.removeData(key: 'onBoarding')
                                        .then((value) {
                                      if (value) {
                                        navigateAndFinish(
                                            context, ShopLoginScreen());
                                      }
                                    });
                                  }
                                });
                              },
                              text: 'LOGOUT'),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'UPDATE')
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
