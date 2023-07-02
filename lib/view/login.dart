import 'package:e_commerce_flower_app_university_project/const/provider.dart';
import 'package:e_commerce_flower_app_university_project/main.dart';
import 'package:e_commerce_flower_app_university_project/view/home.dart';
import 'package:e_commerce_flower_app_university_project/view/register.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final myPro = Provider.of<myProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Smart Parking',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: primaryClr,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/13.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: 'Email',
                    controller: emailController,
                    validator: (date) {
                      if (date!.isEmpty) {
                        return 'Can\'t be null';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hint: 'Password',
                      controller: passController,
                      isPass: myPro.showPassState,
                      widget: IconButton(
                        onPressed: () {
                          myPro.changePassState();
                        },
                        icon: myPro.showPassState
                            ? const Icon(Icons.lock)
                            : const Icon(Icons.lock_open),
                        color: Colors.blueAccent,
                      ),
                      validator: (date) {
                        if (date!.isEmpty) {
                          return 'Can\'t be null';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await myPro
                            .signIn(emailController.text, passController.text)
                            .then((value) {
                              if(value.toString()=='null'){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Home()), (route) => false);
                              }
                              else {
                                showDialog(context: context, builder: (_) =>
                                    AlertDialog(
                                      actions: [TextButton(onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text('ok',style: TextStyle(fontSize: 24),),)
                                      ],
                                      content: Text(value.toString(),
                                        style: TextStyle(fontSize: 20),),));
                              }
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>RegisterScreen()));
                        },
                        child: Text(
                          'Register ',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
