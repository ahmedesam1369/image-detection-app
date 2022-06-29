class PatienModel {
  late String name;
  late String age;
  late String phone;
  late String address;
  late String medicalHistory;
  late String gender;
  late String status;
  late String uId;

  PatienModel({
    this.address = '',
    this.age = '',
    this.gender = '',
    this.medicalHistory = '',
    this.name = '',
    this.phone = '',
    this.status = '',
    this.uId = '',
  });

  PatienModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    phone = json['phone'];
    status = json['status'];
    age = json['age'];
    address = json['address'];
    gender = json['gender'];
    medicalHistory = json['medicalHistory'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'status': status,
      'age': age,
      'gender': gender,
      'address': address,
      'medicalHistory': medicalHistory,
      'uId': uId,
    };
  }
}
