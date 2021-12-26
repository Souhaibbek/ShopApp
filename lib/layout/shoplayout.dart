import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/searchscreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/appcubit/appcubit.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopstates.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('My Shop'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
                ),
                IconButton(onPressed: () {
                  print(AppCubit.get(context).isDark);
                  AppCubit.get(context).changeAppMode();
                  print(AppCubit.get(context).isDark);
                }, icon: Icon(Icons.brightness_4)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.botNavBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBarIndex(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
