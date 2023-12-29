import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../componants/deafult_components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: ( context,  state) {  },
      builder: ( context,  state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoriteState,
          builder:(context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!, context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },

    ) ;
  }
}

