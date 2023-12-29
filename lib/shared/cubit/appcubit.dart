import 'package:flutter_bloc/flutter_bloc.dart';
import 'appstates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode({ bool? fromShared})
  {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}