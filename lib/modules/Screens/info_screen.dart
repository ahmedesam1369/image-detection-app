import 'package:conditional_builder/conditional_builder.dart';
import 'package:elsawy/layout/HomeLayout/cubit/states.dart';
import 'package:elsawy/modules/Screens/add_patient.dart';
import 'package:elsawy/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/HomeLayout/cubit/cubit.dart';
import '../../shared/component/component.dart';
import '../../shared/network/local/cache_helper.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
                condition: state is FetchDataLoadingState,
                builder: (context) => CircularProgressIndicator(),
                fallback: (context) {
                  return UsersBiulder();
                }),
            floatingActionButton: FloatingActionButton(
                child: Icon(IconBroken.Add_User),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => AddPatient()),
                      ));
                }),
          );
        });
  }
}

Widget buildUserItem(context, index) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onLongPress: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red[400],
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Delete User',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  content: const Text('Are u sure u wanna delete this patient'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        print(
                            LayoutCubit.get(context).PatientList[index]['uId']);
                        LayoutCubit.get(context).deleteUser(
                            LayoutCubit.get(context).PatientList[index],
                            LayoutCubit.get(context)
                                .PatientList[index]['uId']
                                .toString(),
                            context);

                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Name:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['name']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Age:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['age']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Phone:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['phone']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Address:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['address']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Medical History:  ',
                            ),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['medicalHistory']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Status:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['status']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Gender:  '),
                            Expanded(
                              child: Text(
                                '${LayoutCubit.get(context).PatientList[index]['gender']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

Widget UsersBiulder() {
  return ConditionalBuilder(
    condition: true,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildUserItem(context, index),
      separatorBuilder: (context, index) => MyDivider(),
      itemCount: LayoutCubit.get(context).PatientList.length,
    ),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
          ),
          Text(
            'No Patient Yet, Please Enter patient info',
          ),
        ],
      ),
    ),
  );
}
