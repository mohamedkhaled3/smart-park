
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'time.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {

    final userData = FirebaseAuth.instance
        .currentUser; // to get data when login with "google or facebok or twitter"
// bool flag=false;
    return Scaffold(
      appBar: AppBar(

        title: const Text("Home"),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [



            // flag?

            Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(image:
                        AssetImage('assets/cover2.jpeg'
                        ),
                            alignment: Alignment.topCenter,
                            width : 350
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: 100,
                        child: Text(
                          'find your place',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight : FontWeight.bold ,
                            shadows : <Shadow>[
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 6.0,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 150,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image:
                        AssetImage('assets/whiteCar.png'
                        ),
                          height:100 ,
                          width: 60,
                        ),
                        VerticalDivider(
                          thickness : 3 ,
                        ),

                        Image(image:
                        AssetImage('assets/whiteCar.png'
                        ),
                          height:100 ,
                          width: 60,
                        ),

                        VerticalDivider(
                          thickness : 3 ,
                        ),

                        Image(image:
                        AssetImage('assets/whiteCar.png'
                        ),
                          height:100 ,
                          width: 60,
                        ),
                        VerticalDivider(
                          thickness : 3 ,
                        ),

                        Image(image:
                        AssetImage('assets/whiteCar.png'
                        ),
                          height:100 ,
                          width: 60,
                        ),


                      ],
                    ),
                  ),
                ]
            ),
            //    Container(child: Text("empty"),): Container(child: Text("empty"),)
            SizedBox(
              height: 50,
            ),

            Text(
              "Total Spaces : 4",
              style: TextStyle(fontSize: 43),
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width - 150,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder:(context) => time(

                      )));
                    },
                    child: Text(
                      'Book',
                      style: TextStyle(fontSize: 30),
                    )))
          ],
        ),
      ),
    );
  }
}
