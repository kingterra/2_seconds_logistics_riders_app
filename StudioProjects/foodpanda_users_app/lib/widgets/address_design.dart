import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/addressIDChanger.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:foodpanda_users_app/mainScreens/select_payment_method.dart';
import 'package:foodpanda_users_app/maps/maps.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';




class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentindex;
  final int? value;
  final String? addresID;
  final double? totalAmount;
  final String? sellerID;

  AddressDesign({
    this.model,
    this.currentindex,
    this.value,
    this.addresID,
    this.totalAmount,
    this.sellerID,
});

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {






  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // Select this address

        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);



      },

      child: Card(
        color: Colors.white,
        child: Column(
          children: [
        //Address info
        Row(
        children: [
        Radio(
        groupValue: widget.currentindex!,
          value: widget.value!,
          activeColor: Colors.amber,
          onChanged: (val)
          {
            //provider
            Provider.of<AddressChanger>(context, listen: false).displayResult(val);
            Provider.of<AddressIDChanger>(context, listen: false).display(widget.addresID);
            print(val);
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.8,

              child: Table(
                children: [
                  TableRow(
                    children:[

                      const Text(
                        "Name: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(widget.model!.name.toString()),
                    ],
                  ),

                  TableRow(
                    children:[

                      const Text(
                        "Phone number: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(widget.model!.phoneNumber.toString()),
                    ],
                  ),

                  TableRow(
                    children:[

                      const Text(
                        "Full address: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(widget.model!.fullAddress.toString()),
                    ],
                  ),
                ],
              ),

            ),



          ],
        ),
        ],
      ),


      /*child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            //Address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentindex!,
                  value: widget.value!,
                  activeColor: Colors.amber,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,

                      child: Table(
                        children: [
                          TableRow(
                            children:[

                              const Text(
                                "Name: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.name.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                             const Text(
                                "phone Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.phoneNumber.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "Flat Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.flatNumber.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "city: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.city.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "State: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.state.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "Full Address: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.fullAddress.toString()),
                            ],
                          ),
                        ],
                      ),

                    ),



                  ],
                ),
              ],
            ),

            //check the address on google map

            ElevatedButton(

              child: const Text("Check on Maps"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              onPressed: ()
              {

                Maputils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);

              },

            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(

              child: const Text("Proceed"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green
              ),

              onPressed: ()
              {

              },


            )
                : Container(),


          ],
        ),
      ),*/
          ],
        ),
      ),
    );
  }
}
