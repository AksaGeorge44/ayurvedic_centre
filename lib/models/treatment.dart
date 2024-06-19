import 'branch.dart';

class Treatment {
  final int id;
  final List<Branch> branches;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Treatment({
    required this.id,
    required this.branches,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    var branchesFromJson = json['branches'] as List;
    List<Branch> branchesList = branchesFromJson.map((branch) => Branch.fromJson(branch)).toList();

    return Treatment(
      id: json['id'],
      branches: branchesList,
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
