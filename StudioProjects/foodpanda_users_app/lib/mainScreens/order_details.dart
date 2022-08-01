import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/assistan_methods.dart';
import 'package:foodpanda_users_app/mainScreens/InitialScreen.dart';
import 'package:foodpanda_users_app/mainScreens/address_screen.dart';
import 'package:foodpanda_users_app/mainScreens/buttomsheet.dart';
import 'package:foodpanda_users_app/mainScreens/change_payment.dart';

import 'package:foodpanda_users_app/mainScreens/select_payment_method.dart';
import 'package:foodpanda_users_app/models/id_address.dart';
import 'package:foodpanda_users_app/widgets/order_details_buttonAddress_widget.dart';
import 'package:foodpanda_users_app/widgets/yellow_button.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../global/global.dart';
import '../models/address.dart';
import '../widgets/progress_bar.dart';

class OrderDetailsScreen extends StatefulWidget {

  final double? totalAmount; //we receive the valueble from cartscreen
  final String? sellerUID;

  OrderDetailsScreen({this.totalAmount, this.sellerUID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int selected = 1;

  ChangeSelected ?seleccionMetodoPago;
  AddressChanger ?seleccionDireccion;


  AddressUID? addressID;

  String orderid = DateTime
      .now()
      .millisecondsSinceEpoch
      .toString();


  addOrderDetails() {
    writeOrderDetailsForUser({
      "addressID": Provider.of<AddressIDChanger>(context, listen: false).IDChanger,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderid,
      "isSuccess": true,
      "sellerID": widget.sellerUID,
      "riderID": "",
      "status": "normal",
      "orderid": orderid,
    });


    writeOrderDetailsForSeller({
      "addressID":  Provider.of<AddressIDChanger>(context, listen: false).IDChanger,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderid,
      "isSuccess": true,
      "sellerID": widget.sellerUID,
      "riderID": "",
      "status": "normal",
      "orderid": orderid,
    }).whenComplete(() {
      clearCartNow(context);
      setState(() {
        orderid = "";
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => InitialScreen()));
        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed successfully.");
      });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderid).set(data);

  }


  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance

        .collection("orders")
        .doc(orderid)
        .set(data);
  }



