import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/service/database.dart';
import 'package:flutter_food_delivery_app/service/shared_pref.dart';
import 'package:flutter_food_delivery_app/widget/widget_support.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http ;

import '../widget/app_constant.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();

}

class _WalletState extends State<Wallet> {

  String? wallet , id ;
  int? add ;
  TextEditingController amountcontroller = new TextEditingController();

  getSharedPref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();

    setState(() {
      if (wallet != null) {
        wallet = double.parse(wallet!).toStringAsFixed(2);
      }
    });

  }


  onTheLoad() async {

    await getSharedPref() ;

    setState(() {

    });

  }

  @override
  void initState() {
    onTheLoad();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: wallet == null
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Material(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          "Wallet",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                    ),

                    child: Row(

                      children: [

                        Image.asset(
                          "images/wallet.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),

                        SizedBox(width: 40,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Your Wallet", style: AppWidget.LightTextFieldStyle(),),

                            SizedBox(height: 5,),

                            Text("\₹" + (-1 * double.parse(wallet!)).toStringAsFixed(2), style: AppWidget.boldTextFieldStyle(),),
                          ],
                        ),

                      ],

                    ),

                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, ),
                    child: Text(
                      "Add money ",
                      style: AppWidget.semiBoldFieldStyle(),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      GestureDetector(

                        onTap: () {

                          makePayment('100');

                        },

                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE9E2E2)),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Text(
                            "\₹" + "100",
                            style: AppWidget.semiBoldFieldStyle(),
                          ),

                        ),
                      ),

                      GestureDetector(

                        onTap: () {

                          makePayment('500');

                        },

                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE9E2E2)),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Text(
                            "\₹" + "500",
                            style: AppWidget.semiBoldFieldStyle(),
                          ),

                        ),
                      ),

                      GestureDetector(

                        onTap: () {

                          makePayment('1000');

                        },

                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE9E2E2)),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Text(
                            "\₹" + "1000",
                            style: AppWidget.semiBoldFieldStyle(),
                          ),

                        ),
                      ),

                      GestureDetector(

                        onTap: () {

                          makePayment('2000');

                        },

                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE9E2E2)),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Text(
                            "\₹" + "2000",
                            style: AppWidget.semiBoldFieldStyle(),
                          ),

                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 50,),

                  GestureDetector(

                    onTap: (){

                      openEdit();

                    },

                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50,),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFF008080),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Center(
                        child: Text(
                          "Add Money",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ),
                  ),

                ],

              ),

      ),


    );
  }

  Future<void> makePayment(String amount) async {

    try {

      paymentIntent = await createPaymentIntent(amount, "INR") ;

      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(

        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Adnan',

      )).then((value) {});

      displayPaymentSheet(amount) ;


    } catch (e,s) {

      print('execption : $e$s');

    }

  }

  displayPaymentSheet(String amount) async {

    try {

      await Stripe.instance.presentPaymentSheet().then((value) async {

        add = int.parse(wallet!) + int.parse(amount) ;
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().UpdateUserWallet(id!, add.toString());

        showDialog(

            context: context,
            builder: (_) => AlertDialog(

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Payment Successful"),

                      SizedBox(width: 5,),

                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),

                    ],

                  )

                ],

              ),

            ));

        await getSharedPref() ;

        paymentIntent = null ;

      }).onError((error, stackTrace) {
        
        print('Error is: -----> $error $stackTrace');
        
      });
      
    } on StripeException catch (e) {
      
      print('Error is: -----> $e');
      
      showDialog(context: context, builder: (_) => const AlertDialog(
        
        content: Text("Cancelled"),
        
      ));
      
    } catch (e) {
      
      print("$e");
      
    }

  }

  createPaymentIntent(String amount, String currency) async {

    try {

      Map<String, dynamic> body = {

        'amount' : calculateAmount(amount),
        'currency' : currency,
        'payment_method_types[]' : 'card',

      };

      var response = await http.post(

        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type' : 'application/x-www-form-urlencoded'
        },

        body: body,

      );
      
      print('Payment Intent Body ----> ${response.body.toString()}');

      return jsonDecode(response.body);

    } catch (e) {

      print('error charging user : ${e.toString()}');

    }


  }

  calculateAmount(String amount) {

    // Convert the amount to the smallest currency unit (e.g., cents for USD)
    final calculateAmount = int.parse(amount) * 100 ;

    return calculateAmount.toString() ;

  }

  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel)),
                    SizedBox(
                      width: 60.0,
                    ),
                    Center(
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xFF008080),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Amount"),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: amountcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Amount'),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      makePayment(amountcontroller.text);
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF008080),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));

}









