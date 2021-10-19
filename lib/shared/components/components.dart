import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/business_logic/cubit/NewsStates.dart';

Widget buildArticleItem(article) => Padding(
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
                    article['urlToImage'],
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
                      article['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    buildDataAndTime(article['publishedAt']),
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
    );

Widget dividerSeparator() => Divider(
      thickness: 0.8,
      color: Colors.grey[200],
    );

String buildDataAndTime(String publishedAt) {
  var splitted = publishedAt.split('T');
  return '${splitted[0]} - ${splitted[1].substring(0, 5)}';
}

Widget buildNewsWithConditionalBuilder({required List articles}) =>
    ConditionalBuilder(
      condition: articles.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(articles[index]),
        separatorBuilder: (context, index) => dividerSeparator(),
        itemCount: articles.length,
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
