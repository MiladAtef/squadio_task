part of 'popular_people_cubit.dart';

enum PopularPeopleStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allFetched,
}

class PopularPeopleState {
  final int popularPeoplePage;
  final bool popularFull;
  final PopularPeopleStatus popularPeopleStatus;
  final List<PopularPersonModel> popularPeople;

  PopularPeopleState({
    required this.popularPeoplePage,
    required this.popularFull,
    required this.popularPeopleStatus,
    required this.popularPeople,
  });
  factory PopularPeopleState.initial() => PopularPeopleState(
        popularPeoplePage: 1,
        popularPeopleStatus: PopularPeopleStatus.initial,
        popularFull: false,
        popularPeople: [],
      );

  PopularPeopleState copyWith({
    int? popularPeoplePage,
    bool? popularFull,
    PopularPeopleStatus? popularPeopleStatus,
    List<PopularPersonModel>? popularPeople,
  }) {
    return PopularPeopleState(
      popularPeoplePage: popularPeoplePage ?? this.popularPeoplePage,
      popularFull: popularFull ?? this.popularFull,
      popularPeopleStatus: popularPeopleStatus ?? this.popularPeopleStatus,
      popularPeople: popularPeople ?? this.popularPeople,
    );
  }
}
