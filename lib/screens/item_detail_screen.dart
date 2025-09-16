import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/cart_item.dart';
import '../constants/design_tokens.dart';

class ItemDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final String itemId;

  const ItemDetailScreen({super.key, required this.item, required this.itemId});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _quantity = 1;

  // Professional dark red color scheme
  static const Color primaryDarkRed = Color(0xFF8B0000);
  static const Color accentRed = Color(0xFFB71C1C);

  // Sample nutritional data
  final Map<String, dynamic> nutritionalInfo = {
    'calories': '450 kcal',
    'protein': '25g',
    'carbs': '35g',
    'fat': '20g',
    'fiber': '5g',
  };

  // Sample reviews
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Sarah Johnson',
      'rating': 5,
      'comment': 'Absolutely delicious! The flavors are perfectly balanced.',
      'date': '2 days ago',
    },
    {
      'name': 'Mike Chen',
      'rating': 4,
      'comment': 'Great taste and good portion size. Will order again!',
      'date': '1 week ago',
    },
    {
      'name': 'Emma Davis',
      'rating': 5,
      'comment': 'Best burger I\'ve had in a long time. Highly recommended!',
      'date': '2 weeks ago',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: DesignTokens.animationDurationNormal,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animation
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDarkRed,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.item['name'],
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg,
            fontWeight: DesignTokens.fontWeightSemiBold,
            letterSpacing: -0.25,
          ),
        ),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isFavorite(widget.itemId);

              return Semantics(
                button: true,
                label: isFavorite
                    ? 'Remove ${widget.item['name']} from favorites'
                    : 'Add ${widget.item['name']} to favorites',
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();

                    final cartItem = CartItem(
                      id: widget.itemId,
                      name: widget.item['name'],
                      description: widget.item['description'],
                      price: double.parse(
                        widget.item['price'].replaceAll('Rs ', ''),
                      ),
                      image: widget.item['image'],
                    );

                    if (isFavorite) {
                      favoritesProvider.removeFromFavorites(widget.itemId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.item['name']} removed from favorites',
                          ),
                          backgroundColor: Colors.red.shade600,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    } else {
                      favoritesProvider.addToFavorites(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.item['name']} added to favorites!',
                          ),
                          backgroundColor: Colors.pink.shade600,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.pink : Colors.white,
                    size: DesignTokens.fontSizeXxl,
                  ),
                  tooltip: isFavorite
                      ? 'Remove from favorites'
                      : 'Add to favorites',
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/background splash.png', fit: BoxFit.cover),

          // Blur effect
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero image section
                    _buildHeroImage(size),

                    // Content card
                    Container(
                      margin: const EdgeInsets.all(DesignTokens.spacingMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusXl,
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
                      child: Padding(
                        padding: const EdgeInsets.all(DesignTokens.spacingLg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Item name and rating
                            _buildItemHeader(),

                            const SizedBox(height: DesignTokens.spacingMd),

                            // Description
                            _buildDescription(),

                            const SizedBox(height: DesignTokens.spacingLg),

                            // Nutritional information
                            _buildNutritionalInfo(),

                            const SizedBox(height: DesignTokens.spacingLg),

                            // Reviews section
                            _buildReviewsSection(),

                            const SizedBox(height: DesignTokens.spacingXxl),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom action bar
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildHeroImage(Size size) {
    return Container(
      height: size.height * 0.4,
      margin: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(DesignTokens.opacityMedium),
            blurRadius: DesignTokens.elevationXl,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(widget.item['image'], fit: BoxFit.cover),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(DesignTokens.opacityOverlay),
                  ],
                ),
              ),
            ),
            // Rating badge
            Positioned(
              top: DesignTokens.spacingMd,
              right: DesignTokens.spacingMd,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingSm,
                  vertical: DesignTokens.spacingXs,
                ),
                decoration: BoxDecoration(
                  gradient: DesignTokens.primaryGradient,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: DesignTokens.fontSizeSm,
                    ),
                    SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      widget.item['rating'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: DesignTokens.fontSizeXs,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item['name'],
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXxl,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: DesignTokens.spacingXs),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: DesignTokens.fontSizeMd,
                  ),
                  SizedBox(width: DesignTokens.spacingXs),
                  Text(
                    '${widget.item['rating']} (${reviews.length} reviews)',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: Colors.grey[600],
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          widget.item['price'],
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXxl,
            fontWeight: DesignTokens.fontWeightBold,
            color: primaryDarkRed,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg,
            fontWeight: DesignTokens.fontWeightSemiBold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: DesignTokens.spacingSm),
        Text(
          widget.item['description'],
          style: TextStyle(
            fontSize: DesignTokens.fontSizeMd,
            color: Colors.grey[700],
            height: 1.5,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Information',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg,
            fontWeight: DesignTokens.fontWeightSemiBold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: DesignTokens.spacingMd),
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacingMd),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Column(
            children: nutritionalInfo.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacingXs,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key.toUpperCase(),
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        fontWeight: DesignTokens.fontWeightMedium,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        fontWeight: DesignTokens.fontWeightSemiBold,
                        color: primaryDarkRed,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Reviews',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeLg,
                fontWeight: DesignTokens.fontWeightSemiBold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all reviews
              },
              child: Text(
                'View All',
                style: TextStyle(
                  color: primaryDarkRed,
                  fontWeight: DesignTokens.fontWeightMedium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: DesignTokens.spacingMd),
        Column(
          children: reviews.take(2).map((review) {
            return Container(
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name'],
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          fontWeight: DesignTokens.fontWeightSemiBold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.orange,
                            size: DesignTokens.fontSizeSm,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    review['comment'],
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    review['date'],
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeXs,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(DesignTokens.opacityMedium),
            blurRadius: DesignTokens.elevationLg,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Quantity selector
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() => _quantity--);
                    }
                  },
                  icon: Icon(
                    Icons.remove,
                    color: _quantity > 1 ? primaryDarkRed : Colors.grey,
                    size: DesignTokens.fontSizeMd,
                  ),
                  padding: const EdgeInsets.all(DesignTokens.spacingSm),
                  constraints: const BoxConstraints(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                    vertical: DesignTokens.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: primaryDarkRed,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    '$_quantity',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: DesignTokens.fontWeightBold,
                      fontSize: DesignTokens.fontSizeMd,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _quantity++);
                  },
                  icon: Icon(
                    Icons.add,
                    color: primaryDarkRed,
                    size: DesignTokens.fontSizeMd,
                  ),
                  padding: const EdgeInsets.all(DesignTokens.spacingSm),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          SizedBox(width: DesignTokens.spacingMd),

          // Add to cart button
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();

                    for (int i = 0; i < _quantity; i++) {
                      final cartItem = CartItem(
                        id: '${widget.itemId}_${DateTime.now().millisecondsSinceEpoch}_$i',
                        name: widget.item['name'],
                        description: widget.item['description'],
                        price: double.parse(
                          widget.item['price'].replaceAll('Rs ', ''),
                        ),
                        image: widget.item['image'],
                      );

                      cartProvider.addToCart(cartItem);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${_quantity}x ${widget.item['name']} added to cart!',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: Colors.green.shade600,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.spacingMd,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    elevation: DesignTokens.elevationMd,
                    shadowColor: primaryDarkRed.withOpacity(
                      DesignTokens.opacityMedium,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_shopping_cart,
                        size: DesignTokens.fontSizeMd,
                      ),
                      SizedBox(width: DesignTokens.spacingSm),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeMd,
                          fontWeight: DesignTokens.fontWeightSemiBold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
