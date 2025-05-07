import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class ShopItem {
  final String name;
  final double price;
  final String image;

  ShopItem({required this.name, required this.price, required this.image});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE FRUIT SHOP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const ShopPage(),
    );
  }
}

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<ShopItem> items = [
    ShopItem(name: 'Apples', price: 1.99, image: 'assets/apples.png'),
    ShopItem(name: 'Bananas', price: 0.99, image: 'assets/bananas.png'),
    ShopItem(name: 'Oranges', price: 2.49, image: 'assets/oranges.png'),
    ShopItem(name: 'Pineapples', price: 3.99, image: 'assets/pineapples.png'),
  ];

  final Map<ShopItem, int> cart = {};

  double get totalPrice => cart.entries.fold(
      0.0, (sum, entry) => sum + entry.key.price * entry.value);

  void addToCart(ShopItem item) {
    setState(() {
      cart.update(item, (value) => value + 1, ifAbsent: () => 1);
    });

    Fluttertoast.showToast(
      msg: "${item.name} added to cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });

    Fluttertoast.showToast(
      msg: "Cart cleared",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void openDetailPage(ShopItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          item: item,
          onAdd: () => addToCart(item),
        ),
      ),
    );
  }

  void openSummaryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('THE FRUIT SHOP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: openSummaryPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              padding: const EdgeInsets.all(8),
              children: items.map((item) {
                return GestureDetector(
                  onTap: () => openDetailPage(item),
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('\$${item.price.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => addToCart(item),
                          child: const Text('Add'),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.teal.shade100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items: ${cart.values.fold(0, (a, b) => a + b)}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: clearCart,
                  child: const Text("Clear Cart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final ShopItem item;
  final VoidCallback onAdd;

  const DetailPage({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(item.image,
                  width: double.infinity, height: 250, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),
            Text(
              item.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                onAdd();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final Map<ShopItem, int> cart;

  const SummaryPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final total = cart.entries.fold(
        0.0, (sum, entry) => sum + entry.key.price * entry.value);

    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: cart.entries.map((entry) {
                  return ListTile(
                    leading: Image.asset(entry.key.image, width: 50),
                    title: Text(entry.key.name),
                    subtitle: Text(
                        '${entry.value} x \$${entry.key.price.toStringAsFixed(2)}'),
                    trailing: Text(
                        '\$${(entry.key.price * entry.value).toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}