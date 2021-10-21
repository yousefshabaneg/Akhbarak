import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/shared/constants/my_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          NewsCubit.get(context).isRtl
              ? 'أخبارك - Akhbarak'
              : 'Akhbarak - أخبارك',
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primary,
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
