
import 'dart:async';

import 'package:abdulla_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/shop_app/shop_layout.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/social_app/social_layout.dart';
import 'package:abdulla_mansour/modules/animated_login.dart';
import 'package:abdulla_mansour/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdulla_mansour/modules/shop_app/onboarding_screen.dart';
import 'package:abdulla_mansour/modules/social_app/feeds/feeds_screen.dart';
import 'package:abdulla_mansour/modules/social_app/social_login/social_login_screen.dart';
import 'package:abdulla_mansour/shared/bloc_observer.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:abdulla_mansour/shared/components/constants.dart';
import 'package:abdulla_mansour/shared/components/themes.dart';
import 'package:abdulla_mansour/shared/cubit/cubit.dart';
import 'package:abdulla_mansour/shared/cubit/states.dart';
import 'package:abdulla_mansour/shared/network/local/cashe_helper.dart';
import 'package:abdulla_mansour/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/qr_code/Read_Qr.dart';
import 'modules/social_app/new_post/new_post_screen.dart';
import 'sotre-app/store screen.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message ');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS,);

}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
var token=FirebaseMessaging.instance.getToken();

print (token);


//on (forground) app
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  //when click to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());

    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });

  //background app fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool isDark = CasheHelper.getData(key: 'isDark');

  Widget widget;

 bool onBoarding =CasheHelper.getData(key: 'onBoarding');
 token =CasheHelper.getData(key: 'token');

 uId =CasheHelper.getData(key: 'uId');

  if (onBoarding !=null)
  {
    if(token !=null) widget =ShopLayout();
    else widget =ShopLoginScreen();
  }else
    {
      widget =OnBoardingScreen();
    }


  if(uId !=null)
    {
      widget = SocialLayout();
    }else
      {
        widget =SocialLoginScreen();
      }

  runApp(MyApp(
   // NewPostScreen:widget,
  /* isDark: isDark,
    startWidget:widget,

   */
  ));
  }
class MyApp extends StatelessWidget {
 // final bool isDark;
  //final Widget startWidget;

  MyApp();
  /*  this.isDark,
   this.startWidget,
   */





  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:[
        BlocProvider(create: (context) =>
    NewsCubit()
      ..getBusiness()
      ..getSports()
      ..getScience()
    ),
    BlocProvider(
    create: (BuildContext context) =>
    AppCubit()
    ..changeAppMode(
     //fromShared: isDark,
    ),
    ),
    BlocProvider(
    create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
    ),
    BlocProvider(
    create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
    ),
    ],

    child: BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: lightTheme,
  darkTheme: darkTheme,
    themeMode:
 AppCubit
      .get(context)
      .isDark ? ThemeMode.dark : ThemeMode.light,
           // SocialLoginScreen
            //startWidget
            home:NewsLayout(),
            title: "Yassin",

          );
        },
  ),
      );

  }
}
