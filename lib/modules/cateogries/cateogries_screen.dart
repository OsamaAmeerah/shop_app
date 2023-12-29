import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/models/cateogries_model.dart';

import '../../layout/cubit/states.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: ( context,  state) {  },
      builder: ( context,  state)
      {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
      },

    ) ;
  }

  Widget buildCatItem(DataModel model) =>Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(model.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward)
      ],
    ),
  );
}
