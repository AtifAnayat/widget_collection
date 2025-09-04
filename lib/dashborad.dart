import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _counterController;
  late AnimationController _chartAnimationController;
  late AnimationController _glowAnimationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _revenueAnimation;
  late Animation<double> _usersAnimation;
  late Animation<double> _ordersAnimation;
  late Animation<double> _conversionAnimation;
  late Animation<double> _chartScaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _mainAnimationController = AnimationController(
      duration: Duration(milliseconds: 1800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainAnimationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _mainAnimationController,
            curve: Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _counterController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );

    _revenueAnimation = Tween<double>(begin: 0, end: 124500).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _usersAnimation = Tween<double>(begin: 0, end: 8420).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _ordersAnimation = Tween<double>(begin: 0, end: 1250).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _conversionAnimation = Tween<double>(begin: 0, end: 12.5).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _chartAnimationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _chartScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _glowAnimationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _glowAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    _mainAnimationController.forward();
    _glowAnimationController.repeat(reverse: true);
    await Future.delayed(Duration(milliseconds: 300));
    _counterController.forward();
    await Future.delayed(Duration(milliseconds: 500));
    _chartAnimationController.forward();
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _counterController.dispose();
    _chartAnimationController.dispose();
    _glowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 2.0,
            colors: [
              Color(0xFFFBFBFB),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _mainAnimationController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildFuturisticHeader(),
                        SizedBox(height: 24),
                        _buildStatsGrid(),
                        SizedBox(height: 24),
                        _buildChartsSection(),
                        SizedBox(height: 24),
                        _buildBottomStats(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFuturisticHeader() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE0FFFF), Color(0xFFBBFFFF), Color(0xFF87CEEB)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(
                0xFF0EA5E9,
              ).withOpacity(0.3 + (_glowAnimation.value * 0.4)),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(
                  0xFF0EA5E9,
                ).withOpacity(0.2 + (_glowAnimation.value * 0.3)),
                spreadRadius: 0,
                blurRadius: 15 + (_glowAnimation.value * 10),
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    HugeIcons.strokeRoundedDashboardSquare01,
                    color: Color(0xFF001F3F),
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'QUANTUM DASHBOARD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF001F3F),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Real-time Neural Analytics Interface',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF001F3F).withOpacity(0.8),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid() {
    return AnimatedBuilder(
      animation: _counterController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = (constraints.maxWidth - 16) / 2;
            double cardHeight = cardWidth * 0.85;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: _buildFuturisticStatCard(
                    title: 'REVENUE STREAM',
                    value:
                        '\$${_revenueAnimation.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    change: '+12.5%',
                    icon: HugeIcons.strokeRoundedUploadSquare01,
                    primaryColor: Color(0xFF10B981), // Emerald-500
                    secondaryColor: Color(0xFF047857), // Emerald-700
                    backgroundColors: [
                      Color(0xFFE6FFFA), // Emerald-50
                      Color(0xFFD1FAE5), // Emerald-100
                    ],
                    isPositive: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: _buildFuturisticStatCard(
                    title: 'ACTIVE NODES',
                    value: _usersAnimation.value
                        .toInt()
                        .toString()
                        .replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},',
                        ),
                    change: '+8.2%',
                    icon: HugeIcons.strokeRoundedUserGroup,
                    primaryColor: Color(0xFF3B82F6), // Blue-500
                    secondaryColor: Color(0xFF1D4ED8), // Blue-700
                    backgroundColors: [
                      Color(0xFFEFF6FF), // Blue-50
                      Color(0xFFDBEAFE), // Blue-100
                    ],
                    isPositive: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: _buildFuturisticStatCard(
                    title: 'DATA PACKETS',
                    value:
                        '${_ordersAnimation.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    change: '+5.1%',
                    icon: HugeIcons.strokeRoundedDatabase01,
                    primaryColor: Color(0xFFF59E0B), // Amber-500
                    secondaryColor: Color(0xFFD97706), // Amber-700
                    backgroundColors: [
                      Color(0xFFFFF7ED), // Amber-50
                      Color(0xFFFDE68A), // Amber-100
                    ],
                    isPositive: true,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: _buildFuturisticStatCard(
                    title: 'EFFICIENCY',
                    value: '${_conversionAnimation.value.toStringAsFixed(1)}%',
                    change: '-2.3%',
                    icon: HugeIcons.strokeRoundedAdobeAfterEffect,
                    primaryColor: Color(0xFFEC4899), // Pink-500
                    secondaryColor: Color(0xFFDB2777), // Pink-700
                    backgroundColors: [
                      Color(0xFFFDE8F3), // Pink-50
                      Color(0xFFFBCFE8), // Pink-100
                    ],
                    isPositive: false,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFuturisticStatCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required Color primaryColor,
    required Color secondaryColor,
    required List<Color> backgroundColors,
    required bool isPositive,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      builder: (context, double animationValue, child) {
        return AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * animationValue),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: backgroundColors,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: primaryColor.withOpacity(
                      0.3 + (_glowAnimation.value * 0.2),
                    ),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(
                        0.1 + (_glowAnimation.value * 0.15),
                      ),
                      spreadRadius: 0,
                      blurRadius: 8 + (_glowAnimation.value * 5),
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(icon, color: Colors.white, size: 18),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? Color(0xFF10B981).withOpacity(0.1)
                                  : Color(0xFFEC4899).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isPositive
                                    ? Color(0xFF10B981).withOpacity(0.3)
                                    : Color(0xFFEC4899).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              change,
                              style: TextStyle(
                                color: isPositive
                                    ? Color(0xFF10B981)
                                    : Color(0xFFEC4899),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F2937), // Gray-900
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChartsSection() {
    return AnimatedBuilder(
      animation: _chartAnimationController,
      builder: (context, child) {
        return Column(
          children: [
            Transform.scale(
              scale: _chartScaleAnimation.value,
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF).withOpacity(1.0),
                      Color(0xFFF8F9FA).withOpacity(1.0),
                      Color(0xFFE9ECEF).withOpacity(1.0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF0EA5E9).withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0EA5E9).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NEURAL NETWORK ACTIVITY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0EA5E9),
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF10B981).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xFF10B981).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'LIVE',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(child: _buildFuturisticLineChart()),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Transform.scale(
              scale: _chartScaleAnimation.value,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF).withOpacity(1.0),
                      Color(0xFFF8F9FA).withOpacity(1.0),
                      Color(0xFFE9ECEF).withOpacity(1.0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF0EA5E9).withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0EA5E9).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DATA SOURCE DISTRIBUTION',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0EA5E9),
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(child: _buildCompactPieChart()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFuturisticLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1000,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Color(0xFF0EA5E9).withOpacity(0.1),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Color(0xFF0EA5E9).withOpacity(0.1),
            strokeWidth: 0.5,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const months = [
                  'JAN',
                  'FEB',
                  'MAR',
                  'APR',
                  'MAY',
                  'JUN',
                  'JUL',
                ];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: TextStyle(
                      color: Color(0xFF6C757D),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1000,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  '${(value / 1000).toStringAsFixed(0)}K',
                  style: TextStyle(
                    color: Color(0xFF6C757D),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 5000,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 4000),
              FlSpot(1, 3000),
              FlSpot(2, 2000),
              FlSpot(3, 2780),
              FlSpot(4, 1890),
              FlSpot(5, 2390),
              FlSpot(6, 3490),
            ],
            isCurved: true,
            curveSmoothness: 0.4,
            gradient: LinearGradient(
              colors: [Color(0xFF0EA5E9), Color(0xFF1D4ED8)],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: Color(0xFF0EA5E9),
                    strokeWidth: 2,
                    strokeColor: Color(0xFFE9ECEF),
                  ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0EA5E9).withOpacity(0.3),
                  Color(0xFF0EA5E9).withOpacity(0.1),
                  Color(0xFF0EA5E9).withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactPieChart() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(enabled: true),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Color(0xFF0EA5E9),
                    value: 45,
                    title: '45%',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  PieChartSectionData(
                    color: Color(0xFF10B981),
                    value: 30,
                    title: '30%',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  PieChartSectionData(
                    color: Color(0xFFF59E0B),
                    value: 15,
                    title: '15%',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  PieChartSectionData(
                    color: Color(0xFFEC4899),
                    value: 10,
                    title: '10%',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFuturisticLegendItem(
                'NEURAL NET',
                Color(0xFF0EA5E9),
                '45%',
              ),
              _buildFuturisticLegendItem(
                'QUANTUM AI',
                Color(0xFF10B981),
                '30%',
              ),
              _buildFuturisticLegendItem(
                'BLOCKCHAIN',
                Color(0xFFF59E0B),
                '15%',
              ),
              _buildFuturisticLegendItem(
                'CLOUD SYNC',
                Color(0xFFEC4899),
                '10%',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFuturisticLegendItem(
    String label,
    Color color,
    String percentage,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomStats() {
    return Column(
      children: [
        _buildFuturisticBottomCard(
          title: 'QUANTUM ACCELERATION',
          value: '+23.5%',
          subtitle: 'Neural Enhancement Rate',
          icon: HugeIcons.strokeRoundedRocket01,
          primaryColor: Color(0xFF06B6D4), // Cyan-500
          secondaryColor: Color(0xFF0891B2), // Cyan-600
          backgroundColors: [
            Color(0xFFE0F7FA), // Cyan-50
            Color(0xFFB2EBF2), // Cyan-100
          ],
        ),
        SizedBox(height: 16),
        _buildFuturisticBottomCard(
          title: 'USER SATISFACTION',
          value: '4.8/5',
          subtitle: 'AI Feedback Analysis',
          icon: HugeIcons.strokeRoundedBrain,
          primaryColor: Color(0xFF14B8A6), // Teal-500
          secondaryColor: Color(0xFF0D9488), // Teal-600
          backgroundColors: [
            Color(0xFFE6FFFA), // Teal-50
            Color(0xFFB2F5EA), // Teal-100
          ],
        ),
        SizedBox(height: 16),
        _buildFuturisticBottomCard(
          title: 'ACTIVE PROTOCOLS',
          value: '12',
          subtitle: 'System Optimization',
          icon: HugeIcons.strokeRoundedSettings01,
          primaryColor: Color(0xFFF97316), // Orange-500
          secondaryColor: Color(0xFFEA580C), // Orange-600
          backgroundColors: [
            Color(0xFFFFF7ED), // Orange-50
            Color(0xFFFED7AA), // Orange-100
          ],
        ),
      ],
    );
  }

  Widget _buildFuturisticBottomCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color primaryColor,
    required Color secondaryColor,
    required List<Color> backgroundColors,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      builder: (context, double animationValue, child) {
        return AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.9 + (0.1 * animationValue),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: backgroundColors,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor.withOpacity(
                      0.3 + (_glowAnimation.value * 0.2),
                    ),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(
                        0.2 + (_glowAnimation.value * 0.2),
                      ),
                      spreadRadius: 0,
                      blurRadius: 15 + (_glowAnimation.value * 10),
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: primaryColor.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFF1F2937),
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Color(0xFF6C757D),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.2),
                            secondaryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(icon, color: primaryColor, size: 28),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
