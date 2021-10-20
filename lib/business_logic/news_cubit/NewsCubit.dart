import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/data/cashe_helper.dart';
import 'package:news_app/data/models/articles.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/presentation/screens/technology_screen.dart';
import 'package:news_app/presentation/screens/health_screen.dart';
import 'package:news_app/presentation/screens/sports_screen.dart';
import 'package:news_app/shared/constants/strings.dart';

class NewsCubit extends Cubit<NewsStates> {
  List<Article> technologyArticles = [];
  List<Article> sportsArticles = [];
  List<Article> healthArticles = [];

  NewsCubit() : super(NewsInitialState());

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      //dark mode true !!
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.setBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void getTechnologyArticles() {
    emit(NewsTechnologyLoadingState());
    NewsRepository.getAllArticles(category: 'technology').then((articles) {
      setImageIfNull(articles);
      technologyArticles = articles;
      emit(NewsTechnologyLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsTechnologyErrorState(error.toString()));
    });
  }

  void getSportsArticles() {
    emit(NewsSportsLoadingState());
    NewsRepository.getAllArticles(category: 'sports').then((articles) {
      setImageIfNull(articles);
      sportsArticles = articles;
      emit(NewsSportsLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState(error.toString()));
    });
  }

  void getHealthArticles() {
    emit(NewsHealthLoadingState());
    NewsRepository.getAllArticles(category: 'health').then((articles) {
      setImageIfNull(articles);
      healthArticles = articles;
      emit(NewsHealthLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsHealthErrorState(error.toString()));
    });
  }

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    TechnologyScreen(),
    SportsScreen(),
    HealthScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.computer,
      ),
      label: 'Technology',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_rounded,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.health_and_safety,
      ),
      label: 'Health',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  void setImageIfNull(List<Article> articles) {
    articles.forEach((article) {
      if (article.urlToImage == null) {
        article.urlToImage = noImage;
      }
    });
  }
}
