import 'package:shopapp/models/login_model.dart';

abstract class LoginStates{}

class ShopLoginInitialState extends LoginStates{}

class ShopLoginLoadingState extends LoginStates{}

class ShopLoginSuccsessState extends LoginStates{
  final LoginModel loginModel;

  ShopLoginSuccsessState(this.loginModel);
}

class ShopLoginErrorState extends LoginStates{
  final String error;

  ShopLoginErrorState(this.error);

}

class ShopChangePasswordState extends LoginStates{}
