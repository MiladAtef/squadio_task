import 'package:hive/hive.dart';

part 'popular_person_model.g.dart';

@HiveType(typeId: 1)
class PopularPersonModel {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String knownForDepartment;
  @HiveField(4)
  final String gender;
  @HiveField(5)
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
