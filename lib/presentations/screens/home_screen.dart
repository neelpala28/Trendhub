import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trendhub/data/models/clothing_item.dart';
import 'package:trendhub/presentations/screens/display_item.dart';
import 'package:trendhub/presentations/screens/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<ClothingItem>> fetchClothingData() async {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((item) => ClothingItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color.fromARGB(255, 140, 231, 215),
        ),
        drawer: UserDrawer(),
        backgroundColor: const Color.fromARGB(255, 234, 233, 233),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      // enabled: false,
                      hintText: 'Search Your Product',
                      hintStyle: TextStyle(
                        height: 1,
                        color: Colors.grey,
                        fontSize: 19,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                        color: Color.fromARGB(255, 123, 122, 122),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 54, 53, 53),
                          ),
                          Shadow(
                            blurRadius: 0,
                            color: Color.fromARGB(124, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: TextButton(
                      onPressed: () {
                        TextButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.01,
                                MediaQuery.of(context).size.height * 0.001),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)));
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:
                                const Color.fromARGB(255, 85, 130, 255),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.35,
                                MediaQuery.of(context).size.height * 0.09),
                            foregroundColor:
                                const Color.fromARGB(255, 0, 0, 0)),
                        child: Text(
                          'Woman',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:
                                const Color.fromARGB(221, 255, 54, 54),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.35,
                                MediaQuery.of(context).size.height * 0.09),
                            foregroundColor: Colors.black),
                        child: Text(
                          'Man',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor:
                              const Color.fromARGB(221, 131, 255, 54),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.35,
                              MediaQuery.of(context).size.height * 0.09),
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                          'kids',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Featured',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 54, 53, 53),
                          ),
                          Shadow(
                            blurRadius: 0,
                            color: Color.fromARGB(124, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130),
                    child: TextButton(
                      onPressed: () {
                        TextButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.01,
                                MediaQuery.of(context).size.height * 0.001),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)));
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width * 1,
                  child: FutureBuilder(
                    future: fetchClothingData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data found'));
                      } else {
                        final ClothingItems = snapshot.data!
                            .where((item) =>
                                item.category == "men's clothing" ||
                                item.category ==
                                    "women's clothing") // Add your condition here
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ClothingItems.length,
                            itemBuilder: (context, index) {
                              final item = ClothingItems[index];

                              return Card(
                                elevation: 1,
                                borderOnForeground: false,
                                margin: EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    print('Tapped item: ${item.title}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DisplayItem(
                                                  item: item,
                                                )));
                                    print(item.id);
                                  },
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          item.image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.17,
                                          width: 110,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item.title.length > 12
                                              ? '${item.title.substring(0, 12)}...'
                                              : item.title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      'Best Sell',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 54, 53, 53),
                          ),
                          Shadow(
                            blurRadius: 0,
                            color: Color.fromARGB(124, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 1,
                  child: FutureBuilder<List<ClothingItem>>(
                      future: fetchClothingData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No data found'));
                        } else {
                          final ClothingItems = snapshot.data!
                              .where((item) =>
                                  item.price > 25 &&
                                      item.category == "men's clothing" ||
                                  item.price > 25 &&
                                      item.category == "women's clothing")
                              .toList();
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ClothingItems.length,
                              itemBuilder: (context, index) {
                                final item = ClothingItems[index];

                                return Card(
                                  elevation: 1,
                                  borderOnForeground: false,
                                  margin: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Tapped item: ${item.title}');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DisplayItem(
                                                    item: item,
                                                  )));
                                      print(item.id);
                                    },
                                    child: Container(
                                      width: 150,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            item.image,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            width: 110,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item.title.length > 12
                                                ? '${item.title.substring(0, 12)}...'
                                                : item.title,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '\$${item.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
