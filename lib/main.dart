import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clean_demo/core/config/localization.dart';
import 'package:clean_demo/core/utils/constants.dart';
import 'package:clean_demo/core/utils/routes.dart';
import 'package:clean_demo/features/presentation/authentication/authentication_bloc.dart';
import 'package:clean_demo/features/presentation/authentication/authentication_event.dart';
import 'package:clean_demo/features/presentation/pages/feed/feed_bloc.dart';
import 'package:clean_demo/features/presentation/pages/feed/feed_screen.dart';
import 'package:clean_demo/features/presentation/pages/new_post/add_new_feed_post_bloc.dart';
import 'package:clean_demo/features/presentation/pages/new_post/add_new_feed_post_screen.dart';
import 'package:clean_demo/features/presentation/pages/splash_screen/splash_screen.dart';
import 'package:clean_demo/injection_container.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox<FeedModel>(Constants.FEED_DB);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    // this will change the brightness of the icons
    statusBarColor: Color(0xFFffcb05),
    // or any color you want
    systemNavigationBarIconBrightness:
        Brightness.dark, //navigation bar icons' color
  ));

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => sl.get<AuthenticationBloc>()..add(AppStarted()),
      child: MaterialApp(
        title: Constants.APP_NAME,
        locale: Locale('en'),
        localizationsDelegates: [const MyLocalizationsDelegate()],
        supportedLocales: [Locale('en')],
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash_screen,
        routes: _registerRoutes(),
      ),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.splash_screen: (context) => SplashScreen(),
      AppRoutes.feed_screen: (context) => BlocProvider<FeedBloc>(
            create: (context) => sl<FeedBloc>(),
            child: FeedScreen(),
          ),
      AppRoutes.add_new_post_screen: (context) => BlocProvider<AddNewFeedPostBloc>(
            create: (context) => sl<AddNewFeedPostBloc>(),
            child: AddNewFeedPostScreen(),
          ),
    };
  }
}
