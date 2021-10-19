import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/NewsCubit.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var businessArticles = NewsCubit.get(context).businessArticles;
        return buildNewsWithConditionalBuilder(
          articles: businessArticles,
        );
      },
    );
  }
}
