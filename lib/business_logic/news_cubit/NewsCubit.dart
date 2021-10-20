import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/data/cashe_helper.dart';
import 'package:news_app/data/models/articles.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/presentation/screens/general_screen.dart';
import 'package:news_app/presentation/screens/technology_screen.dart';
import 'package:news_app/presentation/screens/health_screen.dart';
import 'package:news_app/presentation/screens/sports_screen.dart';
import 'package:news_app/shared/constants/strings.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<Article> technologyArticles = [];
  List<Article> sportsArticles = [];
  List<Article> healthArticles = [];
  List<Article> generalArticles = [];
  List<Article> searchedArticles = [];

  String? keyWord;

  int currentIndex = 0;

  bool isDark = false;

  bool isRtl = true;

  List<Widget> screens = [
    GeneralScreen(),
    TechnologyScreen(),
    SportsScreen(),
    HealthScreen(),
  ];
  List<BottomNavigationBarItem> bottomItemsArabic = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.feed_outlined,
      ),
      label: 'عاجل',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.computer,
      ),
      label: 'التكنولوجيا',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_rounded,
      ),
      label: 'الرياضة',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.health_and_safety,
      ),
      label: 'الصحة',
    ),
  ];

  List<BottomNavigationBarItem> bottomItemsEnglish = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.feed_outlined,
      ),
      label: 'Breaking',
    ),
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

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.setBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeAppDirection({bool? fromShared}) {
    if (fromShared != null) {
      isRtl = fromShared;
      emit(AppChangeDirectionState());
    } else {
      isRtl = !isRtl;
      CashHelper.setBoolRtl(key: 'isRtl', value: isRtl).then((value) {
        emit(AppChangeDirectionState());
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

  void getGeneralArticles() {
    emit(NewsGeneralLoadingState());
    NewsRepository.getAllArticles(category: 'general').then((articles) {
      setImageIfNull(articles);
      generalArticles = articles;
      emit(NewsGeneralLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGeneralErrorState(error.toString()));
    });
  }

  void getSearchedArticles(String? keyWord) {
    emit(NewsSearchedLoadingState());
    NewsRepository.getSearchedArticles(keyWord!).then((articles) {
      this.keyWord = keyWord;
      setImageIfNull(articles);
      searchedArticles = articles;
      emit(NewsSearchedLoadedState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchedErrorState(error.toString()));
    });
  }

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
