import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/item_detail_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'constants/design_tokens.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  Widget _initialScreen = const SplashScreen(child: LoginScreen());

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    try {
      // Initialize AuthService
      await AuthService().init();

      // Check if user is logged in
      final isLoggedIn = await AuthService().isLoggedIn();

      // Check if session is expired (optional security feature)
      final isSessionExpired = await AuthService().isSessionExpired();

      if (mounted) {
        setState(() {
          _isLoggedIn = isLoggedIn && !isSessionExpired;
          _isLoading = false;

          if (_isLoggedIn) {
            // User is logged in, go directly to dashboard
            _initialScreen = const SplashScreen(child: MainDashboard());
          } else {
            // User needs to login
            _initialScreen = const SplashScreen(child: LoginScreen());
          }
        });
      }
    } catch (e) {
      // If there's an error, default to login screen
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoggedIn = false;
          _initialScreen = const SplashScreen(child: LoginScreen());
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while checking authentication
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/asas.png', width: 100, height: 100),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.orange),
                const SizedBox(height: 20),
                const Text(
                  'Checking authentication...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final cartProvider = CartProvider();
            // Cart will initialize itself in constructor
            return cartProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            final favoritesProvider = FavoritesProvider();
            // Favorites will initialize itself in constructor
            return favoritesProvider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Round The Clock',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme(
            primary:
                DesignTokens.hasMinimumContrast(
                  Colors.white,
                  const Color(0xFFFF6B35),
                )
                ? const Color(0xFFFF6B35) // Professional orange
                : const Color(0xFFE65100), // Darker orange for better contrast
            secondary:
                DesignTokens.hasMinimumContrast(
                  Colors.white,
                  const Color(0xFF8B0000),
                )
                ? const Color(0xFF8B0000) // Dark red
                : const Color(0xFFB71C1C), // Lighter red for better contrast
            surface: Colors.white,
            background: const Color(0xFFFAFAFA),
            error: const Color(0xFFD32F2F), // Better contrast error color
            onPrimary: DesignTokens.getAccessibleForeground(
              const Color(0xFFFF6B35),
            ),
            onSecondary: DesignTokens.getAccessibleForeground(
              const Color(0xFF8B0000),
            ),
            onSurface: DesignTokens.getAccessibleForeground(Colors.white),
            onBackground: DesignTokens.getAccessibleForeground(
              const Color(0xFFFAFAFA),
            ),
            onError: DesignTokens.getAccessibleForeground(
              const Color(0xFFD32F2F),
            ),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto', // Professional font
          textTheme: TextTheme(
            headlineLarge: DesignTokens.headlineLarge,
            headlineMedium: DesignTokens.headlineMedium,
            titleLarge: DesignTokens.titleLarge,
            bodyLarge: DesignTokens.bodyLarge,
            bodyMedium: DesignTokens.bodyMedium,
            labelLarge: DesignTokens.labelLarge,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: DesignTokens.elevationSm,
              shadowColor: Colors.black.withOpacity(DesignTokens.opacityMedium),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingXl,
                vertical: DesignTokens.spacingMd,
              ),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: DesignTokens.elevationMd,
            shadowColor: const Color(0x1F000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(DesignTokens.radiusLg),
              ),
            ),
          ),
          // Enhanced button theme with gradient support
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFF6B35), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingXl,
                vertical: DesignTokens.spacingMd,
              ),
            ),
          ),
          // Enhanced input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingMd,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => _initialScreen,
          '/dashboard': (context) => const MainDashboard(),
          '/login': (context) => const LoginScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/item_detail': (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>;
            return ItemDetailScreen(item: args['item'], itemId: args['itemId']);
          },
          '/otp': (context) {
            final phoneNumber =
                ModalRoute.of(context)!.settings.arguments as String? ?? '';
            return OtpScreen(phoneNumber: phoneNumber);
          },
        },
      ),
    );
  }
}

// MainDashboard with professional dark red bottom navigation
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  // Professional dark red color scheme
  static const Color primaryDarkRed = Color(0xFF8B0000);
  static const Color accentRed = Color(0xFFB71C1C);

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreenContent(), // Home screen without bottom navigation
    MenuScreen(), // Menu screen
    CartScreen(), // Cart screen
    ProfileScreen(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryDarkRed, accentRed],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 0.25,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            letterSpacing: 0.15,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: 24,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _selectedIndex == 1
                      ? Icons.restaurant_menu
                      : Icons.restaurant_menu_outlined,
                  size: 24,
                ),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final cartCount = cartProvider.cartItemCount;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Icon(
                          _selectedIndex == 2
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          size: 24,
                        ),
                        if (cartCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                cartCount > 99 ? '99+' : '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _selectedIndex == 3 ? Icons.person : Icons.person_outline,
                  size: 24,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Updated placeholder widget with dark red theme
class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B0000), Color(0xFFB71C1C), Color(0xFFD32F2F)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  title == 'Menu'
                      ? Icons.restaurant_menu
                      : title == 'Cart'
                      ? Icons.shopping_cart
                      : title == 'Profile'
                      ? Icons.person
                      : Icons.home,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '$title Screen',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'This screen is under development',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'Welcome to Round The Clock!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
