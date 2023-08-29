class RepoModel {
  final String name;

  RepoModel({required this.name});

  RepoModel.fromJson(Map<String, dynamic> json) : name = json['full_name'];

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
