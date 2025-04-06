import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/service/database.dart';
import 'package:flutter_food_delivery_app/service/shared_pref.dart';
import 'package:flutter_food_delivery_app/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String? id , wallet ;
  Stream? foodStream ;
  double? total = 0 , amount2 = 0 ;

  void startTimer() {

    Timer(Duration(seconds: 1), () {

      amount2 = total ;

      setState(() {

      });

    });

  }

  getTheSharedPref() async {

    id = await SharedPreferenceHelper().getUserId() ;
    wallet = await SharedPreferenceHelper().getUserWallet() ;

    setState(() {

    });

  }

  onTheLoad() async {

    await getTheSharedPref() ;
    foodStream = await DatabaseMethods().getFoodCart(id!) ;

    setState(() {

    });

  }

  @override
  void initState() {
    onTheLoad() ;
    startTimer() ;
    super.initState();
  }


  Widget foodCart() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];

              // Remove all non-numeric characters (e.g., $, ₹, commas) before parsing
              String totalString = ds["Total"].replaceAll(RegExp(r'[^0-9.]'), '');
              total = (total! + double.parse(totalString));

              return Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(ds["Quantity"])),
                        ),
                        SizedBox(width: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            ds["Image"],
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ds["Name"],
                                style: AppWidget.semiBoldFieldStyle(),
                              ),
                              Text(
                                "₹$totalString", // Display the cleaned total with ₹ symbol
                                style: AppWidget.semiBoldFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
            : Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    "Food Cart",
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              flex: 100,
                child: foodCart()
            ),

            Spacer(),

            Divider(),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Total Price", style: AppWidget.boldTextFieldStyle(),),

                  Text("\₹" + total.toString(), style: AppWidget.semiBoldFieldStyle(),),

                ],
              ),
            ),

            SizedBox(height: 20,),

            GestureDetector(

              onTap: () async {

                double amount = double.parse(wallet!) - amount2! ;

                await DatabaseMethods().UpdateUserWallet(id!, amount.toString()) ;
                await SharedPreferenceHelper().saveUserWallet(amount.toString()) ;

              },

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(child: Text("CheckOut", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),

              ),
            ),



          ],

        ),

      ),


    );
  }
}
