import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/assistan_methods.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/mainScreens/InitialScreen.dart';
import 'package:foodpanda_users_app/mainScreens/buttomsheet.dart';

import 'package:foodpanda_users_app/assistantMethods/change_payment.dart';

import 'package:foodpanda_users_app/stripeKeys/stripe_id.dart';



import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';




class SelectPaymentMethod extends StatefulWidget {


  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {


  @override
  Widget build(BuildContext context) {


    return Material(
      color: Colors.grey.shade200,
      child: SafeArea(

        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 1,
                          groupValue:  Provider.of<ChangeSelected>(context, listen: false).selectedValued,
                          onChanged: (int? value){
                            setState (()=>
                                Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!));
                            print(Provider.of<ChangeSelected>(context, listen: false).selectedValued);
                          },


                          title: const Text('Cash On Delivery'),
                          subtitle: const Text('Pay Cash At Home'),
                        ),
                        RadioListTile(
                          value: 2,
                          groupValue: Provider.of<ChangeSelected>(context, listen: false).selectedValued,
                          onChanged: (int? value){
                            setState (()=>
                                Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!));
                            print(Provider.of<ChangeSelected>(context, listen: false).selectedValued);
                          },




                          title:
                          const Text('Pay via visa / Master Card'),
                          subtitle: Row(
                            children: const [
                              Icon(Icons.payment, color: Colors.blue),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Icon(
                                    FontAwesomeIcons.ccMastercard,
                                    color: Colors.blue),
                              ),
                              Icon(FontAwesomeIcons.ccVisa,
                                  color: Colors.blue)
                            ],
                          ),
                        ),
                        RadioListTile(
                          value: 3,
                          groupValue: Provider.of<ChangeSelected>(context, listen: false).selectedValued,
                          onChanged: (int? value){
                           setState (()=>
                               Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!));
                           print(Provider.of<ChangeSelected>(context,listen: false).selectedValued);
                            },




                          title: const Text('Pay via Paypal'),
                          subtitle: Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.paypal,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 15),
                              Icon(
                                FontAwesomeIcons.ccPaypal,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),





    ),
      ),

    );
  }


 /* Map<String,dynamic>? paymentIntentData;
  Future<void>makePayment() async{
    //createPaymentIntent
    //initPaymentshit
    //displayPaymentsheet

    try {
      paymentIntentData = await createPaymentIntent();
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              merchantDisplayName: 'ANNIE',
              merchantCountryCode: 'nigeria'
          ));
      await displayPaymentsheet();
    }catch(e){
      print(e.toString());
    }
  }*/

 /* createPaymentIntent() async
  {
    try {
      Map<String, dynamic> body = {
        'amount': widget.totalAmount,
        'currency': 'Naira',
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${stripesecretket}',
            'content_type': "application/x-www-form-urlencoded"
          }
      );
      return jsonDecode(response.body);
    }
    catch(e){
      print(e.toString());
    }

  }*/
  displayPaymentsheet()async{

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((value) async{
        paymentIntentData=null;
      });
    }catch(e){
      print(e.toString());
    }
  }
}
Map<String,dynamic>? paymentIntentData;
Future<void>makePayment() async{
  //createPaymentIntent
  //initPaymentshit
  //displayPaymentsheet

  try {
    paymentIntentData = await createPaymentIntent();
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            testEnv: true,
            merchantDisplayName: 'ANNIE',
            merchantCountryCode: 'nigeria'
        ));
    await displayPaymentsheet();
  }catch(e){
    print(e.toString());
  }
}

createPaymentIntent() async
{
  try {
    Map<String, dynamic> body = {
      'amount': 10,
      'currency': 'Naira',
      'payment_method_types[]': 'card'
    };
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${stripesecretket}',
          'content_type': "application/x-www-form-urlencoded"
        }
    );
    return jsonDecode(response.body);
  }
  catch(e){
    print(e.toString());
  }

}
displayPaymentsheet()async{

  try {
    await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['client_secret'],
          confirmPayment: true,
        )).then((value) async{
      paymentIntentData=null;
    });
  }catch(e){
    print(e.toString());
  }
}

