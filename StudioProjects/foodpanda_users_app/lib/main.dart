import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_Item_Counter.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/assistantMethods/change_payment.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';
import 'package:foodpanda_users_app/stripeKeys/stripe_id.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'assistantMethods/address_changer.dart';
import 'assistantMethods/total_amount.dart';

Future<void> main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (c)=> CartItemCounter()),
        ChangeNotifierProvider(create: (c)=> TotalAmount()),
        ChangeNotifierProvider(create: (c)=> AddressChanger()),
        ChangeNotifierProvider(create: (c)=>ChangeSelected()),
        ChangeNotifierProvider(create: (c)=>AddressIDChanger()),

      ],
      child: MaterialApp(
        title: 'users app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}


