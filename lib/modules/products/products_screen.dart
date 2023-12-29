import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/style/colors.dart';

import '../../models/cateogries_model.dart';
import '../../models/home_model.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context,state){
       if (state is ShopSuccessChangeFavoriteState)
         {
            if(state.model.status == false){
              showToast(
                  text: state.model.message,
                  state: ToastStates.ERROR);
            }
            else
              {

                  showToast(
                      text: state.model.message,
                      state: ToastStates.SUCCESS);
              }

         }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder:(context)=> productsWidget(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel! , context) ,
            fallback:(context)=> const Center(child: CircularProgressIndicator()),

        );
      },
    );
  }


  // ignore: prefer_const_constructors
  Widget productsWidget(HomeModel model , CategoriesModel cateogriesModel , context) =>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(items: model.data?.banners.map((e) => Image(
          image: NetworkImage(e.image),
          width: double.infinity,
          fit: BoxFit.cover,
        )).toList(),//رح يعمل ريتيرن ليستا اوف الاشي الي بعد الميثود تاعت الماب الي هي هون الايميج
            options: CarouselOptions(
             height: 200,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,// شكل الاينيميشن (بجنن)
              scrollDirection: Axis.horizontal,
        )
        ),
        const SizedBox(
          height: 10.0,
        ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text(
                 'Categorises',
                 style: TextStyle(
                   fontSize: 24.0,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               const SizedBox(
                 height: 10.0,
               ),

               Container(
                 height: 100.0,

                 child: ListView.separated(
                   physics: const BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                     itemBuilder: ((context, index) => buildCateogriesItem(cateogriesModel.data!.data[index])),

                     separatorBuilder: (context, index) => const SizedBox(
                       width: 10.0,
                     ),

                     itemCount: cateogriesModel.data!.data.length),
               ),
               const SizedBox(
                 height: 10.0,
               ),

               const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
        ),
             ],
           ),
         ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0, // ببعد الايتم عن بعض
            crossAxisSpacing: 1.0,// ببعد الايتم عن بعض
            childAspectRatio: 1/1.7,//بتحكم بالطول
            crossAxisCount: 2,
          children: List.generate(
            model.data!.products.length,
                (index) => buildGridProduct(model.data!.products[index] , context),
          ),

          ),
        ),
      ],
    ),
  );
Widget buildGridProduct(ProductModel model , context) {


  return Container(

  color: Colors.white,
  child:Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
       children: [
         Image(image: NetworkImage(
             model.image),
           width: double.infinity,
           height: 200.0,
         ),
         if(model.discount != 0)
         Container(
           color: Colors.red,
           padding: const EdgeInsets.symmetric(horizontal: 5.0,),
           child: const Text('Discount',
           style: TextStyle(
             fontSize: 8.0,
             color: Colors.white,
           ),
           ),
         ),

       ],
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name,
             overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),

             Row(
              children: [
                Text('${model.price.round()}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: defaultColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if(model.discount !=0 )
                Text('${model.oldPrice.round()}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                  icon:  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: const Icon(Icons.favorite_border,
                      color: Colors.white,
                    size: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);
}
}

Widget buildCateogriesItem(DataModel? model)=>Container(

  width: 100.0,
  height: 100.0,
  child: Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage(model!.image),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: double.infinity,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(

            color: Colors.white,
          ),
        ),
      ),
    ],
  ),

);
