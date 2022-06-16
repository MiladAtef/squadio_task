import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:squadio/models/popular_person_model.dart';

import '../../constants.dart';
import '../../bloc/popular_people/popular_people_cubit.dart';
import '../../widgets/error_page.dart';
import '../../widgets/no_results_found.dart';
import '../../widgets/popular_person_card.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController popularPeopleController = ScrollController();
  final Connectivity _connectivity = Connectivity();

  late Box<PopularPersonModel> popularPeopleBox;

  @override
  void initState() {
    super.initState();
    popularPeopleBox = Hive.box('people');
    popularPeopleController.addListener(popularPeopleScrollListener);
  }

  void popularPeopleScrollListener() {
    if (popularPeopleController.offset >= popularPeopleController.position.maxScrollExtent && !popularPeopleController.position.outOfRange) {
      BlocProvider.of<PopularPeopleCubit>(context).loadNextPopularPeoplePage();
    }
  }

  @override
  void dispose() {
    popularPeopleController.dispose();
    super.dispose();
  }

  Future<bool> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Popular People",
          style: heading.copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: _checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!) {
              return ValueListenableBuilder(
                valueListenable: popularPeopleBox.listenable(),
                builder: (context, Box<PopularPersonModel> box, _) {
                  return ListView(
                    children: [
                      if (box.isEmpty) const NoResultsFound(),
                      ...box.values.map(
                        (person) => PopularPersonCard(
                          id: person.id,
                          name: person.name,
                          image: person.image,
                          knownForDepartment: person.knownForDepartment,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return BlocBuilder<PopularPeopleCubit, PopularPeopleState>(
              builder: (context, state) {
                return state.popularPeopleStatus != PopularPeopleStatus.loading
                    ? ListView(
                        controller: popularPeopleController,
                        children: [
                          if (state.popularPeople.isEmpty) const NoResultsFound(),
                          ...state.popularPeople.map(
                            (person) => PopularPersonCard(
                              id: person.id,
                              name: person.name,
                              image: person.image,
                              knownForDepartment: person.knownForDepartment,
                            ),
                          ),
                          if (state.popularPeopleStatus == PopularPeopleStatus.adding)
                            Center(
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey.shade700,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                        ],
                      )
                    : state.popularPeopleStatus == PopularPeopleStatus.loading
                        ? Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.grey.shade700,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : const Center(
                            child: ErrorPage(),
                          );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade700,
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
