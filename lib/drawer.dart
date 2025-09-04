import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class ECommerceOnboarding extends StatefulWidget {
  const ECommerceOnboarding({super.key});

  @override
  State<ECommerceOnboarding> createState() => _ECommerceOnboardingState();
}

class _ECommerceOnboardingState extends State<ECommerceOnboarding>
    with TickerProviderStateMixin {
  final LiquidController _liquidController = LiquidController();
  late AnimationController _iconAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;

  int page = 0;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _iconScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _iconRotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut),
    );

    _startAnimations();
  }

  void _startAnimations() {
    _iconAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _textAnimationController.forward();
    });
  }

  void _resetAnimations() {
    _iconAnimationController.reset();
    _textAnimationController.reset();
    _startAnimations();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  late final pages = [
    // Page 1 - Welcome to Luxe Store
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C2D12),
            Color(0xFF7C2D12), // Fully opaque
            Color(0xFF92400E),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _GeometricPatternPainter()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _iconAnimationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _iconScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _iconRotationAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.25),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedShoppingCart01,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Welcome to",
                            style: GoogleFonts.cinzel(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "LUXE STORE",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 42,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Discover premium products crafted with excellence and designed for the extraordinary.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 45),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     _buildEnhancedFeatureChip(
                          //       "Premium Quality",
                          //       HugeIcons.strokeRoundedDiamond01,
                          //       Colors.white,
                          //     ),
                          //     const SizedBox(width: 10),
                          //     _buildEnhancedFeatureChip(
                          //       "Free Shipping",
                          //       HugeIcons.strokeRoundedTruck,
                          //       Colors.white,
                          //     ),
                          //   ],
                          // ),
                        ],
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

    // Page 2 - Curated Collections
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF14532D),
            Color(0xFF14532D), // Fully opaque
            Color(0xFF166534),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _WavePatternPainter()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _iconAnimationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _iconScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _iconRotationAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.25),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedShapeCollection,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Curated Collections",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Handpicked products from top brands worldwide. Each item carefully selected for quality, style, and exceptional value that speaks to your refined taste.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 40),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     _buildEnhancedFeatureChip(
                          //       "1000+ Brands",
                          //       HugeIcons.strokeRoundedStars,
                          //       Colors.white,
                          //     ),
                          //     const SizedBox(width: 10),
                          //     _buildEnhancedFeatureChip(
                          //       "Expert Curation",
                          //       HugeIcons.strokeRoundedUserCheck01,
                          //       Colors.white,
                          //     ),
                          //   ],
                          // ),
                        ],
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

    // Page 3 - Smart Shopping Experience
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF241137),
            Color(0xFF241137), // Fully opaque
            Color(0xFF4C1D95),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _CircuitPatternPainter()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _iconAnimationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _iconScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _iconRotationAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.25),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedAiBrain01,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Smart Shopping",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Personalized recommendations, smart filters, and instant search. Find exactly what you're looking for in seconds with our advanced AI technology.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 40),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 28,
                          //     vertical: 16,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //       colors: [
                          //         Colors.white.withOpacity(0.2),
                          //         Colors.white.withOpacity(0.1),
                          //       ],
                          //     ),
                          //     borderRadius: BorderRadius.circular(35),
                          //     border: Border.all(
                          //       color: Colors.white.withOpacity(0.4),
                          //     ),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.white.withOpacity(0.1),
                          //         blurRadius: 15,
                          //         spreadRadius: 2,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       const Icon(
                          //         HugeIcons.strokeRoundedAiSecurity01,
                          //         color: Colors.white,
                          //         size: 20,
                          //       ),
                          //       const SizedBox(width: 8),
                          //       Text(
                          //         "Powered by Advanced AI",
                          //         style: GoogleFonts.montserrat(
                          //           fontSize: 15,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.w700,
                          //           letterSpacing: 0.5,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
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

    // Page 4 - Get Started
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF1E293B), // Fully opaque
            Color(0xFF334155),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _StarPatternPainter()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _iconAnimationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _iconScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _iconRotationAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.25),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedRocket01,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Ready to Explore?",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Join over 100,000+ satisfied customers who have discovered their perfect shopping experience with Luxe Store. Your journey to extraordinary begins here.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF1E293B),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 55,
                                  vertical: 22,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Start Shopping",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    HugeIcons.strokeRoundedArrowRight01,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                "Browse as Guest",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
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
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Solid background to prevent bleed-through
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: _liquidController,
            enableLoop: false,
            fullTransitionValue: 600, // Kept original value for fluid effect
            waveType: WaveType.liquidReveal, // Set to fluid effect as requested
            positionSlideIcon: 0.85,
            onPageChangeCallback: (activePageIndex) {
              setState(() {
                page = activePageIndex;
              });
              _resetAnimations();
            },
          ),

          // Enhanced Page Indicator with pulse animation
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: page == index ? 40 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: page == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: page == index
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),

          // Enhanced Skip Button with glow effect
          if (page < pages.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),

                  child: TextButton(
                    onPressed: () {
                      _liquidController.animateToPage(page: pages.length - 1);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Enhanced App Logo/Brand with glow effect
          Positioned(
            top: 65,
            left: 25,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFFF8FAFC)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      HugeIcons.strokeRoundedShoppingBag01,
                      color: Color(0xFF1E293B),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "LUXE",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
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

// Custom Painters for Background Patterns
class _GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 10; i++) {
      final rect = Rect.fromLTWH(
        (i * size.width / 10) - 50,
        (i * size.height / 15) - 30,
        100,
        60,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < 5; i++) {
      path.moveTo(0, size.height / 5 * i);
      path.quadraticBezierTo(
        size.width / 4,
        (size.height / 5 * i) - 30,
        size.width / 2,
        size.height / 5 * i,
      );
      path.quadraticBezierTo(
        3 * size.width / 4,
        (size.height / 5 * i) + 30,
        size.width,
        size.height / 5 * i,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _CircuitPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 6; j++) {
        final centerX = (i + 1) * size.width / 9;
        final centerY = (j + 1) * size.height / 7;

        canvas.drawCircle(Offset(centerX, centerY), 3, paint);

        if (i < 7) {
          canvas.drawLine(
            Offset(centerX + 3, centerY),
            Offset(centerX + size.width / 9 - 3, centerY),
            paint,
          );
        }

        if (j < 5) {
          canvas.drawLine(
            Offset(centerX, centerY + 3),
            Offset(centerX, centerY + size.height / 7 - 3),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StarPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = (i * 47) % size.width;
      final y = (i * 73) % size.height;

      _drawStar(canvas, paint, Offset(x, y), 8);
    }
  }

  void _drawStar(Canvas canvas, Paint paint, Offset center, double radius) {
    const int points = 5;
    final path = Path();

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * 3.14159) / points;
      final currentRadius = i % 2 == 0 ? radius : radius / 2;
      final x = center.dx + currentRadius * math.cos(angle);
      final y = center.dy + currentRadius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
