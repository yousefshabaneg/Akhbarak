import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
}
