import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/TicketCubit/ticketController.dart';
import 'package:food_delivery_app/Controller/UserCubit/userController.dart';
import 'package:food_delivery_app/Controller/productCubit/productController.dart';
import 'package:food_delivery_app/View/Screens/Product/cartScreen.dart';
import 'package:food_delivery_app/View/Screens/Product/homeScreen.dart';
import 'package:food_delivery_app/View/Screens/Product/orderScreen.dart';
import 'package:food_delivery_app/View/Screens/User/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/MapCubit/mapController.dart';
import 'Controller/blocObserver.dart';
import 'View/Screens/Product/orderListScreen.dart';
import 'View/Screens/Settings/aboutUsScreen.dart';
import 'View/Screens/Settings/contactUsScreen.dart';
import 'View/Screens/Settings/policyScreen.dart';
import 'View/Screens/Settings/settingsScreen.dart';
import 'View/Screens/User/loginScreen.dart';
import 'View/Screens/User/userAccount.dart';
import 'View/SharedThemes/colorsManager.dart';
import 'View/SharedThemes/fontsManager.dart';
import 'View/SharedThemes/valuesManager.dart';

//bool shouldUseFirebaseEmulator = false;

Future<void> main()async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }*/
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
@override
  void initState() {
    // TODO: implement initState
  check();
  super.initState();
  }
bool isLogin=false;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers:[
        BlocProvider<ProductController>(create: (BuildContext context) => ProductController()),
        BlocProvider<MapController>(create: (BuildContext context) => MapController()),
        BlocProvider<UserController>(create: (BuildContext context) => UserController()),
        BlocProvider<TicketController>(create: (BuildContext context) => TicketController()),
      ],
      child: MaterialApp(
        routes:  {
          "login":(context)=>const LoginScreen(),
          "signUp":(context)=>const SignUpScreen(),
          "home":(context)=>const HomeScreen(),
          "cart":(context)=>const CartScreen(),
          "order":(context)=>const OrderDetailsScreen(),
          "contact":(context)=>const ContactUsScreen(),
          "about":(context)=>const AboutUsScreen(),
          "policy":(context)=>const PolicyScreen(),
          "settings":(context)=>const SettingsScreen(),
          "account":(context)=>const AccountScreen(),
          "ticket":(context)=>const OrdersList()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsManager.whiteColor,
          appBarTheme:  AppBarTheme(
            backgroundColor: ColorsManager.blackColor,
            elevation: AppSize.size0,
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: ColorsManager.whiteColor, size: AppSize.size25
            ),
            titleTextStyle: FontsManager.getTextStyleBold(color: ColorsManager.whiteColor )
          )
        ),
        home:isLogin==false?const LoginScreen():const HomeScreen(),
      ),
    );
  }
  check() async{
    SharedPreferences saveUser= await SharedPreferences.getInstance();
    int userLogin= saveUser.getInt("uid")!;
    print("$userLogin Shared Preferences geeeeeeeeeeeeeeeeet");
    if(userLogin == 1){
      print("true $isLogin");
      isLogin= true;
      print("true $isLogin");

    }else{
      print("false $isLogin");
      isLogin= false;
      print("false $isLogin");

    }
  }
//isLogin == true?const HomeScreen():

}

