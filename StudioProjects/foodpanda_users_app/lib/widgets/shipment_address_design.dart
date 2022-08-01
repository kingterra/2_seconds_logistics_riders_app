import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/InitialScreen.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';
import 'package:foodpanda_users_app/models/address.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;

  ShipmentAddressDesign({this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding:  EdgeInsets.all(10.0),
         child: Text(
            'Shipment Details:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
       ),
        SizedBox(
          width: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                 const Text(
                    "Name",
                    style: TextStyle(
                       color: Colors.black,
                    ),
                  ),

                  Text(model!.name!),
                ]
              ),

              TableRow(
                  children: [
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),

                    Text(model!.phoneNumber!),
                  ]
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
           model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  InitialScreen()));
              },

              child: Container(
               decoration: BoxDecoration(
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
                width: MediaQuery.of(context).size.width-40,
                height: 50,
                child: Center(
                  child: Text(
                    "go back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),

                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
