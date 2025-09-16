import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Import for blur effect
import 'package:flutter/services.dart'; // Import for HapticFeedback
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/cart_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Sample data for categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Pizzas', 'icon': Icons.local_pizza, 'color': Colors.red},
    {'name': 'Burgers', 'icon': Icons.fastfood, 'color': Colors.orange},
    {'name': 'Desserts', 'icon': Icons.cake, 'color': Colors.pink},
    {'name': 'Drinks', 'icon': Icons.local_bar, 'color': Colors.blue},
    {'name': 'Salads', 'icon': Icons.eco, 'color': Colors.green},
    {'name': 'Pasta', 'icon': Icons.restaurant, 'color': Colors.purple},
  ];

  // Sample data for popular items
  final List<Map<String, dynamic>> popularItems = [
    {
      'name': 'Margherita Pizza',
      'description': 'Classic tomato, mozzarella, and fresh basil',
      'price': 'Rs 12.99',
      'image': 'assets/images/hero-food4.jpg',
      'rating': 4.8,
    },
    {
      'name': 'Cheeseburger',
      'description': 'Juicy beef patty with cheese and special sauce',
      'price': 'Rs 8.99',
      'image': 'assets/images/hero-food2.jpg',
      'rating': 4.7,
    },
    {
      'name': 'Chocolate Cake',
      'description': 'Rich chocolate dessert with berries',
      'price': 'Rs 6.99',
      'image': 'assets/images/the-cake-427920_1280.jpg',
      'rating': 4.9,
    },
    {
      'name': 'Caesar Salad',
      'description': 'Fresh romaine lettuce with caesar dressing',
      'price': 'Rs 9.99',
      'image': 'assets/images/hero-food3.jpg',
      'rating': 4.6,
    },
    {
      'name': 'Pepperoni Pizza',
      'description': 'Classic pizza with pepperoni and mozzarella',
      'price': 'Rs 14.99',
      'image': 'assets/images/hero-food4.jpg',
      'rating': 4.9,
    },
    {
      'name': 'Veggie Burger',
      'description': 'Plant-based patty with fresh vegetables',
      'price': 'Rs 7.99',
      'image': 'assets/images/hero-food2.jpg',
      'rating': 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.25,
          ),
        ),
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for the menu screen
          Image.asset('assets/images/background splash.png', fit: BoxFit.cover),

          // Optimized blur effect for better performance
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // Menu content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for food...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Categories title
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Changed to white for better visibility
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Categories grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12, // Reduced spacing
                          mainAxisSpacing: 12, // Reduced spacing
                          childAspectRatio: 1.1, // Adjusted ratio
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: categories[index]['color'],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: categories[index]['color'].withOpacity(
                                0.3,
                              ),
                              blurRadius:
                                  8, // Reduced blur radius for performance
                              offset: const Offset(
                                0,
                                3,
                              ), // Reduced offset for performance
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categories[index]['icon'],
                              color: Colors.white,
                              size: 36, // Reduced icon size
                            ),
                            const SizedBox(height: 8), // Reduced spacing
                            Text(
                              categories[index]['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13, // Reduced font size
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // Popular items title
                  const Text(
                    'Popular Items',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Changed to white for better visibility
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Popular items list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: popularItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigate to item detail screen
                          Navigator.pushNamed(
                            context,
                            '/item_detail',
                            arguments: {
                              'item': popularItems[index],
                              'itemId':
                                  '${popularItems[index]['name'].toLowerCase().replaceAll(' ', '_')}_${index + 10}',
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Item image with add button
                              Stack(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                            left: Radius.circular(15),
                                          ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          popularItems[index]['image'],
                                        ),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.medium,
                                      ),
                                    ),
                                  ),
                                  // Action buttons stack
                                  Positioned(
                                    bottom: 6,
                                    right: 6,
                                    child: Column(
                                      children: [
                                        // Favorites button
                                        Consumer<FavoritesProvider>(
                                          builder: (context, favoritesProvider, child) {
                                            final item = popularItems[index];
                                            final itemId =
                                                '${item['name'].toLowerCase().replaceAll(' ', '_')}_${index + 10}';
                                            final isFavorite = favoritesProvider
                                                .isFavorite(itemId);

                                            return Container(
                                              width: 28,
                                              height: 28,
                                              margin: const EdgeInsets.only(
                                                bottom: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isFavorite
                                                    ? Colors.pink.shade600
                                                    : Colors.white.withOpacity(
                                                        0.9,
                                                      ),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  HapticFeedback.lightImpact();

                                                  final cartItem = CartItem(
                                                    id: itemId,
                                                    name: item['name'],
                                                    description:
                                                        item['description'],
                                                    price: double.parse(
                                                      item['price'].replaceAll(
                                                        'Rs ',
                                                        '',
                                                      ),
                                                    ),
                                                    image: item['image'],
                                                  );

                                                  if (isFavorite) {
                                                    favoritesProvider
                                                        .removeFromFavorites(
                                                          itemId,
                                                        );
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${item['name']} removed from favorites',
                                                        ),
                                                        backgroundColor:
                                                            Colors.red.shade600,
                                                        duration:
                                                            const Duration(
                                                              seconds: 2,
                                                            ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    favoritesProvider
                                                        .addToFavorites(
                                                          cartItem,
                                                        );
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${item['name']} added to favorites!',
                                                        ),
                                                        backgroundColor: Colors
                                                            .pink
                                                            .shade600,
                                                        duration:
                                                            const Duration(
                                                              seconds: 2,
                                                            ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                icon: Icon(
                                                  isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: isFavorite
                                                      ? Colors.white
                                                      : Colors.grey[600],
                                                  size: 16,
                                                ),
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                    const BoxConstraints(),
                                                tooltip: isFavorite
                                                    ? 'Remove from favorites'
                                                    : 'Add to favorites',
                                              ),
                                            );
                                          },
                                        ),
                                        // Add to cart button
                                        Consumer<CartProvider>(
                                          builder: (context, cartProvider, child) {
                                            final item = popularItems[index];
                                            final itemId =
                                                '${item['name'].toLowerCase().replaceAll(' ', '_')}_${index + 10}';
                                            final isInCart = cartProvider
                                                .isInCart(itemId);

                                            return Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade600,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  HapticFeedback.lightImpact();

                                                  final cartItem = CartItem(
                                                    id: itemId,
                                                    name: item['name'],
                                                    description:
                                                        item['description'],
                                                    price: double.parse(
                                                      item['price'].replaceAll(
                                                        'Rs ',
                                                        '',
                                                      ),
                                                    ),
                                                    image: item['image'],
                                                  );

                                                  cartProvider.addToCart(
                                                    cartItem,
                                                  );

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        '${item['name']} added to cart!',
                                                      ),
                                                      backgroundColor:
                                                          Colors.green.shade600,
                                                      duration: const Duration(
                                                        seconds: 2,
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  isInCart
                                                      ? Icons.add_shopping_cart
                                                      : Icons.add,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                    const BoxConstraints(),
                                                tooltip: 'Add to cart',
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Item details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        popularItems[index]['name'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        popularItems[index]['description'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            popularItems[index]['price'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF8B0000),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                popularItems[index]['rating']
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
