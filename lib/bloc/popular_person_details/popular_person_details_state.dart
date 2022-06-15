part of 'popular_person_details_bloc.dart';

abstract class PopularPersonDetailsState extends Equatable {
  const PopularPersonDetailsState();

  @override
  List<Object> get props => [];
}

class PopularPersonDetailsInitial extends PopularPersonDetailsState {}

class PopularPersonDetailsLoaded extends PopularPersonDetailsState {
  final PopularPersonInfo info;
  final SocialMediaInfo socialInfo;
  final List<ImageBackdrop> images;
  const PopularPersonDetailsLoaded({
    required this.info,
    required this.socialInfo,
    required this.images,
  });
}

class PopularPersonDetailsLoading extends PopularPersonDetailsState {}

class PopularPersonDetailsError extends PopularPersonDetailsState {
  final FetchDataError error;
  const PopularPersonDetailsError({
    required this.error,
  });
}
