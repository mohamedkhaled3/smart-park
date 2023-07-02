
import 'package:e_commerce_flower_app_university_project/const/provider.dart';
import 'package:e_commerce_flower_app_university_project/view/login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';



class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final myPro = Provider.of<myProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title:Text(
            'Sign-Up',style: TextStyle(color: Colors.white),
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.all( 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/13.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  CustomTextField(
                      hint: 'Name',
                      validator: (date) {
                        if (date!.isEmpty) {
                          return 'Can\'t be null';
                        }
                      }),

                  const SizedBox(
                    height: 10,
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
                      controller: passwordController,
                      validator: (date) {
                        if (date!.isEmpty) {
                          return 'Can\'t be null';
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Register',
                    onTap: () async{

                      if (formKey.currentState!.validate()) {
                        await myPro
                            .signIn(emailController.text, passwordController.text)
                            .then((value) {
                          if(value.toString()=='null'){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginScreen()), (route) => false);
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
                        'Already have an account? ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500,color: Colors.blueAccent),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginScreen()), (route) => false);

                        },
                        child: Text(
                          'Login ',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
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

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
        required this.hint,
        this.controller,
        this.validator,
        this.isPass, this.widget})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  bool? isPass ;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isPass ?? false,
      controller: controller,

      style: const TextStyle(color: Colors.black, fontSize: 17),
      decoration: InputDecoration(
          hintText: hint,
          suffixIcon: widget,
          hintStyle: const TextStyle(color: Colors.blueAccent, fontSize: 17),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent))),
    );
  }
}



class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, required this.text}) : super(key: key);
  final void Function()? onTap ;
  final String text ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}