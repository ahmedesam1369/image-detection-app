import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/Screens/home_screen.dart';
import '../../../modules/Screens/info_screen.dart';
import '../../../modules/Screens/setting_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    InfoScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'Home ',
    'Info',
    'Settings',
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  void pick_image() async {
    emit(PickImageLoadingState());
    image = await _picker.pickImage(source: ImageSource.gallery);
    print(image);
    emit(PickImageSuccessState());
  }
}
