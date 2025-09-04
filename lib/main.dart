import 'package:bar_studio/splash_resume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

void main() {
  runApp(const MyApp());
}

/// Root App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2C3E50),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2C3E50),
          primary: Color(0xFF2C3E50),
          secondary: Color(0xFF34495E),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2C3E50),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: SplashScreen(),
      // BarcodeGeneratorScreen(),
      // DashboardScreen(),
      // ECommerceOnboarding(),
      // const AdvancedDrawerPage(),
    );
  }
}

final _advancedDrawerController = AdvancedDrawerController();
int _selectedIndex = 0;
final List<DrawerItem> drawerItems = [
  DrawerItem(
    "Home",
    HugeIcons.strokeRoundedHome01,
    HugeIcons.strokeRoundedHome01,
  ),
  DrawerItem(
    "Profile",
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUser,
  ),
  DrawerItem(
    "Cards",
    HugeIcons.strokeRoundedCreditCard,
    HugeIcons.strokeRoundedCreditCard,
  ),
  DrawerItem(
    "Transactions",
    HugeIcons.strokeRoundedTransaction,
    HugeIcons.strokeRoundedTransaction,
  ),
  DrawerItem(
    "Analytics",
    HugeIcons.strokeRoundedBarChart,
    HugeIcons.strokeRoundedBarChart,
  ),
  DrawerItem(
    "Settings",
    HugeIcons.strokeRoundedAiSetting,
    HugeIcons.strokeRoundedAiSetting,
  ),
  DrawerItem(
    "Help & Support",
    HugeIcons.strokeRoundedHelpCircle,
    HugeIcons.strokeRoundedHelpCircle,
  ),
  DrawerItem(
    "Logout",
    HugeIcons.strokeRoundedLogout01,
    HugeIcons.strokeRoundedLogout01,
  ),
];

/// Main Page with Drawer
class AdvancedDrawerPage extends StatefulWidget {
  const AdvancedDrawerPage({super.key});

  @override
  State<AdvancedDrawerPage> createState() => _AdvancedDrawerPageState();
}

