import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  // Item quantities
  int pulloverQty = 1;
  int tShirtQty = 1;
  int sportDressQty = 1;

  // Item prices
  final int pulloverPrice = 51;
  final int tShirtPrice = 30;
  final int sportDressPrice = 43;

  // Calculate total amount
  int getTotalAmount() {
    return (pulloverQty * pulloverPrice) +
        (tShirtQty * tShirtPrice) +
        (sportDressQty * sportDressPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bag", style: TextStyle(fontWeight: FontWeight.bold),),
        //backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pullover Item
            buildCartItem("Pullover", "Black", "L", pulloverQty, pulloverPrice,
                'assests/img.png', () {
                  setState(() {
                    pulloverQty++;
                  });
                }, () {
                  setState(() {
                    if (pulloverQty > 1) pulloverQty--;
                  });
                }),

            // T-Shirt Item
            buildCartItem(
                "T-Shirt", "Gray", "L", tShirtQty, tShirtPrice, 'assests/img_1.png', () {
              setState(() {
                tShirtQty++;
              });
            }, () {
              setState(() {
                if (tShirtQty > 1) tShirtQty--;
              });
            }),

            // Sport Dress Item
            buildCartItem("Sport Dress", "Black", "M", sportDressQty,
                sportDressPrice, 'assests/img_2.png', () {
                  setState(() {
                    sportDressQty++;
                  });
                }, () {
                  setState(() {
                    if (sportDressQty > 1) sportDressQty--;
                  });
                }),

            const Spacer(),
            // Total amount and checkout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total amount:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${getTotalAmount()}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                // Show a Snackbar with a congratulatory message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Congratulations! Checkout successful."),
                  ),
                );
              },
              child: const Text(
                "CHECK OUT",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each cart item with image
  Widget buildCartItem(String name, String color, String size, int quantity,
      int price, String imagePath, VoidCallback onIncrease, VoidCallback onDecrease) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Image of the product
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Color: $color  Size: $size"),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: onDecrease,
                  ),
                  Text("$quantity"),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: onIncrease,
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(
          //   width: 115, //
          // ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.,
            children: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert), // The three dots icon
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    //value: 'Settings',
                    child: Text('Delete'),
                  ),
                  const PopupMenuItem<String>(
                    //value: 'About',
                    child: Text('Move to wishlist'),
                  ),
                ],
              ),
              Text("\$${price * quantity}"),
            ],
          )
        ],
      ),
    );
  }
}
