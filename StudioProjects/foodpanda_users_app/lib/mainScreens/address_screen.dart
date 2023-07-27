import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';

import 'package:foodpanda_users_app/mainScreens/save_Address_Screen.dart';
import 'package:foodpanda_users_app/models/id_address.dart';
import 'package:foodpanda_users_app/models/items.dart';

import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../models/address.dart';
import '../widgets/address_design.dart';


class AddressScreen extends StatefulWidget
{


  final double? totalAmount; //we receive the valueble from cartscreen
  final String? sellerUID;

  AddressScreen({this.totalAmount, this.sellerUID});



  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
              )
          ),
        ),
        centerTitle: true,
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),


      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add New Address"),
        backgroundColor: Colors.cyan,
        icon: const Icon(Icons.add_location, color: Colors.white,),
        onPressed: ()
        {
          //save address to user collection
          Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));

        },
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(

            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Select address:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight:  FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Consumer<AddressChanger>(builder: (context, address, c){
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
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index)
                    {


                      return AddressDesign(
                        currentindex: address.count,
                        value: index,
                        addresID:   snapshot.data!.docs[index].id,
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
          }),

        ],
      ),


    );
  }
}
