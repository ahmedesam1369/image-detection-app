import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:elsawy/modules/onBoarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/HomeLayout/cubit/cubit.dart';
import '../../shared/component/component.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: defulteButton(
                      text: 'Sign Out',
                      isUpperCase: false,
                      width: 200.0,
                      function: () async {
                        await FirebaseAuth.instance.signOut();
                        NavidetAndFinish(context, OnBoardingScreen());
                        CachHelper.removeData(key: 'uId');
                        LayoutCubit.get(context).currentIndex = 0;
                      }),
                ),
              ],
            ),
          );
        });
  }
}
