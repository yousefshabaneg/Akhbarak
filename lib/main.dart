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
import 'package:news_app/shared/constants/my_colors.dart';

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
                borderSide: new BorderSide(color: MyColors.primary),
              ),
              hintStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: MyColors.dark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            textTheme: TextTheme(
              bodyText1: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColors.secondary,
                ),
              ),
            ),
            primarySwatch: MyColors.primaryColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              elevation: 0,
              titleTextStyle: GoogleFonts.kufam(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary,
                ),
              ),
              iconTheme: IconThemeData(
                color: MyColors.secondary,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyColors.primary,
              unselectedItemColor: MyColors.dark,
              elevation: 20,
              backgroundColor: Colors.white,
              selectedLabelStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              unselectedLabelStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          darkTheme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: new BorderSide(
                  color: MyColors.primary,
                ),
              ),
              hintStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            scaffoldBackgroundColor: MyColors.secondary,
            primarySwatch: MyColors.primaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: MyColors.secondary,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: MyColors.secondary,
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: 0,
              titleTextStyle: GoogleFonts.kufam(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary,
                  fontSize: 20,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyColors.primary,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              elevation: 20,
              backgroundColor: MyColors.secondary,
              selectedLabelStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              unselectedLabelStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            textTheme: TextTheme(
              bodyText1: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
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
