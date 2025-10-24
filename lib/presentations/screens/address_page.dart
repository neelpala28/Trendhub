import 'package:flutter/material.dart';
import 'package:trendhub/presentations/screens/create_address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? _selectedAddress;
  List<Map<String, String>> addressList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 30),
                ),
              ),

              // Dynamic List of Radio Buttons
              ...addressList.map((address) {
                return RadioListTile<String>(
                  value: address["name"]!,
                  groupValue: _selectedAddress,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAddress = value;
                    });
                  },
                  title: Text(address["name"]!),
                  subtitle: Text(address["details"]!),
                );
              }).toList(),

              // Add Address Button
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  top: MediaQuery.of(context).size.height * 0.5,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final newAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAddress()),
                    );

                    if (newAddress != null &&
                        newAddress is Map<String, String>) {
                      setState(() {
                        addressList.add(newAddress);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    'Add Address',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),

              // Continue to Payment Button
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                    if (_selectedAddress != null) {
                      // Proceed with selected address
                      print("Selected Address: $_selectedAddress");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
