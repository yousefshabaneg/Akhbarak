import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/data/models/articles.dart';
import 'package:news_app/presentation/screens/web_view.dart';
import 'package:news_app/shared/constants/my_colors.dart';

Widget buildArticleItem(Article article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: article.url));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: NewsCubit.get(context).isDark
                            ? Colors.white.withOpacity(0.7)
                            : MyColors.darkness,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          article.urlToImage!,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  article.publishedAt,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: MyColors.dark,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.bodyText1,
                      textDirection: TextDirection.rtl,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          NewsCubit.get(context).isRtl
                              ? 'إقرأ المزيد'
                              : 'Read More',
                          style: GoogleFonts.almarai(
                            textStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          navigateTo(context, WebViewScreen(url: article.url));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget dividerSeparator() => Divider(
      thickness: 0.3,
      color: MyColors.dark,
    );

Widget buildNewsWithConditionalBuilder(
        {required List articles, isSearch = false}) =>
    ConditionalBuilder(
      condition: articles.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            buildArticleItem(articles[index], context),
        separatorBuilder: (context, index) => dividerSeparator(),
        itemCount: articles.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

//<editor-fold desc='Default FormField'>
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  String? Function(String?)? validate,
  VoidCallback? onPressed,
  Function(String?)? onChanged,
  required IconData prefixIcon,
  double borderRadius = 0,
  String? hint,
  IconData? suffixIcon,
  bool isPassword = false,
  required bool isRtl,
  Color color = Colors.black,
  Color textColor = Colors.white,
}) =>
    TextFormField(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      textAlign: isRtl ? TextAlign.right : TextAlign.left,
      controller: controller,
      style: TextStyle(
        color: textColor,
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: new BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: color,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  suffixIcon,
                ),
              )
            : null,
      ),
      validator: validate,
      onChanged: onChanged,
      onTap: onPressed,
    );
//</editor-fold>

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget appBarText(context) => Text(
      NewsCubit.get(context).isRtl ? 'أخبارك - Akhbarak' : 'Akhbarak - أخبارك',
    );
