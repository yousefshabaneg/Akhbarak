import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';
import 'package:news_app/presentation/screens/business_screen.dart';
import 'package:news_app/presentation/screens/science_screen.dart';
import 'package:news_app/presentation/screens/settings_screen.dart';
import 'package:news_app/presentation/screens/sports_screen.dart';
import 'package:news_app/shared/constants/strings.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

//
class NewsCubit extends Cubit<NewsStates> {
  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];

  NewsCubit() : super(NewsInitialState());

  void getBusinessArticles() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'd1f438453a6946e393eb5b80bb3ecac5'
    }).then((value) {
      setImageIfNull(value);
      businessArticles = value;
      emit(NewsBusinessLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error));
    });
  }

  void getSportsArticles() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'd1f438453a6946e393eb5b80bb3ecac5'
    }).then((value) {
      setImageIfNull(value);
      sportsArticles = value;
      print('sports article: ${sportsArticles.length}');
      emit(NewsSportsLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState(error));
    });
  }

  void getScienceArticles() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'd1f438453a6946e393eb5b80bb3ecac5'
    }).then((value) {
      setImageIfNull(value);
      scienceArticles = value;
      emit(NewsScienceLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsScienceErrorState(error));
    });
  }

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
    if (index == 1) {
      getSportsArticles();
    } else if (index == 2) {
      getScienceArticles();
    }
  }

  void setImageIfNull(List<dynamic> value) {
    value.forEach((article) {
      if (article['urlToImage'] == null) {
        article['urlToImage'] = noImage;
      }
    });
  }
}
