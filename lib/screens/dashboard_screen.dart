import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui; // Import for blur effect
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({super.key});

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  // Professional dark red color scheme
  static const Color primaryDarkRed = Color(0xFF8B0000);
  static const Color accentRed = Color(0xFFB71C1C);
  static const Color lightRed = Color(0xFFD32F2F);

  // Sample data for featured categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Burgers', 'icon': Icons.fastfood, 'color': Colors.orange},
    {'name': 'Pizza', 'icon': Icons.local_pizza, 'color': Colors.red},
    {'name': 'Drinks', 'icon': Icons.local_bar, 'color': Colors.blue},
    {'name': 'Desserts', 'icon': Icons.cake, 'color': Colors.pink},
    {'name': 'Salads', 'icon': Icons.eco, 'color': Colors.green},
    {'name': 'Pasta', 'icon': Icons.restaurant, 'color': Colors.purple},
  ];

  // Sample data for featured menu items
  final List<Map<String, dynamic>> featuredItems = [
    {
      'name': 'Cheeseburger',
      'description': 'Juicy beef patty with cheese and special sauce',
      'price': 'Rs 5.99',
      'image': 'assets/images/hero-food2.jpg',
      'rating': 4.8,
    },
    {
      'name': 'Margherita Pizza',
      'description': 'Classic tomato, mozzarella, and fresh basil',
      'price': 'Rs 8.99',
      'image': 'assets/images/hero-food4.jpg',
      'rating': 4.9,
    },
    {
      'name': 'Caesar Salad',
      'description': 'Fresh romaine lettuce with caesar dressing',
      'price': 'Rs 6.99',
      'image': 'assets/images/hero-food3.jpg',
      'rating': 4.7,
    },
    {
      'name': 'Chocolate Cake',
      'description': 'Rich chocolate dessert with berries',
      'price': 'Rs 4.99',
      'image': 'assets/images/the-cake-427920_1280.jpg',
      'rating': 4.9,
    },
  ];

  // Sample data for quick action buttons
  final List<Map<String, dynamic>> quickActions = [
    {
      'name': 'My Orders',
      'icon': Icons.shopping_bag_outlined,
      'color': Colors.blue[600],
    },
    {
      'name': 'Favorites',
      'icon': Icons.favorite_outline,
      'color': Colors.red[600],
    },
    {
      'name': 'Coupons',
      'icon': Icons.local_offer_outlined,
      'color': Colors.green[600],
    },
    {
      'name': 'Profile',
      'icon': Icons.person_outline,
      'color': Colors.purple[600],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryDarkRed,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 0, // Hide default app bar since we have custom header
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for the dashboard
          Image.asset('assets/images/background splash.png', fit: BoxFit.cover),

          // Optimized blur effect for better performance
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // Dashboard content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced header section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'User',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    'assets/images/logo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Enhanced search bar
                    const SizedBox(height: 30),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000), // Optimized color
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search for food...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange[600]!,
                                  Colors.orange[400]!,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Enhanced quick actions section
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.25,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Enhanced quick action buttons
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                      itemCount: quickActions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                quickActions[index]['color'],
                                quickActions[index]['color'].withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: quickActions[index]['color'].withOpacity(
                                  0.3,
                                ),
                                blurRadius:
                                    8, // Reduced blur radius for performance
                                offset: const Offset(
                                  0,
                                  2,
                                ), // Reduced offset for performance
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                // Handle tap
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    quickActions[index]['icon'],
                                    color: Colors.white,
                                    size: 28, // Slightly reduced icon size
                                  ),
                                  const SizedBox(height: 6), // Reduced spacing
                                  Text(
                                    quickActions[index]['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          11, // Slightly reduced font size
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Enhanced special offers section
                    const Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Optimized carousel for better performance
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayInterval: const Duration(
                          seconds: 6,
                        ), // Increased interval
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        padEnds: false,
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 600, // Faster animation
                        ),
                        autoPlayCurve: Curves.linear, // Smoother curve
                      ),
                      items:
                          [
                            'assets/images/logo.jpg',
                            'assets/images/hero-food2.jpg',
                            'assets/images/hero-food4.jpg',
                            'assets/images/hero-food3.jpg',
                          ].map((imagePath) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10, // Reduced blur radius
                                    offset: const Offset(
                                      0,
                                      5,
                                    ), // Reduced offset
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    // Optimized image loading with caching
                                    Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                      cacheWidth:
                                          400, // Cache at reasonable size
                                      cacheHeight: 200,
                                      filterQuality: FilterQuality
                                          .low, // Better performance
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.3),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 30),

                    // Enhanced categories section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // View all categories
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.orange[300],
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Enhanced category list
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 85,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  categories[index]['color'],
                                  categories[index]['color'].withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: categories[index]['color'].withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  // Handle category tap
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      categories[index]['icon'],
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      categories[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Enhanced featured items section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured Items',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // View all items
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.orange[300],
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Enhanced featured items grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: featuredItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                // Handle item tap
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Enhanced item image
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            featuredItems[index]['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          // Gradient overlay
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.1),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Rating badge
                                          Positioned(
                                            top: 12,
                                            right: 12,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.orange[600]!,
                                                    Colors.orange[400]!,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.orange
                                                        .withOpacity(0.3),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    featuredItems[index]['rating']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Enhanced item details
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          featuredItems[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          featuredItems[index]['description'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                            height: 1.3,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              featuredItems[index]['price'],
                                              style: TextStyle(
                                                color: Colors.orange[600],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Consumer<CartProvider>(
                                              builder: (context, cartProvider, child) {
                                                final item =
                                                    featuredItems[index];
                                                final itemId =
                                                    '${item['name'].toLowerCase().replaceAll(' ', '_')}_$index';
                                                final isInCart = cartProvider
                                                    .isInCart(itemId);
                                                final quantity = cartProvider
                                                    .getItemQuantity(itemId);

                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.orange[600]!,
                                                        Colors.orange[400]!,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.orange
                                                            .withOpacity(0.3),
                                                        blurRadius: 8,
                                                        offset: const Offset(
                                                          0,
                                                          2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Add haptic feedback
                                                      HapticFeedback.lightImpact();

                                                      // Create cart item
                                                      final cartItem = CartItem(
                                                        id: itemId,
                                                        name: item['name'],
                                                        description:
                                                            item['description'],
                                                        price: double.parse(
                                                          item['price']
                                                              .replaceAll(
                                                                'Rs ',
                                                                '',
                                                              ),
                                                        ),
                                                        image: item['image'],
                                                      );

                                                      // Add to cart
                                                      cartProvider.addToCart(
                                                        cartItem,
                                                      );

                                                      // Show success message
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            '${item['name']} added to cart!',
                                                            style:
                                                                const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          backgroundColor:
                                                              Colors
                                                                  .green
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
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    child: Icon(
                                                      isInCart
                                                          ? Icons
                                                                .add_shopping_cart
                                                          : Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 100,
                    ), // Extra space for bottom navigation
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // REMOVED: bottomNavigationBar - MainDashboard will handle this
    );
  }
}