class _AdvancedDrawerPageState extends State<AdvancedDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(color: const Color(0xFF1E293B)),
      controller: _advancedDrawerController,
      childDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            drawerItems[_selectedIndex].title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: const Color(0xFF1E293B),
            ),
          ),
          leading: IconButton(
            onPressed: () => _advancedDrawerController.showDrawer(),
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    value.visible
                        ? HugeIcons.strokeRoundedCancelSquare
                        : HugeIcons.strokeRoundedMenuSquare,
                    key: ValueKey<bool>(value.visible),
                    color: const Color(0xFF1E293B),
                  ),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                HugeIcons.strokeRoundedNotification01,
                color: Color(0xFF64748B),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: _selectedIndex == 0
            ? const CardStackWallet()
            : _buildPageContent(),
      ),
    );
  }

  Widget _buildPageContent() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              drawerItems[_selectedIndex].activeIcon,
              size: 48,
              color: const Color(0xFF3B82F6),
            ),
            const SizedBox(height: 16),
            Text(
              "${drawerItems[_selectedIndex].title} Page",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Coming soon...",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return SafeArea(
      child: Container(
        color: const Color(0xFF1E293B),
        child: Column(
          children: [
            // Professional Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      HugeIcons.strokeRoundedAiUser,
                      size: 36,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Haider Chaudhary",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Premium Member",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  final item = drawerItems[index];
                  final isSelected = _selectedIndex == index;
                  final isLogout = index == drawerItems.length - 1;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        isSelected ? item.activeIcon : item.icon,
                        color: isSelected
                            ? Colors.white
                            : isLogout
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF94A3B8),
                        size: 22,
                      ),
                      title: Text(
                        item.title,
                        style: GoogleFonts.inter(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : isLogout
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF94A3B8),
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        if (isLogout) {
                          _showLogoutDialog();
                        } else {
                          setState(() => _selectedIndex = index);
                          _advancedDrawerController.hideDrawer();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF64748B)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add logout logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Wallet Screen with Card Swiper
class CardStackWallet extends StatefulWidget {
  const CardStackWallet({Key? key}) : super(key: key);
  @override
  State<CardStackWallet> createState() => _CardStackWalletState();
}

class _CardStackWalletState extends State<CardStackWallet> {
  final CardSwiperController controller = CardSwiperController();
  int currentIndex = 0;

  final List<CreditCard> cards = [
    CreditCard(
      number: "4532 1234 5678 4521",
      holder: "HAIDER CHAUDHARY",
      expiry: "12/28",
      bank: "CHASE BANK",
      cardType: "VISA",
      backgroundColor: const Color(0xFF1E293B), // Dark slate
      accentColor: const Color(0xFF3B82F6), // Blue
    ),
    CreditCard(
      number: "5412 7534 8901 8934",
      holder: "MALIK ATIF",
      expiry: "03/27",
      bank: "STANDARD BANK",
      cardType: "MASTERCARD",
      backgroundColor: const Color(0xFF7C2D12), // Dark brown
      accentColor: const Color(0xFFF97316), // Orange
    ),
    CreditCard(
      number: "3782 8224 6310 2156",
      holder: "ZARRAR KHAN",
      expiry: "08/26",
      bank: "AMERICAN EXPRESS",
      cardType: "AMEX",
      backgroundColor: const Color(0xFF14532D), // Dark green
      accentColor: const Color(0xFF22C55E), // Green
    ),
    CreditCard(
      number: "3725 8224 6310 2156",
      holder: "WASEEM MEO",
      expiry: "08/26",
      bank: "AMERICAN EXPRESS",
      cardType: "AMEX",
      backgroundColor: const Color(0xFF241137), // Dark green
      accentColor: const Color(0xFFB056FB), // Green
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Professional Balance Section
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      HugeIcons.strokeRoundedWallet01,
                      size: 20,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Total Balance",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "\$12,847.50",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedUploadCircle02,
                    size: 16,
                    color: Colors.green[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "+2.5% from last month",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.green[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cards Header with Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Cards",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    "${currentIndex + 1} of ${cards.length} cards",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => controller.undo(),
                    icon: const Icon(
                      HugeIcons.strokeRoundedUndo,
                      color: Color(0xFF64748B),
                    ),
                    tooltip: 'Previous card',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      HugeIcons.strokeRoundedAddCircle,
                      color: Color(0xFF3B82F6),
                    ),
                    tooltip: 'Add new card',
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Cards Swiper
        Expanded(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 240,
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(15, 15),
                padding: const EdgeInsets.all(8),
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                cardBuilder: (context, index, _, __) {
                  final card = cards[index % cards.length];
                  return _buildCreditCard(card);
                },
              ),
            ),
          ),
        ),

        // Quick Actions
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Actions",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(
                    HugeIcons.strokeRoundedDollarSend01,
                    "Send",
                    const Color(0xFF3B82F6),
                  ),
                  _buildQuickAction(
                    HugeIcons.strokeRoundedQrCode,
                    "Scan",
                    const Color(0xFF8B5CF6),
                  ),
                  _buildQuickAction(
                    HugeIcons.strokeRoundedPayment01,
                    "Pay Bills",
                    const Color(0xFF059669),
                  ),
                  _buildQuickAction(
                    HugeIcons.strokeRoundedSendToMobile,
                    "Top Up",
                    const Color(0xFFDC2626),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditCard(CreditCard card) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: card.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: card.backgroundColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle pattern overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.05), Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bank and Card Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.bank,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: card.accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        card.cardType,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: card.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Card Number
                Text(
                  card.number,
                  style: GoogleFonts.courierPrime(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                const Spacer(),

                // Card Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CARDHOLDER",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.holder,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPIRES",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.expiry,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Card chip
                    Container(
                      width: 32,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        HugeIcons.strokeRoundedCreditCard,
                        size: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
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

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection dir) {
    setState(() => this.currentIndex = currentIndex ?? 0);
    return true;
  }

  bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection dir) {
    setState(() => this.currentIndex = previousIndex ?? currentIndex);
    return true;
  }
}

/// Credit Card Model
class CreditCard {
  final String number;
  final String holder;
  final String expiry;
  final String bank;
  final String cardType;
  final Color backgroundColor;
  final Color accentColor;

  CreditCard({
    required this.number,
    required this.holder,
    required this.expiry,
    required this.bank,
    required this.cardType,
    required this.backgroundColor,
    required this.accentColor,
  });
}

/// Drawer Item Model
class DrawerItem {
  final String title;
  final IconData icon;
  final IconData activeIcon;

  DrawerItem(this.title, this.icon, this.activeIcon);
}
