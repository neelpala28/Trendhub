import 'package:flutter/material.dart';

class CreateAddress extends StatefulWidget {
  const CreateAddress({super.key});

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
                  'Create Address',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 20),

              // Name Input
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Name',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(controller: _nameController),
              ),

              // Address Lane
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text('Address Lane',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(controller: _addressController),
              ),

              // City
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text('City',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(controller: _cityController),
              ),

              // Postal Code
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text('Postal Code',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(controller: _postalCodeController),
              ),

              // Phone Number
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text('Phone Number',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(controller: _phoneController),
              ),

              SizedBox(height: 20),

              // Submit Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty) {
                      Map<String, String> newAddress = {
                        "name": _nameController.text,
                        "details":
                            "${_addressController.text}, ${_cityController.text}, ${_postalCodeController.text}",
                      };

                      Navigator.pop(context, newAddress);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      MediaQuery.of(context).size.height * 0.08,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text('Add Address'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
