import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import '../../componants/deafult_components.dart';
import '../../layout/shop_layout.dart';
import '../../shared/network/local/cahce_helper.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(context) {
    return  BlocProvider(
      create: (context) => RegisterCubit() ,
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccsessState)
          {
            if(state.loginModel.status) {
              print(state.loginModel.data?.token);
              print(state.loginModel.message);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token = state.loginModel.data?.token;
                navigateAndFinish(context, const ShopLayout());
              });
            }
            else if(state is ShopRegisterErrorState)
            {
              print(state.loginModel.message);
              showToast(text: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
          appBar: AppBar(),
          body:  Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height:30.0,
                      ),
                      defaultFormField(controller: nameController,
                        type: TextInputType.name,
                        label: 'User Name',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultFormField(controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height:15.0,
                      ),

                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'password is too short';
                          }
                          return null;

                        },
                        prefix: Icons.lock,
                        suffix: RegisterCubit.get(context).suffix,

                        onSubmit: (value){

                        },
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: (){
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultFormField(controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone Number',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your phone number';
                          }
                          return null;
                        },
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height:20.0,
                      ),
                      ConditionalBuilder(
                        condition:state is! ShopRegisterLoadingState ,
                        builder: (context) =>  defaultButton(
                          todofunction: (){
                            if(formKey.currentState!.validate())
                            {
                              RegisterCubit.get(context).userRegister(
                                name : nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',isUpperCase: true,
                        ),
                        fallback:(context)=> const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        );  },
      ),
    );
  }
}
