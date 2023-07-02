import 'package:e_commerce_flower_app_university_project/const/provider.dart';
import 'package:e_commerce_flower_app_university_project/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (context) {
        return myProvider();
      }),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),

      ),
    );
  }
}


Color primaryClr = Colors.white;
showToast({String msg ='' ,clr }){
  Toast.show(msg, duration: Toast.lengthShort, gravity:  Toast.bottom,backgroundColor:clr);
}