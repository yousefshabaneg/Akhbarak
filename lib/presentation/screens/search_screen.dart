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
        var searchedArticles =
            cubit.searchedArticles.length == 0 && searchController.text.isEmpty
                ? cubit.generalArticles
                : cubit.searchedArticles;
        var isRtl = cubit.isRtl;
        var isDark = cubit.isDark;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: cubit.isDark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                cubit.searchedArticles = cubit.generalArticles.toList();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    isRtl: isRtl,
                    onChanged: (keyWord) {
                      NewsCubit.get(context).getSearchedArticles(keyWord);
                    },
                    onPressed: () {},
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.search,
                    color: Colors.deepOrange,
                    textColor: isDark ? Colors.white : Colors.black,
                    hint: isRtl
                        ? '... ابحث عن المحتوي عبر العالم'
                        : 'Find news around the world .. ',
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
