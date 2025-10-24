import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              textAlignVertical: TextAlignVertical(y: -1),
              decoration: InputDecoration(
                label: Text(
                  'Enter Your Card Number',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Debit Card / Credit Card',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Expiry date',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  hintText: 'MM/YY',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'CVV',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  hintText: 'Eg:456',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context).pop(); // close loading
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const PaymentSuccessPage()),
                          );
                        });
                        return AlertDialog(
                          content: Row(
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text('Processing Payment...'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.05),
                      backgroundColor: Colors.lightBlueAccent),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      )),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text("Payment Successful!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Go to Home"),
            )
          ],
        ),
      ),
    );
  }
}
