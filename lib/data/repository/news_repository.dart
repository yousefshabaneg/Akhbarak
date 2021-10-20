import 'package:news_app/data/api/news_api.dart';
import 'package:news_app/data/models/articles.dart';

class NewsRepository {
  static Future<List<Article>> getAllArticles(
      {required String category}) async {
    final articles = await DioHelper.getData(query: {
      'country': 'eg',
      'category': category,
      'apiKey': '09d7535fab10496a84591afdf3c145be'
    });
    return articles.map((article) => Article.fromJson(article)).toList();
  }
}
