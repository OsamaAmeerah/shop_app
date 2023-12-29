import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding.dart';
import 'package:shopapp/shared/cubit/appcubit.dart';
import 'package:shopapp/shared/cubit/appstates.dart';
import 'package:shopapp/shared/network/local/cahce_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/style/bloc_observer.dart';
import 'package:shopapp/style/themes.dart';
import 'componants/deafult_components.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
// ignore: unnecessary_null_comparison
if(onBoarding != null)
  {
    // ignore: unnecessary_null_comparison
    if(token != null)
      {
        widget = const ShopLayout();
      }
    else
      {
        widget = LoginScreen();
      }
  }
else
  {
    widget = const OnBoardingScreen();
  }
  runApp( MyApp(
    startWidget: widget,
  ));
  Bloc.observer = MyBlocObserver();
}
class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(context) {
return  MultiBlocProvider(
  providers:  [
    BlocProvider(
      create: (context) => AppCubit()
    ),
    BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
    ),
  ],
  child: BlocConsumer<AppCubit , AppStates>(
    builder: ( context, state) {
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

        home: startWidget,

      );
    }, listener: (context,state) {

  },
  ),
);
  }
}

