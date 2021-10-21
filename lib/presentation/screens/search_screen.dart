import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/constants/my_colors.dart';

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
            centerTitle: true,
            title: Text(
              'Akhbarak - أخبارك',
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color:
                    cubit.isDark ? MyColors.primaryColor : MyColors.secondary,
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
                      cubit.getSearchedArticles(keyWord);
                    },
                    onPressed: () {},
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.search,
                    color: MyColors.primary,
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
