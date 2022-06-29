abstract class LayoutStates {}

class InitialState extends LayoutStates {}

class ChangeBottomNavState extends LayoutStates {}

class PickImageLoadingState extends LayoutStates {}

class PickImageSuccessState extends LayoutStates {}

class Chanegdropdowngender extends LayoutStates {}

class Chanegdropdownstatus extends LayoutStates {}

class AddPatientLoadingState extends LayoutStates {}

class AddPatientSuccessState extends LayoutStates {}

class AddPatientErrorState extends LayoutStates {
  final String error;

  AddPatientErrorState(this.error);
}

class FetchDataLoadingState extends LayoutStates {}

class FetchDataSuccessfulState extends LayoutStates {}

class FetchDataErrorState extends LayoutStates {
  final String error;
  FetchDataErrorState(this.error);
}

class PatientDeleteUserLoadingState extends LayoutStates {}

class PatientDeleteUserSuccessfulState extends LayoutStates {}

class PatientDeleteUserErrorState extends LayoutStates {
  final String error;
  PatientDeleteUserErrorState(this.error);
}
