import 'package:shopapp/models/login_model.dart';

abstract class RegisterStates{}

class ShopRegisterInitialState extends RegisterStates{}

class ShopRegisterLoadingState extends RegisterStates{}

class ShopRegisterSuccsessState extends RegisterStates{
  final LoginModel loginModel;

  ShopRegisterSuccsessState(this.loginModel);

}

class ShopRegisterErrorState extends RegisterStates{
  final String error;

  ShopRegisterErrorState(this.error);

}


class ShopChangeRegisterPasswordState extends RegisterStates{}







