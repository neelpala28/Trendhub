import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendhub/data/providers/cart_provider.dart';
import '../../data/models/clothing_item.dart';

class DisplayItem extends StatelessWidget {
  final ClothingItem item;

  const DisplayItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                item.image,
                height: 350,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Category: ${item.category}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Show a SnackBar to notify the user
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to cart')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.44,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: BeveledRectangleBorder(),
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Your Order will be at your doorsteps soon'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.44,
                            MediaQuery.of(context).size.height * 0.08),
                        shape: BeveledRectangleBorder(),
                        backgroundColor: const Color.fromARGB(255, 0, 140, 255),
                        foregroundColor: Colors.white),
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
