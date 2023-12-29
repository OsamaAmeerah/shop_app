import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context,state) {  },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sonatshi',
            ),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());

              }, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                label: 'Home',

                ),
              BottomNavigationBarItem(icon: Icon(Icons.category,),
                label: 'Categories',

              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite,),
                label: 'Favorites',

              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),
                label: 'Settings',

              ),
            ],
          ),

        );
      },
    );
  }
}
