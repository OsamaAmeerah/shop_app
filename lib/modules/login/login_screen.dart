import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/shared/network/local/cahce_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
   var formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccsessState)
            {
              if(state.loginModel.status) {
                print(state.loginModel.data?.token);
                print(state.loginModel.message);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                  token = state.loginModel.data?.token;
                  navigateAndFinish(context, const ShopLayout());
                });
              }
               else
                 {
                   print(state.loginModel.message);
                   showToast(text: state.loginModel.message!, state: ToastStates.ERROR);
                 }
            }
        },
        builder: (context, state)
        {
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height:30.0,
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
                        suffix: LoginCubit.get(context).suffix,

                        onSubmit: (value){
                          if(formKey.currentState!.validate())
                          {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: (){
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      ConditionalBuilder(
                       condition: state is! ShopLoginLoadingState ,
                        builder: (context) =>  defaultButton(
                          todofunction: (){
                            if(formKey.currentState!.validate())
                              {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                          },
                          text: 'login',isUpperCase: true,
                        ),
                        fallback:(context)=> const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account ? ',),
                          TextButton(onPressed: (){
                            navigateTo(context,
                               RegisterScreen(),
                            );

                          }, child: const Text(
                              'Register Now ! '
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

        );
        },
      ),
    );
  }
}
