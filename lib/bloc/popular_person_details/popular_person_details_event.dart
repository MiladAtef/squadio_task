part of 'popular_person_details_bloc.dart';

abstract class PopularPersonDetailsEvent extends Equatable {
  const PopularPersonDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadPopularPersonDetails extends PopularPersonDetailsEvent {
  final String id;
  const LoadPopularPersonDetails({
    required this.id,
  });
}
