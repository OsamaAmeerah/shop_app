import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
var formKey = GlobalKey<FormState>();
var searchController = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: ( context,  state)
        {

        },
        builder: ( context,  state)
        {
          return Scaffold(
          appBar: AppBar(),
          // ignore: prefer_const_constructors
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                   defaultFormField(
                       controller: searchController,
                       type: TextInputType.text,
                       label: 'search',
                       prefix: Icons.search,
                       validate: (String? value){
                         if(value!.isEmpty)
                           {
                             return 'Enter Text To Search';
                           }
                         return null;
                       },
                     onSubmit: (String text)
                       {
                         SearchCubit.get(context).search(text);
                       },
                   ),
                  const SizedBox(height: 10,),
                  if(state is SearchLoadingStates)
                  const LinearProgressIndicator(),
                  if(state is SearchSuccessStates)
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                        separatorBuilder: (context,index)=>myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length),
                  ),
                ],
              ),
            ),
          ),
        );
          },
      ),
    );
  }
}
