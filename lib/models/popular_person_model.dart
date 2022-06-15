class PopularPersonModel {
  final String image;
  final String name;
  final String id;
  final String knownForDepartment;
  final String gender;

  PopularPersonModel({
    required this.image,
    required this.name,
    required this.id,
    required this.knownForDepartment,
    required this.gender,
  });
  factory PopularPersonModel.fromJson(json) {
    return PopularPersonModel(
      id: json['id'].toString(),
      image: json['profile_path'] != null ? "https://image.tmdb.org/t/p/original${json['profile_path']}" : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      name: json['name'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      gender: json['gender'] == 2 ? 'Male' : 'Female',
    );
  }
}
