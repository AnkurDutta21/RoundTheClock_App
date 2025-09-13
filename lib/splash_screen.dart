import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;

  const SplashScreen({super.key, required this.child});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late final AnimationController _scaleController;
  late final AnimationController _fadeController;
  late final AnimationController _backgroundController;

  // Animations
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _backgroundFadeAnimation;

  // Image loading state
  bool _isBackgroundLoaded = false;
  bool _isLogoLoaded = false;

  // Navigation timer
  Timer? _navigationTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pre-cache background image
    precacheImage(
          const AssetImage('assets/images/background splash.png'),
          context,
        )
        .then((_) {
          if (mounted) {
            setState(() => _isBackgroundLoaded = true);
          }
        })
        .catchError((_) {
          // Handle error if image fails to load
          if (mounted) {
            setState(
              () => _isBackgroundLoaded = true,
            ); // Continue with default background
          }
        });

    // Pre-cache logo image
    precacheImage(const AssetImage('assets/images/asas.png'), context)
        .then((_) {
          if (mounted) {
            setState(() => _isLogoLoaded = true);
          }
        })
        .catchError((_) {
          // Handle error if image fails to load
          if (mounted) {
            setState(() => _isLogoLoaded = true); // Continue without logo
          }
        });

    // Start animations with a small delay to ensure smoothness
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _startAnimations();
    });
  }

  @override
  void initState() {
    super.initState();

    // Set preferred orientations to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize animation controllers with vsync
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Create animations with smooth curves
    _scaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.1), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.easeInOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutCubic),
    );

    _backgroundFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Schedule navigation after animations complete
    _navigationTimer = Timer(const Duration(seconds: 3), _navigateToMainApp);
  }

  void _startAnimations() {
    // Start animations with staggered timing
    _backgroundController.forward();

    // Slight delay for the scale and fade animations
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _scaleController.forward();
      }
    });
  }

  void _navigateToMainApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget.child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  ),
                ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(
          milliseconds: 800,
        ), // Reduced from 1200
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _scaleController.dispose();
    _fadeController.dispose();
    _backgroundController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _backgroundController,
          _fadeController,
          _scaleController,
        ]),
        builder: (context, _) {
          return Stack(
            children: [
              // Background with fade animation
              if (_isBackgroundLoaded)
                FadeTransition(
                  opacity: _backgroundFadeAnimation,
                  child: Image.asset(
                    'assets/images/background splash.png',
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                )
              else
                const SizedBox.expand(),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with scale and fade animation
                    if (_isLogoLoaded)
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _scaleController,
                          _fadeController,
                        ]),
                        builder: (context, _) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/asas.png',
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 300,
                                        height: 300,
                                        color: Colors.grey[800],
                                        child: const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const SizedBox(
                        width: 300,
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 30),

                    // Loading indicator with fade animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