  @override
  Widget build(BuildContext context) {

    // BUTTON COLORS

    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey.shade300;
      }
      return Colors.white;
    }


    Color getForegroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black54;
      }
      return Colors.black;
    }


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomSheet: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
          child: Container(
            height: MediaQuery.of(context).size.height/14,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,),

            child:TextButton(
              onPressed: () {
                if ( Provider.of<AddressChanger>(context, listen: false).numeroDireccion == -1 && Provider.of<ChangeSelected>(context, listen: false).selectedValued == 0) {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.3,
                            child: Padding(
                              padding:    const EdgeInsets.only(bottom: 100),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You havent selected a payment method or shipping address',
                                      style: const TextStyle(
                                          fontSize: 20),
                                    ),

                                  ]),
                            ),
                          )
                  );
                }
                else {
                  if (Provider.of<AddressChanger>(context, listen: false).numeroDireccion == -1) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding:    const EdgeInsets.only(bottom: 100),
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'You havent selected an address',
                                        style: const TextStyle(
                                            fontSize: 24),
                                      ),
                                    ]),
                              ),
                            )
                    );
                  }
                  else if (Provider.of<ChangeSelected>(context, listen: false).selectedValued == 0) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding:    const EdgeInsets.only(bottom: 100),
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'You havent selected a shipping method',
                                        style: const TextStyle(
                                            fontSize: 24),
                                      ),
                                    ]),
                              ),
                            )
                    );
                  }
                  else {
                    if (Provider.of<ChangeSelected>(context, listen: false).selectedValued==1){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding:    const EdgeInsets.only(bottom: 100),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Pay At Home ${83} \$',
                                          style: const TextStyle(
                                              fontSize: 24),
                                        ),
                                        YellowButton(
                                          label:
                                          'Confirm',
                                          width: 0.9,
                                          onPressed: () async {
                                            //showProgress();
                                            //addOrderDetails();
                                            addOrderDetails();
                                          },
                                        )
                                      ]),
                                ),
                              )
                      );

                    }
                    if ( Provider.of<ChangeSelected>(context, listen: false).selectedValued == 2) {

                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding:    const EdgeInsets.only(bottom: 100),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Pay with card ${83} \$',
                                          style: const TextStyle(
                                              fontSize: 24),
                                        ),
                                        YellowButton(
                                          label:
                                          'Confirm',
                                          width: 0.9,
                                          onPressed: () async {
                                            //showProgress();

                                            //addOrderDetails();
                                          },
                                        )
                                      ]),
                                ),
                              )
                      );

                    }
                    if ( Provider.of<ChangeSelected>(context, listen: false).selectedValued == 3) {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding:    const EdgeInsets.only(bottom: 100),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Pay with Paypal ${83} \$',
                                          style: const TextStyle(
                                              fontSize: 24),
                                        ),
                                        YellowButton(
                                          label:
                                          'Confirm',
                                          width: 0.9,
                                          onPressed: () async {
                                            //showProgress();
                                            //addOrderDetails();
                                          },
                                        )
                                      ]),
                                ),
                              )
                      );
                    }
                  }
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  //fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //expandedHeight: MediaQuery.of(context).size.height*0.125,
            pinned: true,
            foregroundColor: Colors.black,
            elevation: 3,
            backgroundColor: Colors.white,
            /*title: Text(
                 "Order details",
                 style: TextStyle(fontSize: 24, color: Colors.black),
               ),*/
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Order details",
                style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.015,
              )
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(getBackgroundColor),
                      foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
                      elevation: MaterialStateProperty.all(0)
                  ),
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (c)=> AddressScreen())); },
                  child: Container(
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                              width: MediaQuery.of(context).size.width*0.125,
                              child: FaIcon(FontAwesomeIcons.locationDot, /*color: Colors.black,*/ size: 25)
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width*0.75,
                            child: Text(
                              "Select address",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),

                          Container(
                              child: FaIcon(FontAwesomeIcons.angleRight, /*color: Colors.black,*/ size: 25)
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              )
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(getBackgroundColor),
                      foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
                      elevation: MaterialStateProperty.all(0)
                  ),
                  onPressed: () { /*Navigator.push(context, MaterialPageRoute(builder: (c)=> AddressScreen()));*/ },
                  child: Container(
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                              width: MediaQuery.of(context).size.width*0.125,
                              child: FaIcon(FontAwesomeIcons.creditCard, /*color: Colors.black,*/ size: 25)
                          ),

                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (c)=> SelectPaymentMethod()));
                            },

                         child: Container(
                            width: MediaQuery.of(context).size.width*0.75,
                            child: Text(
                              "Select payment method",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          ),

                          /*Consumer<AddressChanger>(builder: (context, address, c){
                            return Flexible(
                              child: StreamBuilder<QuerySnapshot>(
                                stream:   FirebaseFirestore.instance.collection("users")
                                    .doc(sharedPreferences!.getString("uid"))
                                    .collection("userAddress")
                                    .snapshots(),
                                builder: (context, snapshot)
                                {
                                  return !snapshot.hasData
                                      ? Center(child: circularProgress(),)
                                      : snapshot.data!.docs.length==0
                                      ? Container()
                                      : ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index)
                                    {
                                      return buttonAdressWidget(
                                        currentindex: address.count,
                                        value: index,
                                        addresID: snapshot.data!.docs[index].id,
                                        totalAmount: widget.totalAmount,
                                        sellerID: widget.sellerUID,
                                        model: Address.fromjson(
                                            snapshot.data!.docs[index].data() as Map<String, dynamic>
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }),*/

                          FaIcon(FontAwesomeIcons.angleRight, /*color: Colors.black,*/ size: 25),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              )
          ),
          SliverToBoxAdapter(
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.075,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Delivery time:   30 - 45 min",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
              )
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              )
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Your items:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Arroz con pollo x 1",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Ensalada de Pato x 4",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Pizza BBQ x 1",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.04),
                      Text(
                        "Spaghetti Carbonara x 1",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.005,
              )
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.075,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.04),
                  Text(
                    "Total price: 13.670 NGN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                    child: Container(
                      height: MediaQuery.of(context).size.height/14,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),

                    ),
                      /*TextButton(
                        onPressed: () { /*Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(),),); */},
                        child: Text(
                            'Continue',
                            style: TextStyle(
                              //fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white
                            )
                        ),

                      ),*/
                    ),
                ],
              )
          )
        ],
      ),
    );
  }
}