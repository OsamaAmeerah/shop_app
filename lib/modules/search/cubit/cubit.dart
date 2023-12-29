import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import '../../../shared/network/end_point.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitailStates());
 static SearchCubit get(context) => BlocProvider.of(context);

 SearchModel? model;

 void search(String text)
 {
   emit(SearchLoadingStates());
   DioHelper.postData(
     url: SEARCH,
       token: token,
       data:
       {
           'text':text,
       },
   ).then((value) {
     model = SearchModel.fromJson(value.data);
       emit(SearchSuccessStates());
   }).catchError((error){
         // ignore: avoid_print
         print(error.toString());
     emit(SearchErrorStates());
   });

 }
}