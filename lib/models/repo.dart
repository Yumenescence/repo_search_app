import 'unique.dart';

class RepoModel extends Unique {
  final String name;

  RepoModel(super.id, {required this.name});

  RepoModel.fromJson(Map<String, dynamic> json)
      : name = json['full_name'],
        super(json['id']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
