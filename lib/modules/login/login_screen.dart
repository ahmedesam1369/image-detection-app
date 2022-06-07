import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/HomeLayout/home_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, State) {
        if (State is LoginErrorState) {
          showToast(
            msg: State.Error,
            state: toastStates.ERROR,
          );
        }
        if (State is LoginSuccessState) {
          CachHelper.saveData(
            key: 'uId',
            value: State.uId,
          ).then((value) {
            NavidetAndFinish(context, HomeLayout());
          });
        }
      }, builder: (context, State) {
        return Scaffold(
            body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      'Log in now to explore the world',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (Value) {
                        if (Value!.isEmpty) {
                          return 'please enter your email address';
                        }
                        return null;
                      },
                      lable: 'Email Adress',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        }
                        return null;
                      },
                      lable: 'Password',
                      suffix: LoginCubit.get(context).suffix,
                      onPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                      prefix: Icons.lock_outline_rounded,
                      obsCuretext: LoginCubit.get(context).IsPassward,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).UserLogin(
                              email: emailController.text,
                              passWord: passwordController.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: State is! LoginLoadingState,
                      builder: (context) => defulteButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                passWord: passwordController.text);
                          }
                        },
                        text: 'LOGIN',
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                        ),
                        defultTextButton(
                            onPressed: () {
                              NavigetTo(context, RegisterScreen());
                            },
                            text: 'register'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}
