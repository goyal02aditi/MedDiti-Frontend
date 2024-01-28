import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Medicine({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class ShoppingCart {
  final List<Medicine> items = [];

  void addToCart(Medicine medicine) {
    items.add(medicine);
  }
}

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Shop',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MedicineShopPage(),
    );
  }
}

class MedicineShopPage extends StatefulWidget {
  const MedicineShopPage({super.key});

  @override
  _MedicineShopPageState createState() => _MedicineShopPageState();
}

class _MedicineShopPageState extends State<MedicineShopPage> {
  int _cartItemCount = 0; // Track the number of items in the cart
  final ShoppingCart cart = ShoppingCart();

  List<Medicine> medicines = [
    Medicine(
      name: 'Dolo 650 Tablet',
      description: 'Common painkiller for treating aches and pains',
      price: 29.9,
      imageUrl: 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/mu5bahqxfrp28cut6que.jpg',
    ),
    Medicine(
      name: 'Aspirin',
      description: 'Pain reliever and fever reducer',
      price: 496.65,
      imageUrl: 'https://www.medischevakhandel.nl/public/data/image/article/6660/17206/large/aspirine-500-mg-20-tabletten.jpg',
    ),
    Medicine(
      name: 'Ibuprofen',
      description: 'Anti-inflammatory and pain reliever',
      price: 49,
      imageUrl: 'https://5.imimg.com/data5/SELLER/Default/2023/7/325863554/WI/JM/SY/135658020/ibuprofen-tablets-ip-200-mg--500x500.jpg',
    ),
    // Add more medicines as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Shop'),
        actions: [
          BadgeIconButton(
            icon: Icons.shopping_cart,
            badgeContent: _cartItemCount > 0 ? _cartItemCount.toString() : null,
            onPressed: () {
              // Navigate to the cart page or show the cart details
              // Add your logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          Medicine medicine = medicines[index];
          return MedicineCard(
            medicine: medicine,
            onAddToCart: () {
              setState(() {
                cart.addToCart(medicine);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${medicine.name} added to cart')),
              );
            },
          );
        },
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onAddToCart;

  MedicineCard({required this.medicine, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(
            medicine.imageUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  medicine.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${medicine.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onAddToCart,
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BadgeIconButton extends StatelessWidget {
  final IconData icon;
  final String? badgeContent;
  final VoidCallback onPressed;

  BadgeIconButton({
    required this.icon,
    required this.onPressed,
    this.badgeContent,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          Icon(icon),
          if (badgeContent != null && badgeContent!.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  badgeContent!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}