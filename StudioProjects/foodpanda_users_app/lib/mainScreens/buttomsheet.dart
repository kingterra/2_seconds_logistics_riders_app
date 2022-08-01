import "package:flutter/material.dart";
import 'package:foodpanda_users_app/mainScreens/select_payment_method.dart';
import 'package:foodpanda_users_app/widgets/yellow_button.dart';


class PaymentBsheet extends StatefulWidget {
  final int? selectedValue;
  PaymentBsheet({this.selectedValue});

  @override
  State<PaymentBsheet> createState() => _PaymentBsheetState();
}

class _PaymentBsheetState extends State<PaymentBsheet> {







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

    ),
        ),
          bottomSheet: Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  if(widget.selectedValue==1){
                    showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.3,
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
                                        'Confirm ${83} \$',
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

                  }else if (widget.selectedValue == 2) {
                    // makePayment();

                  } else if (widget.selectedValue == 3) {
                    print('paypal');
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
      ),
    );
  }
}
