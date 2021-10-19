import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/NewsCubit.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';
import 'package:news_app/shared/components/components.dart';

class SciencesScreen extends StatelessWidget {
  const SciencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var scienceArticles = NewsCubit.get(context).scienceArticles;
        return buildNewsWithConditionalBuilder(
          articles: scienceArticles,
        );
      },
    );
  }
}
