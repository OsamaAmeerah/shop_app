import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavBar extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCateogriesState extends ShopStates{}
class ShopErrorCateogriesState extends ShopStates{}

class ShopSuccessChangeFavoriteState extends ShopStates{

    final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}
class ShopChangeFavoriteState extends ShopStates{}
class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoriteState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
 final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  final LoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}
class ShopLoadingUpdateUserState extends ShopStates{}