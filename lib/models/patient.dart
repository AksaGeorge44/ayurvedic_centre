class Patient {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String payment;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String dateTime;
  final String user;
  final bool isActive;
  final List<PatientDetail> patientDetails;
  final Branch branch;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.payment,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateTime,
    required this.user,
    required this.isActive,
    required this.patientDetails,
    required this.branch,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      payment: json['payment'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      advanceAmount: (json['advance_amount'] ?? 0).toDouble(),
      balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
      dateTime: json['date_nd_time'] ?? '',
      user: json['user'] ?? '',
      isActive: json['is_active'] ?? false,
      patientDetails: (json['patientdetails_set'] as List)
          .map((item) => PatientDetail.fromJson(item))
          .toList(),
      branch: Branch.fromJson(json['branch'] ?? {}),
    );
  }
}

class PatientDetail {
  final int id;
  final String male;
  final String female;
  final int? treatment;
  final String treatmentName;

  PatientDetail({
    required this.id,
    required this.male,
    required this.female,
    this.treatment,
    required this.treatmentName,
  });

  factory PatientDetail.fromJson(Map<String, dynamic> json) {
    return PatientDetail(
      id: json['id'],
      male: json['male'] ?? '',
      female: json['female'] ?? '',
      treatment: json['treatment'],
      treatmentName: json['treatment_name'] ?? '',
    );
  }
}

class Branch {
  final int id;
  final String name;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}
