import 'package:news_app/data/models/articles.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class AppChangeModeState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsTechnologyLoadingState extends NewsStates {}

class NewsTechnologyLoadedState extends NewsStates {}

class NewsTechnologyErrorState extends NewsStates {
  final String error;

  NewsTechnologyErrorState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsSportsLoadedState extends NewsStates {}

class NewsSportsErrorState extends NewsStates {
  final String error;

  NewsSportsErrorState(this.error);
}

class NewsHealthLoadingState extends NewsStates {}

class NewsHealthLoadedState extends NewsStates {}

class NewsHealthErrorState extends NewsStates {
  final String error;

  NewsHealthErrorState(this.error);
}
