import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendhub/presentations/screens/address_page.dart';
import 'package:trendhub/presentations/screens/home_screen.dart';
import '../../data/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).cartItems;

    // Calculate the total dynamically
    double total = cartItems.fold(0, (sum, item) {
      return sum + (item.price * item.quantity);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                icon: Icon(Icons.arrow_back)),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Text(
                'Cart',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Expanded(
              child: cartItems.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => HomeScreen()),
                        //       );
                        //     },
                        //     icon: Padding(
                        //       padding: const EdgeInsets.all(15.0),
                        //       child: Icon(Icons.arrow_back),
                        //     )),
                        // Center(child: Text('Your cart is empty')),
                      ],
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        // Ensure dropdownValue is not null by using item.quantity (defaults to 1 if null)
                        int dropdownValue = item.quantity ?? 1;

                        // Calculate subtotal for each item
                        double itemSubtotal = item.price * dropdownValue;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: BeveledRectangleBorder(),
                              child: Row(
                                children: [
                                  Image.network(
                                    item.image,
                                    height: 150,
                                    width: 90,
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 30)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.category == "men's clothing"
                                            ? "Men t-shirt"
                                            : "Women t-shirt",
                                        style: TextStyle(
                                            fontSize: item.category ==
                                                    "men's clothing"
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06),
                                      ),
                                      Text(
                                        '\$${item.price.toString()}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: const Color.fromARGB(
                                                255, 68, 74, 255)),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Qty:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownButton<int>(
                                              iconEnabledColor: Colors.black,
                                              value: dropdownValue,
                                              icon: Icon(Icons.arrow_downward),
                                              elevation: 16,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                              items: list
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text(
                                                      value.toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                    ));
                                              }).toList(),
                                              onChanged: (int? value) {
                                                setState(() {
                                                  if (value != null) {
                                                    // Update the item quantity when dropdown value changes
                                                    item.quantity = value;

                                                    // Notify CartProvider about the change
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .updateItemQuantity(
                                                            item);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.09),
                                    child: IconButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .removeFromCart(item);
                                        },
                                        color: const Color.fromARGB(
                                            255, 255, 17, 0),
                                        iconSize: 40,
                                        icon: Icon(Icons.delete)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cartItems.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Total: \$${total.toStringAsFixed(2)}", // Show the final total
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 0, 234, 255)),
                      child: Text('Place Order'))
                ])
          ],
        ),
      ),
    );
  }
}
