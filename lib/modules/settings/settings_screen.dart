import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
   var formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessUserDataState)
          {
            print(state.loginModel.data!.name);
            print(state.loginModel.data!.email);
            print(state.loginModel.data!.phone);
            emailController.text = state.loginModel.data!.name;
            nameController.text = state.loginModel.data!.email;
            phoneController.text = state.loginModel.data!.phone;
          }
      }
      ,
      builder:(context,state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  if(state is ShopLoadingUpdateUserState)
                  const LinearProgressIndicator(),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'UserName',
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Name must not be empty';
                      }
                    },
                    prefix: Icons.person,

                  ),
                  const SizedBox(height: 10.0,),

                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'EmailAddress',
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Email must not be empty';
                      }
                    },
                    prefix: Icons.email,

                  ),
                  const SizedBox(height: 10.0,),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Phone must not be empty';
                      }
                    },
                    prefix: Icons.phone_enabled,

                  ),
                  const SizedBox(height: 20,),
                  defaultButton(todofunction: (){
                    if(formKey.currentState!.validate()) {
                      ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text);
                    }
                  }, text: 'Update'),
                  const SizedBox(height: 20,),
                  defaultButton(todofunction: (){
                    signOut(context);
                  }, text: 'Logout'),
                ],
              ),
            ),
          ) ,
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
