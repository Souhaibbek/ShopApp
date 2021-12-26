import 'package:shopapp/models/changefavorites_model.dart';
import 'package:shopapp/models/getprofile.dart';
import 'package:shopapp/models/homemodel.dart';
import 'package:shopapp/models/loginmodel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBotNavBarState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  final String error;

  ShopErrorChangeFavoritesState(this.error, this.model);
}

class ShopSuccessGetFavState extends ShopStates {}

class ShopLoadingGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {
  final String error;

  ShopErrorGetFavState(this.error);
}

class ShopSuccessGetUserDataState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ProfileModel userModel;

  ShopSuccessUpdateUserDataState(this.userModel);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}
