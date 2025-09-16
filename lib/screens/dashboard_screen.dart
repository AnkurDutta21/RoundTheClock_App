import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui; // Import for blur effect
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/cart_item.dart';
import '../widgets/animated_button.dart';
import '../constants/design_tokens.dart';
import 'about_us_screen.dart' as profile;

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({super.key});

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  // Professional dark red color scheme
  static const Color primaryDarkRed = Color(0xFF8B0000);

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
                    // Enhanced header section with accessibility
                    Semantics(
                      header: true,
                      label:
                          'App header with user greeting and navigation buttons',
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: DesignTokens.spacingSm,
                        ),
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
                                      fontSize: DesignTokens.fontSizeMd,
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight:
                                          DesignTokens.fontWeightRegular,
                                    ),
                                  ),
                                  SizedBox(height: DesignTokens.spacingXs),
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
                                Semantics(
                                  button: true,
                                  label: 'Notifications',
                                  hint: 'Tap to view notifications',
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      DesignTokens.spacingMd,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                        DesignTokens.opacityMedium,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        DesignTokens.radiusMd,
                                      ),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(
                                          DesignTokens.opacityHigh,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                      size: DesignTokens.fontSizeXxl,
                                    ),
                                  ),
                                ),
                                SizedBox(width: DesignTokens.spacingMd),
                                Semantics(
                                  button: true,
                                  label:
                                      'User profile picture, tap to view profile',
                                  hint: 'Opens user profile screen',
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      DesignTokens.radiusMd,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const profile.AboutUsScreen(),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(
                                        DesignTokens.radiusMd,
                                      ),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            DesignTokens.radiusMd,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              DesignTokens.opacityHigh,
                                            ),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                DesignTokens.opacityLow,
                                              ),
                                              blurRadius:
                                                  DesignTokens.elevationMd,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            DesignTokens.radiusMd - 2,
                                          ),
                                          child: Image.asset(
                                            'assets/images/logo.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Enhanced search bar with accessibility
                    SizedBox(height: DesignTokens.spacingXxl),

                    Semantics(
                      label: 'Search and filter section',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusXxl,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x14000000),
                              blurRadius: DesignTokens.elevationMd,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Semantics(
                                textField: true,
                                label: 'Search for food',
                                hint: 'Enter food name or cuisine type',
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      DesignTokens.radiusXxl,
                                    ),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: DesignTokens.fontSizeMd,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search for food...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: DesignTokens.fontSizeMd,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey[600],
                                        size: DesignTokens.fontSizeXxl,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: DesignTokens.spacingLg,
                                            vertical: DesignTokens.spacingMd,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: DesignTokens.spacingMd),
                            Semantics(
                              button: true,
                              label: 'Filter options',
                              hint: 'Tap to open filter menu',
                              child: Container(
                                padding: const EdgeInsets.all(
                                  DesignTokens.spacingMd,
                                ),
                                decoration: BoxDecoration(
                                  gradient: DesignTokens.primaryGradient,
                                  borderRadius: BorderRadius.circular(
                                    DesignTokens.radiusXxl,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(
                                        DesignTokens.opacityMedium,
                                      ),
                                      blurRadius: DesignTokens.elevationMd,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                  size: DesignTokens.fontSizeXxl,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Enhanced quick actions section with accessibility
                    Semantics(
                      header: true,
                      label: 'Quick Actions section',
                      child: const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.25,
                          height: 1.3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Enhanced quick action buttons with animations
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: DesignTokens.spacingMd,
                            mainAxisSpacing: DesignTokens.spacingMd,
                            childAspectRatio: 0.9,
                          ),
                      itemCount: quickActions.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          delay: Duration(milliseconds: index * 100),
                          semanticLabel:
                              'Quick action: ${quickActions[index]['name']}',
                          child: AnimatedButton(
                            semanticLabel: quickActions[index]['name'],
                            tooltip:
                                'Tap to access ${quickActions[index]['name']}',
                            onPressed: () {
                              // Handle tap based on action type
                              if (quickActions[index]['name'] == 'Favorites') {
                                Navigator.pushNamed(context, '/favorites');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${quickActions[index]['name']} tapped',
                                    ),
                                    duration:
                                        DesignTokens.animationDurationNormal,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    quickActions[index]['color'],
                                    quickActions[index]['color'].withOpacity(
                                      0.8,
                                    ),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusLg,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: quickActions[index]['color']
                                        .withOpacity(
                                          DesignTokens.opacityMedium,
                                        ),
                                    blurRadius: DesignTokens.elevationMd,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    quickActions[index]['icon'],
                                    color: Colors.white,
                                    size: DesignTokens.fontSizeXxl,
                                  ),
                                  SizedBox(height: DesignTokens.spacingXs),
                                  Text(
                                    quickActions[index]['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: DesignTokens.fontSizeXs,
                                      fontWeight:
                                          DesignTokens.fontWeightSemiBold,
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

                    // Enhanced special offers section with accessibility
                    Semantics(
                      header: true,
                      label: 'Special Offers carousel',
                      child: const Text(
                        'Special Offers',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
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
                        Semantics(
                          header: true,
                          label: 'Food Categories',
                          child: const Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
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
                        Semantics(
                          header: true,
                          label: 'Featured Items grid',
                          child: const Text(
                            'Featured Items',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
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

                    SizedBox(
                      height: DesignTokens.spacingSm,
                    ), // Reduced spacing before grid for larger images
                    // Enhanced featured items grid with animations - optimized for larger images
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            DesignTokens.spacingSm, // Reduced spacing
                        mainAxisSpacing:
                            DesignTokens.spacingSm, // Reduced spacing
                        childAspectRatio:
                            0.85, // Increased to make cards taller (more image space)
                      ),
                      itemCount: featuredItems.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          delay: Duration(milliseconds: index * 150),
                          semanticLabel:
                              'Featured item: ${featuredItems[index]['name']}, ${featuredItems[index]['description']}, priced at ${featuredItems[index]['price']}, rated ${featuredItems[index]['rating']} stars',
                          child: AnimatedButton(
                            semanticLabel:
                                'View details for ${featuredItems[index]['name']}',
                            tooltip:
                                'Tap to view ${featuredItems[index]['name']} details',
                            onPressed: () {
                              // Navigate to item detail screen
                              Navigator.pushNamed(
                                context,
                                '/item_detail',
                                arguments: {
                                  'item': featuredItems[index],
                                  'itemId':
                                      '${featuredItems[index]['name'].toLowerCase().replaceAll(' ', '_')}_$index',
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusLg,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      DesignTokens.opacityLow,
                                    ),
                                    blurRadius: DesignTokens.elevationLg,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
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
                                                  Colors.black.withOpacity(
                                                    DesignTokens.opacityLow,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Rating badge
                                          Positioned(
                                            top: DesignTokens.spacingMd,
                                            right: DesignTokens.spacingMd,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal:
                                                        DesignTokens.spacingSm,
                                                    vertical:
                                                        DesignTokens.spacingXs,
                                                  ),
                                              decoration: BoxDecoration(
                                                gradient: DesignTokens
                                                    .primaryGradient,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      DesignTokens.radiusMd,
                                                    ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.orange
                                                        .withOpacity(
                                                          DesignTokens
                                                              .opacityMedium,
                                                        ),
                                                    blurRadius: DesignTokens
                                                        .elevationMd,
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
                                                    size:
                                                        DesignTokens.fontSizeSm,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        DesignTokens.spacingXs,
                                                  ),
                                                  Text(
                                                    featuredItems[index]['rating']
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: DesignTokens
                                                          .fontSizeXs,
                                                      fontWeight: DesignTokens
                                                          .fontWeightBold,
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
                                  // Enhanced item details - reduced padding for larger images
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      DesignTokens
                                          .spacingSm, // Reduced from spacingMd to spacingSm
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          featuredItems[index]['name'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                                DesignTokens.fontWeightBold,
                                            fontSize: DesignTokens
                                                .fontSizeSm, // Slightly smaller font
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: DesignTokens.spacingXs,
                                        ),
                                        Text(
                                          featuredItems[index]['description'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: DesignTokens.fontSizeXs,
                                            height: 1.2, // Tighter line height
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: DesignTokens
                                              .spacingSm, // Reduced spacing
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                featuredItems[index]['price'],
                                                style: TextStyle(
                                                  color: Colors.orange[600],
                                                  fontWeight: DesignTokens
                                                      .fontWeightBold,
                                                  fontSize:
                                                      DesignTokens.fontSizeMd,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Favorites button - smaller size
                                                Consumer<FavoritesProvider>(
                                                  builder:
                                                      (
                                                        context,
                                                        favoritesProvider,
                                                        child,
                                                      ) {
                                                        final item =
                                                            featuredItems[index];
                                                        final itemId =
                                                            '${item['name'].toLowerCase().replaceAll(' ', '_')}_$index';
                                                        final isFavorite =
                                                            favoritesProvider
                                                                .isFavorite(
                                                                  itemId,
                                                                );

                                                        return Semantics(
                                                          button: true,
                                                          label: isFavorite
                                                              ? 'Remove ${item['name']} from favorites'
                                                              : 'Add ${item['name']} to favorites',
                                                          child: IconButton(
                                                            onPressed: () {
                                                              HapticFeedback.lightImpact();

                                                              final cartItem = CartItem(
                                                                id: itemId,
                                                                name:
                                                                    item['name'],
                                                                description:
                                                                    item['description'],
                                                                price: double.parse(
                                                                  item['price']
                                                                      .replaceAll(
                                                                        'Rs ',
                                                                        '',
                                                                      ),
                                                                ),
                                                                image:
                                                                    item['image'],
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
                                                                        Colors
                                                                            .red
                                                                            .shade600,
                                                                    duration:
                                                                        const Duration(
                                                                          seconds:
                                                                              2,
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
                                                                    backgroundColor:
                                                                        Colors
                                                                            .pink
                                                                            .shade600,
                                                                    duration:
                                                                        const Duration(
                                                                          seconds:
                                                                              2,
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
                                                                  ? Icons
                                                                        .favorite
                                                                  : Icons
                                                                        .favorite_border,
                                                              color: isFavorite
                                                                  ? Colors.red
                                                                  : Colors
                                                                        .grey[600],
                                                              size: DesignTokens
                                                                  .fontSizeMd,
                                                            ),
                                                            tooltip: isFavorite
                                                                ? 'Remove from favorites'
                                                                : 'Add to favorites',
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  DesignTokens
                                                                      .spacingXs,
                                                                ),
                                                            constraints:
                                                                const BoxConstraints(),
                                                          ),
                                                        );
                                                      },
                                                ),
                                                // Add to cart button - smaller size
                                                Consumer<CartProvider>(
                                                  builder: (context, cartProvider, child) {
                                                    final item =
                                                        featuredItems[index];
                                                    final itemId =
                                                        '${item['name'].toLowerCase().replaceAll(' ', '_')}_$index';
                                                    final isInCart =
                                                        cartProvider.isInCart(
                                                          itemId,
                                                        );

                                                    return AnimatedElevatedButton(
                                                      onPressed: () {
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
                                                              style: const TextStyle(
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
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.orange[600],
                                                        foregroundColor:
                                                            Colors.white,
                                                        padding:
                                                            const EdgeInsets.all(
                                                              DesignTokens
                                                                  .spacingXs,
                                                            ),
                                                        minimumSize: const Size(
                                                          DesignTokens
                                                                  .minTouchTarget *
                                                              0.8,
                                                          DesignTokens
                                                                  .minTouchTarget *
                                                              0.8,
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                DesignTokens
                                                                    .radiusMd,
                                                              ),
                                                        ),
                                                      ),
                                                      semanticLabel:
                                                          'Add ${item['name']} to cart',
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: DesignTokens
                                                            .fontSizeMd,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
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
