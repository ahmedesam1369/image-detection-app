import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:elsawy/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/HomeLayout/cubit/cubit.dart';
import '../../shared/component/component.dart';
import '../../shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: Center(child: Text('Home Screen')),
            floatingActionButton: FloatingActionButton(
                child: Icon(IconBroken.Image),
                onPressed: () {
                  LayoutCubit.get(context).pick_image();
                }),
          );
        });
  }
}
