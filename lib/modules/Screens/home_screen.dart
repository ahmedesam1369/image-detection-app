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
    var cubit = LayoutCubit.get(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      cubit.loading
                          ? Container(
                              height: 300,
                              width: 300,
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(),
                                  cubit.isImageSelected == false
                                      ? Container()
                                      : Image.file(cubit.selectedImage),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // cubit.imagee == null ? Container() : _outputs != null ?
                                  // Text(_outputs[0]["label"],style: TextStyle(color: Colors.black,fontSize: 20),
                                  // ) : Container(child: Text(""))
                                ],
                              ),
                            ),
                    ]),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(IconBroken.Image),
                onPressed: () {
                  LayoutCubit.get(context).pick_image();
                }),
          );
        });
  }
}
