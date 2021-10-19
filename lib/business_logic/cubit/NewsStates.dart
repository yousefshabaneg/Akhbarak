abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

//<editor-fold desc='Business States'>

class NewsBusinessLoadingState extends NewsStates {}

class NewsBusinessLoadedState extends NewsStates {}

class NewsBusinessErrorState extends NewsStates {
  final String error;

  NewsBusinessErrorState(this.error);
}

//</editor-fold>

//<editor-fold desc='Sports States'>

class NewsSportsLoadingState extends NewsStates {}

class NewsSportsLoadedState extends NewsStates {}

class NewsSportsErrorState extends NewsStates {
  final String error;

  NewsSportsErrorState(this.error);
}

//</editor-fold>

//<editor-fold desc='Science States'>

class NewsScienceLoadingState extends NewsStates {}

class NewsScienceLoadedState extends NewsStates {}

class NewsScienceErrorState extends NewsStates {
  final String error;

  NewsScienceErrorState(this.error);
}

//</editor-fold>
