import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();

  DateTime? selectedDate;

  @override
  void dispose() {
    cardNumberController.dispose();
    expirationController.dispose();
    cvvController.dispose();
    billingAddressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expirationController.text = DateFormat('MM/yyyy').format(picked);
      });
    }
  }

  void processPayment() {
    if (_formKey.currentState!.validate()) {
      String cardNumber = cardNumberController.text;
      String expirationDate = expirationController.text;
      String cvv = cvvController.text;
      String billingAddress = billingAddressController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationPage(
            cardNumber: cardNumber,
            expirationDate: expirationDate,
            cvv: cvv,
            billingAddress: billingAddress,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/1.png',
                      width: 90,
                      height: 90,
                    ),
                    Image.asset(
                      'assets/2.png',
                      width: 90,
                      height: 90,
                    ),
                    Image.asset(
                      'assets/3.png',
                      width: 90,
                      height: 90,
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a card number';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 16.0),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: expirationController,
                      decoration: InputDecoration(
                        labelText: 'Expiration Date',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an expiration date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: cvvController,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a CVV';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: billingAddressController,
                  decoration: InputDecoration(
                    labelText: 'Billing Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a billing address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: processPayment,
                  child: Text('Submit Payment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentConfirmationPage extends StatelessWidget {
  final String cardNumber;
  final String expirationDate;
  final String cvv;
  final String billingAddress;

  PaymentConfirmationPage({
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
    required this.billingAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Card Number',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(cardNumber),
                    SizedBox(height: 16.0),
                    Text(
                      'Expiration Date',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(expirationDate),
                    SizedBox(height: 16.0),
                    Text(
                      'CVV',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(cvv),
                    SizedBox(height: 16.0),
                    Text(
                      'Billing Address',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(billingAddress),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment process completed'),
                    ),
                  );
                },
                child: Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}