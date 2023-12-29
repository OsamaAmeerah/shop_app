import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/favorits_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/cateogries/cateogries_screen.dart';
import 'package:shopapp/modules/favorites/favorites_screen.dart';
import 'package:shopapp/modules/products/products_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import '../../models/cateogries_model.dart';
import '../../models/change_favorites_model.dart';
import '../../shared/network/end_point.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  Map<int ,bool> favorites = {};

List<Widget> bottomScreens = [
    ProductsScreen(),
   CateogriesScreen(),
   FavoritesScreen(),
   SettingsScreen(),

];

void changeBottom(int index)
{
  currentIndex = index;
  emit(ShopChangeBottomNavBar());
}

  HomeModel? homeModel;
void getHomeData()
{
  emit(ShopLoadingHomeDataState());
DioHelper.getData(
    url: HOME,
  token: token,
).then((value) {
  homeModel = HomeModel.fromJson(value.data);
  homeModel!.data!.products.forEach((element) {
    favorites.addAll({
      element.id : element.inFavorites,
    });
  });
  emit(ShopSuccessHomeDataState());

}).catchError((error){
  print(error.toString());

  emit(ShopErrorHomeDataState());
});
}

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEOGRIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCateogriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCateogriesState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
           url: FAVORITES,
           data: {
             'product_id': productId,
           },
        token : token,
    ).then((value) {
         changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
         if(!changeFavoritesModel!.status)
         {
           favorites[productId] = !favorites[productId]!;
         }
         else
           {
             getFavorites();
           }

         emit(ShopSuccessChangeFavoriteState(changeFavoritesModel!));
       }).catchError((error){
      favorites[productId] = !favorites[productId]!;
           emit(ShopErrorChangeFavoriteState());
       });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data :
      {
        'name' : name,
        'phone' : phone,
        'email' : email,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}

