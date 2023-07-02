import 'package:e_commerce_flower_app_university_project/view/pay.dart';
import 'package:flutter/material.dart';


class time extends StatefulWidget {
  const time({Key? key}) : super(key: key);

  @override
  State<time> createState() => _timeState();
}

class _timeState extends State<time> {
  int x = 0;
  int y = 0;

  @override
  Widget build(BuildContext context) {
    double z = (y / 60 + x) * 5 as double;
    int j = z.round();

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$x : $y',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      x--;
                      if (x == -1) {
                        x = 0;
                      }
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      x++;
                    });
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      y--;
                      if (y == -1) {
                        y = 0;
                      }
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      y++;
                      if (y == 60) {
                        x++;
                        y = 0;
                      }
                    });
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'price : $j',
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              ),
              onPressed: () {
                if (x == 0 && y == 0) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please select a valid time.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentForm(),
                    ),
                  );
                }
              },
              child: Text(
                'Pay',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
