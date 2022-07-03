import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:elsawy/layout/HomeLayout/cubit/cubit.dart';
import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:elsawy/models/patient_model.dart';
import 'package:elsawy/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/component.dart';

class AddPatient extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var age = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var medicalHistory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is AddPatientSuccessState) {
          showToast(
              msg: 'Patient Added Successfully', state: toastStates.SUCCESS);
          cubit.getAllPatients();
          Navigator.pop(context);
        }
        if (state is AddPatientErrorState) {
          showToast(
              msg: 'Patient Not Added \n Try Agin', state: toastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Patient Information')),
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter patient name';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          IconBroken.User,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: age,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter patient age';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Age',
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          IconBroken.Calendar,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 10.0,
                            ),
                            child: Icon(IconBroken.Category),
                          ),
                          Expanded(
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              value: cubit.dropdownvaluegender,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: cubit.itemsgender.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                cubit.chanegdropdowngender(newValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter patient phone';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          IconBroken.Call,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: address,
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter patient Address';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Address',
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          IconBroken.Location,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: medicalHistory,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter patient Medical History';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Medical History',
                        labelText: 'Medical History',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          IconBroken.Info_Square,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                            ),
                            child: Icon(IconBroken.Activity),
                          ),
                          Expanded(
                            child: Text(
                              'Diagnosis',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              value: cubit.dropdownvaluestatus,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: cubit.itemsstatus.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                cubit.chanegdropdownstatus(newValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    //
                    ConditionalBuilder(
                      condition: state is! AddPatientLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.only(
                          left: 100.0,
                          right: 100.0,
                        ),
                        child: defulteButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.patientAdd(
                                address: address.text,
                                age: age.text,
                                gender: cubit.dropdownvaluegender,
                                medicalHistory: medicalHistory.text,
                                name: name.text,
                                phone: phone.text,
                                status: cubit.dropdownvaluestatus,
                              );
                            }
                          },
                          text: 'Save',
                          isUpperCase: true,
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
