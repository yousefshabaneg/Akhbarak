import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/data/api/news_api.dart';
import 'package:news_app/data/cashe_helper.dart';
import 'package:news_app/layout/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBool(key: 'isDark');
  bool? isRtl = CashHelper.getBoolRtl(key: 'isRtl');

  runApp(MyApp(isDark, isRtl));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final bool? isRtl;
  MyApp(this.isDark, this.isRtl);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..changeAppMode(fromShared: isDark)
        ..changeAppDirection(fromShared: isRtl)
        ..getGeneralArticles()
        ..getTechnologyArticles()
        ..getSportsArticles()
        ..getHealthArticles(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: new BorderSide(color: Colors.deepOrange),
              ),
              hintStyle: TextStyle(
                color: Colors.black54,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.black.withOpacity(0.7),
              elevation: 20,
              backgroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: new BorderSide(color: Colors.deepOrange),
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            scaffoldBackgroundColor: HexColor('333739'),
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              backgroundColor: HexColor('333739'),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.white.withOpacity(0.7),
              elevation: 20,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: TextTheme(
              bodyText1: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Directionality(
              textDirection: NewsCubit.get(context).isRtl
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: NewsLayout()),
        ),
      ),
    );
  }
}
