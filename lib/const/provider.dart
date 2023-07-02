import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myProvider extends ChangeNotifier {
  Future signIn(emailController, passwordController) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  register(emailController, passwordController) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController,
      password: passwordController,
    );
  }

  bool showPassState = false;

  changePassState() {
    showPassState = !showPassState;
    notifyListeners();
  }
}
