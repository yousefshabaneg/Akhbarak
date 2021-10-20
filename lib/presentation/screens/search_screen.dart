import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchedArticles = cubit.searchedArticles;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    onChanged: (keyWord) {
                      NewsCubit.get(context).getSearchedArticles(keyWord);
                    },
                    onPressed: () {},
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.search,
                    color: cubit.isDark ? Colors.white : Colors.black,
                    textColor: cubit.isDark ? Colors.white : Colors.black,
                    hint: 'Find news around the world',
                    borderRadius: 20,
                  ),
                ),
                buildNewsWithConditionalBuilder(
                    articles: searchedArticles, isSearch: true),
              ],
            ),
          ),
        );
      },
    );
  }
}
