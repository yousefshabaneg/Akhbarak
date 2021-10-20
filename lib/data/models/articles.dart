/*
"articles":
[
  {
    "source": {"id":null,"name":"Yallakora.com"},
    "author":"يلاكورة",
    "title":"مصدر ليلا كورة: الأهلي يفقد صلاح محسن لمدة 4 أسابيع - يلا كورة",
    "description":"كشف مصدر بالأهلي أن صلاح محسن مهاجم الفريق الأول لكرة القدم بالنادي سيغيب لفترة زمنية لن تقل عن 4 أسابيع بداعي الإصابة.",
    "url":"https://www.yallakora.com/egyptian-league/2730/news/415924/-لن-يلحق-بالقمة-مصدر-ليلا-كورة-الأهلي-يفقد-صلاح-محسن-4-أسابيع",
    "urlToImage":"https://media.gemini.media/img/yallakora/Normal/\\2021\\5\\12\\1d6c8216-4ea8-423c-84e5-b7e3961c4e992021_5_12_0_37.jpg",
    "publishedAt":"2021-10-19T07:45:00Z",
    "content":": \r\n:"
  },
]
*/

class Article {
  late String title;
  late String url;
  String? urlToImage;
  late String publishedAt;

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = _dateAndTime(json['publishedAt']);
  }

  String _dateAndTime(String publishedAt) {
    // "2021-10-18T06:41:00Z"
    var splitted = publishedAt.split('T');
    return '${splitted[0]} - ${splitted[1].substring(0, 5)}';
  }
}
