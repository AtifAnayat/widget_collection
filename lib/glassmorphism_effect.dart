import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _containerController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _containerController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _containerController.forward();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _containerController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF353839),
      body: Stack(
        children: [
          // Animated Colored Bubbles
          ...List.generate(5, (index) => _buildBubble(index)),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _containerController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                    child: FadeTransition(
                      opacity: _containerController,
                      child: GlassContainer(
                        height: 500,
                        width: double.infinity,
                        blur: 25,
                        color: Colors.grey.withOpacity(0.25),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        shadowStrength: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                        child: Padding(
                          padding: EdgeInsets.all(35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo/Title
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Sign in to your account",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 40),

                              // Email Field
                              _buildGlassTextField(
                                controller: _emailController,
                                hintText: "Email Address",
                                icon: Icons.email_outlined,
                                isPassword: false,
                              ),
                              SizedBox(height: 20),

                              // Password Field
                              _buildGlassTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                icon: Icons.lock_outlined,
                                isPassword: true,
                              ),
                              SizedBox(height: 15),

                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),

                              // Login Button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListPage(),
                                    ),
                                  );
                                },
                                child: GlassContainer(
                                  height: 55,
                                  width: double.infinity,
                                  blur: 20,
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(27.5),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),

                              // Sign Up Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isPassword,
  }) {
    return GlassContainer(
      height: 60,
      width: double.infinity,
      blur: 15,
      color: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2)],
      ),
      border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.5),
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 22),
            SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (isPassword)
              Icon(
                Icons.visibility_off_outlined,
                color: Colors.black45,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(int index) {
    final colors = [
      Color(0xffd17d0e), // Blue
      Color(0xFFf093fb), // Pink
      Color(0xFF764ba2), // Purple
      Color(0xFFf5576c), // Red
      Color(0xFF4facfe), // Light Blue
    ];

    final sizes = [80.0, 120.0, 60.0, 100.0, 70.0];
    final positions = [
      {'top': 100.0, 'left': 50.0},
      {'top': 200.0, 'right': 30.0},
      {'bottom': 300.0, 'left': 20.0},
      {'bottom': 150.0, 'right': 60.0},
      {'top': 350.0, 'left': 200.0},
    ];

    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (context, child) {
        return Positioned(
          top: positions[index]['top'],
          left: positions[index]['left'],
          right: positions[index]['right'],
          bottom: positions[index]['bottom'],
          child: Transform.translate(
            offset: Offset(
              20 * math.sin(_bubbleController.value * 2 * math.pi + index),
              15 *
                  math.cos(_bubbleController.value * 2 * math.pi + index * 0.7),
            ),
            child: Container(
              width: sizes[index],
              height: sizes[index],
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    colors[index].withOpacity(0.4),
                    colors[index].withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors[index].withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Register Page
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _containerController;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _containerController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _containerController.forward();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _containerController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF353839),
      body: Stack(
        children: [
          // Animated Colored Bubbles
          ...List.generate(5, (index) => _buildBubble(index)),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _containerController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                    child: FadeTransition(
                      opacity: _containerController,
                      child: GlassContainer(
                        height: 580,
                        width: double.infinity,
                        blur: 25,
                        color: Colors.white.withOpacity(0.25),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        shadowStrength: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                        child: Padding(
                          padding: EdgeInsets.all(35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Back Button
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: GlassContainer(
                                    height: 40,
                                    width: 40,
                                    blur: 10,
                                    color: Colors.white.withOpacity(0.3),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.4),
                                        Colors.white.withOpacity(0.2),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Logo/Title
                              Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Join us today! It's quick and easy",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 25),

                              // Username Field
                              _buildGlassTextField(
                                controller: _usernameController,
                                hintText: "Username",
                                icon: Icons.person_outlined,
                                isPassword: false,
                              ),
                              SizedBox(height: 10),

                              // Email Field
                              _buildGlassTextField(
                                controller: _emailController,
                                hintText: "Email Address",
                                icon: Icons.email_outlined,
                                isPassword: false,
                              ),
                              SizedBox(height: 10),

                              // Password Field
                              _buildGlassTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                icon: Icons.lock_outlined,
                                isPassword: true,
                              ),
                              SizedBox(height: 20),

                              // Register Button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListPage(),
                                    ),
                                  );
                                },
                                child: GlassContainer(
                                  height: 55,
                                  width: double.infinity,
                                  blur: 20,
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(27.5),
                                  child: Center(
                                    child: Text(
                                      "Create Account",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // Back to Login Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isPassword,
  }) {
    return GlassContainer(
      height: 60,
      width: double.infinity,
      blur: 15,
      color: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2)],
      ),
      border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.5),
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 22),
            SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (isPassword)
              Icon(
                Icons.visibility_off_outlined,
                color: Colors.black45,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(int index) {
    final colors = [
      Color(0xffffcc02), // Blue
      Color(0xFFf093fb), // Pink
      Color(0xFF764ba2), // Purple
      Color(0xFFf5576c), // Red
      Color(0xFF4facfe), // Light Blue
    ];

    final sizes = [80.0, 120.0, 60.0, 100.0, 70.0];
    final positions = [
      {'top': 100.0, 'left': 50.0},
      {'top': 200.0, 'right': 30.0},
      {'bottom': 300.0, 'left': 20.0},
      {'bottom': 150.0, 'right': 60.0},
      {'top': 350.0, 'left': 200.0},
    ];

    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (context, child) {
        return Positioned(
          top: positions[index]['top'],
          left: positions[index]['left'],
          right: positions[index]['right'],
          bottom: positions[index]['bottom'],
          child: Transform.translate(
            offset: Offset(
              20 * math.sin(_bubbleController.value * 2 * math.pi + index),
              15 *
                  math.cos(_bubbleController.value * 2 * math.pi + index * 0.7),
            ),
            child: Container(
              width: sizes[index],
              height: sizes[index],
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    colors[index].withOpacity(0.4),
                    colors[index].withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors[index].withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// List Page with Animated Glass List Items
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _listController;
  late List<AnimationController> _itemControllers;

  final List<Map<String, dynamic>> listItems = [
    {
      'icon': Icons.shopping_bag,
      'title': 'Shopping Hub',
      'description':
          'Discover amazing products with exclusive deals and offers',
      'color': Color(0xFF667eea),
    },
    {
      'icon': Icons.restaurant_menu,
      'title': 'Food Delivery',
      'description': 'Order delicious meals from your favorite restaurants',
      'color': Color(0xFFf093fb),
    },
    {
      'icon': Icons.fitness_center,
      'title': 'Fitness Tracker',
      'description': 'Track your workouts and achieve your fitness goals',
      'color': Color(0xFF764ba2),
    },
    {
      'icon': Icons.music_note,
      'title': 'Music Player',
      'description': 'Listen to millions of songs and create playlists',
      'color': Color(0xFFf5576c),
    },
    {
      'icon': Icons.camera_alt,
      'title': 'Photo Editor',
      'description': 'Edit and enhance your photos with professional tools',
      'color': Color(0xFF4facfe),
    },
    {
      'icon': Icons.travel_explore,
      'title': 'Travel Guide',
      'description': 'Explore destinations and plan your perfect trip',
      'color': Color(0xFF43e97b),
    },
    {
      'icon': Icons.book,
      'title': 'E-Learning',
      'description': 'Access thousands of courses and expand your knowledge',
      'color': Color(0xFFfa709a),
    },
    {
      'icon': Icons.videogame_asset,
      'title': 'Gaming Zone',
      'description': 'Play exciting games and compete with friends',
      'color': Color(0xFF667eea),
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'Health Monitor',
      'description': 'Track your health metrics and stay fit',
      'color': Color(0xff8141c1),
    },
    {
      'icon': Icons.chat_bubble,
      'title': 'Chat Messenger',
      'description': 'Connect with friends through secure messaging',
      'color': Color(0xFF667eea),
    },
    {
      'icon': Icons.wallet,
      'title': 'Digital Wallet',
      'description': 'Manage your money with secure transactions',
      'color': Color(0xFFffecd2),
    },
    {
      'icon': Icons.local_taxi,
      'title': 'Ride Booking',
      'description': 'Book rides easily and travel comfortably',
      'color': Color(0xff275cb1),
    },
  ];

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _listController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _itemControllers = List.generate(
      listItems.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _listController.forward();

    for (int i = 0; i < _itemControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200)); // smoother
      _itemControllers[i].forward();
    }
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _listController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF353839),

        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Explore Features",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF353839),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.2, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _itemControllers[index],
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _itemControllers[index],
                        curve: Curves.easeIn, // smooth fade
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: _buildListItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    final item = listItems[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: GlassContainer(
          height: 100,
          width: double.infinity,
          blur: 25,
          color: item['color'].withOpacity(0.5),
          border: Border.all(color: item['color'].withOpacity(0.4), width: 1.2),
          borderRadius: BorderRadius.circular(22),
          shadowStrength: 3,

          shadowColor: item['color'].withOpacity(0.8),

          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                // Large Icon Container with 2-color gradient
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          item['color'].withOpacity(0.95),
                          Colors.white.withOpacity(0.25),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: item['color'].withOpacity(0.45),
                          blurRadius: 20,
                          spreadRadius: 3, // shadow charon taraf
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(item['icon'], color: Colors.white, size: 30),
                  ),
                ),
                SizedBox(width: 20),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        item['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Arrow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item['color'].withOpacity(0.15),
                  ),
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.8),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
