class FixtureModel {
  String? patientName;
  String? printDate;
  String? receiveDate;
  String? labName;
  String? drName;

  int? price;
  FixtureModel({
    required this.patientName,
    required this.printDate,
    required this.receiveDate,
    required this.labName,
    required this.drName,
    required this.price,
  });

  FixtureModel.fromJson(Map<String, dynamic>? json) {
    patientName = json!['patientName'];
    printDate = json['printDate'];
    receiveDate = json['receiveDate'];
    labName = json['labName'];
    drName = json['drName'];
    price = json['price'];
  }
}
