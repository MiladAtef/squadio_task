import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadio/models/popular_person_model.dart';

import '../../../../data/fetch_popular_people_data.dart';

part 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  PopularPeopleCubit() : super(PopularPeopleState.initial());
  final repo = PopularPeopleRepo();

  void init() async {
    try {
      emit(state.copyWith(popularPeopleStatus: PopularPeopleStatus.loading));
      final popularPeople = await repo.getPopularPeople(state.popularPeoplePage);
      emit(
        state.copyWith(
          popularPeopleStatus: PopularPeopleStatus.loaded,
          popularPeople: popularPeople[0],
          popularPeoplePage: state.popularPeoplePage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(popularPeopleStatus: PopularPeopleStatus.error));
    }
  }

  void loadNextPopularPeoplePage() async {
    if (!state.popularFull) {
      emit(state.copyWith(popularPeopleStatus: PopularPeopleStatus.adding));
      final popularPeople = await repo.getPopularPeople(state.popularPeoplePage);

      state.popularPeople.addAll(popularPeople[0]);
      emit(
        state.copyWith(
          popularPeople: state.popularPeople,
          popularPeoplePage: state.popularPeoplePage + 1,
          popularFull: popularPeople[1] == state.popularPeoplePage,
        ),
      );
    } else {
      emit(state.copyWith(popularPeopleStatus: PopularPeopleStatus.allFetched));
    }
  }
}
