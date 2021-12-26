import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categoriesmodel.dart';
import 'package:shopapp/models/changefavorites_model.dart';
import 'package:shopapp/models/getfavmodel.dart';
import 'package:shopapp/models/getprofile.dart';
import 'package:shopapp/models/homemodel.dart';
import 'package:shopapp/modules/categoriesscreen.dart';
import 'package:shopapp/modules/favoritesscreen.dart';
import 'package:shopapp/modules/productscreen.dart';
import 'package:shopapp/modules/settingsscreen.dart';
import 'package:shopapp/network/endpoints.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopstates.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> botNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  int currentIndex = 0;

  void changeNavBarIndex(index) {
    currentIndex = index;
    emit(ShopChangeBotNavBarState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());
    if (homeModel == null) {
      print('-------IF------');
      DioHelper.getData(
        url: HOME,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);

        homeModel!.data.products.forEach((element) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        });
        emit(ShopHomeSuccessState());
        print('---------------');
        print(homeModel!.status.toString());
        print('---------------');
      }).catchError((error) {
        print(error.toString());
        emit(ShopHomeErrorState(error));
      });
    } else {
      print('------ElSE----');
      emit(ShopHomeSuccessState());
    }
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      token: token,
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFav(int productId) {
    if (favorites[productId] == true) {
      favorites[productId] = false;
    } else {
      favorites[productId] = true;
    }

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        if (favorites[productId] == true) {
          favorites[productId] = false;
        } else {
          favorites[productId] = true;
        }
        emit(ShopErrorChangeFavoritesState('error', changeFavoritesModel!));
      } else {
        print(value.data);
        getFavoritesData();
        emit(ShopSuccessChangeFavoritesState());
      }
    }).catchError((error) {
      if (favorites[productId] == true) {
        favorites[productId] = false;
      } else {
        favorites[productId] = true;
      }
      print(error.toString());
      emit(ShopErrorChangeFavoritesState(error, changeFavoritesModel!));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavState());
    DioHelper.getData(
      token: token,
      url: FAVORITES,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavState(error));
    });
  }

  ProfileModel? profileModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      token: token,
      url: PROFILE,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      token: token,
      url: UPDATEPROFILE,
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessUpdateUserDataState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error));
    });
  }
}
