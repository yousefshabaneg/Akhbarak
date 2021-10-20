import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/articles.dart';
import 'package:news_app/presentation/screens/web_view.dart';

Widget buildArticleItem(Article article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: article.url));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      article.urlToImage!,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        article.title,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      article.publishedAt,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget dividerSeparator() => Divider(
      thickness: 0.8,
      color: Colors.grey[200],
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
  Color color = Colors.black,
  Color textColor = Colors.white,
}) =>
    TextFormField(
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
