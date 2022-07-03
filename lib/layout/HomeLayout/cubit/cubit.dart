import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/patient_model.dart';
import '../../../modules/Screens/home_screen.dart';
import '../../../modules/Screens/info_screen.dart';
import '../../../modules/Screens/setting_screen.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

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
    'Patients Info',
    'Settings',
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  bool loading = false;
  final ImagePicker _picker = ImagePicker();
  late File selectedImage;
  bool isImageSelected = false;
  //
  List<dynamic>? model_ouput;
  bool model_loading = false;
  String printOutput = 'None';
  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/images/model_unquant.tflite',
      labels: 'assets/images/labels.txt',
    );
  }

  void dispose() {
    Tflite.close();
  }

  pick_image() async {
    emit(PickImageLoadingState());

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    isImageSelected = true;
    selectedImage = File(image.path);
    model_loading = true;
    emit(PickImageSuccessState());
    //
    loadModel().then((value) {
      emit(ModelLoadingState());
      model_loading = false;
      try {
        classifyImage(selectedImage);
        emit(ModelSuccessState());
      } catch (E) {
        print('eRROR: ${E}');
        emit(ModelErrorState());
      }
    }).catchError((error) {
      print('Model Faild to load');
      print('Error: ${error}');
    });
  }

  classifyImage(File image) async {
    emit(MOdelStartClassification());
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    model_loading = false;
    // model_ouput = output;
    // print(model_ouput![0]['label']);
    // print(model_ouput![0]['index'].runtimeType);
    // print(model_ouput![0]['confidence']);
    if (output![0]['index'] == 0) {
      printOutput = 'No Tumor';
    } else if (output[0]['index'] == 1) {
      printOutput = 'Glioma Tumor';
    } else if (output[0]['index'] == 2) {
      printOutput = 'Pituitary Tumor';
    } else if (output[0]['index'] == 3) {
      printOutput = 'Meningioma Tumor';
    } else {
      printOutput = 'None';
    }
    emit(MOdelEndClassification());
  }

//
  String dropdownvaluegender = 'Male';
  var itemsgender = [
    'Male',
    'Female',
  ];

  void chanegdropdowngender(newValue) {
    dropdownvaluegender = newValue!;
    emit(Chanegdropdowngender());
  }

  String dropdownvaluestatus = 'No Tumor';
  var itemsstatus = [
    'No Tumor',
    'Glioma Tumor',
    'Pituitary Tumor',
    'Meningioma Tumor',
  ];
  void chanegdropdownstatus(newValue) {
    dropdownvaluestatus = newValue!;
    emit(Chanegdropdownstatus());
  }

//

  void patientAdd({
    required String name,
    required String age,
    required String phone,
    required String address,
    required String medicalHistory,
    required String gender,
    required String status,
  }) {
    PatienModel model = PatienModel(
      name: name,
      phone: phone,
      status: status,
      age: age,
      gender: gender,
      address: address,
      medicalHistory: medicalHistory,
    );
    emit(AddPatientLoadingState());
    FirebaseFirestore.instance
        .collection('patients')
        .add(model.toMap())
        .then((value) {
      model.uId = value.id.toString();
      FirebaseFirestore.instance
          .collection('patients')
          .doc("${model.uId}")
          .update({
        'uId': model.uId,
      });
      PatientList.add(model.toMap());
      emit(AddPatientSuccessState());
    }).catchError((Error) {
      emit(AddPatientErrorState(Error.toString()));
    });
  }

  late List<Map> PatientList = [];
  void getAllPatients() {
    emit(FetchDataLoadingState());
    FirebaseFirestore.instance.collection('patients').get().then((value) {
      PatientList = [];
      value.docs.forEach((element) {
        PatientList.add(element.data());
      });
      emit(FetchDataSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(FetchDataErrorState(error));
    });
  }

  void deleteUser(var value, String userId, BuildContext context) {
    emit(PatientDeleteUserLoadingState());
    FirebaseFirestore.instance
        .collection('patients')
        .doc(userId)
        .delete()
        .then((val) {
      PatientList.remove(value);
      emit(PatientDeleteUserSuccessfulState());
    }).catchError((onError) {
      print(onError);
      emit(PatientDeleteUserErrorState(onError));
    });
  }

  // *******************************

// ADD
  AddData(Map<String, dynamic> modelMap) async {
    emit(AddPatientLoadingState());
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("patients");
    userRef.add(modelMap).then((value) {
      emit(AddPatientSuccessState());
    }).catchError((e) {
      print(e);
      emit(AddPatientErrorState(e));
    });
    // userRef.doc('123456900').set({'name': "doc", 'agee': '50'});
  }

  // Update
  UpdateData() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("patients");
    // userRef.add({'name': "hhhh", 'agee': '20'});
    userRef.doc('123456900').update({'name': "update2", 'agee': '470'});
  }

// Get All Data in collection
  getAllDoc() async {
    try {
      emit(FetchDataLoadingState());
      CollectionReference userRef =
          FirebaseFirestore.instance.collection("patients");
      QuerySnapshot querySnapshot = await userRef.get();
      List<QueryDocumentSnapshot> queryDocumentSnapshotList =
          querySnapshot.docs;
      emit(FetchDataSuccessfulState());
      queryDocumentSnapshotList.forEach((element) {
        print("==================================");
        print(element.data());
      });
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(e);
    }
  }

  // Get one Doc from collection
  getoneDoc() async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection("patients")
        .doc("Sc9WXWvdUnMZJBo15Cdt");
    await doc.get().then((value) {
      print(value.data());
      print(value.id);
    });
  }

  // real time get data
  getDataRealTime() async {
    FirebaseFirestore.instance
        .collection('patients')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        print('name: ${element.data()['name']}');
      });
    });
  }
}
