import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/NewsCubit.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var sportsArticles = NewsCubit.get(context).sportsArticles;
        return buildNewsWithConditionalBuilder(
          articles: sportsArticles,
        );
      },
    );
  }
}
