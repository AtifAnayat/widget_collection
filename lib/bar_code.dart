import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: BarcodeGeneratorScreen(),
    );
  }
}

class BarcodeGeneratorScreen extends StatefulWidget {
  @override
  _BarcodeGeneratorScreenState createState() => _BarcodeGeneratorScreenState();
}

class _BarcodeGeneratorScreenState extends State<BarcodeGeneratorScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String _barcodeData = 'Hello World!';
  Barcode _selectedType = Barcode.qrCode();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showBarcode = true;

  final List<BarcodeType> _barcodeTypes = [
    BarcodeType(
      'QR Code',
      Barcode.qrCode(),
      Icons.qr_code_2,
      Color(0xFF2563EB),
    ),
    BarcodeType(
      'Code 128',
      Barcode.code128(),
      Icons.view_stream,
      Color(0xFF7C3AED),
    ),
    BarcodeType('Code 39', Barcode.code39(), Icons.code, Color(0xFF059669)),
    BarcodeType(
      'EAN 13',
      Barcode.ean13(),
      Icons.local_offer,
      Color(0xFFEA580C),
    ),
    BarcodeType(
      'PDF417',
      Barcode.pdf417(),
      Icons.picture_as_pdf,
      Color(0xFFDC2626),
    ),
    BarcodeType(
      'Data Matrix',
      Barcode.dataMatrix(),
      Icons.grid_4x4,
      Color(0xFF0891B2),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.text = _barcodeData;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _generateBarcode() {
    setState(() {
      _barcodeData = _controller.text.isEmpty
          ? 'Sample Text'
          : _controller.text;
      _showBarcode = false;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _showBarcode = true;
      });
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInputField(),
                  SizedBox(height: 24),
                  _buildHorizontalTypesList(),
                  SizedBox(height: 32),
                  _buildBarcodeContainer(),
                  SizedBox(height: 32),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1E293B).withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF2563EB).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Barcode Studio Pro',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  'Generate professional barcodes instantly',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF059669),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF059669).withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'FREE',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1E293B).withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF2563EB),
                  size: 22,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Enter Your Content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            maxLines: 3,
            style: TextStyle(fontSize: 16, color: Color(0xFF334155)),
            decoration: InputDecoration(
              hintText: 'Type text, URL, numbers or any data...',
              hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
              ),
              filled: true,
              fillColor: Color(0xFFFAFBFC),
              contentPadding: EdgeInsets.all(18),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _generateBarcode();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalTypesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF7C3AED).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: Color(0xFF7C3AED),
                  size: 22,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Choose Barcode Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4),
            itemCount: _barcodeTypes.length,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final type = _barcodeTypes[index];
              bool isSelected = _selectedType == type.barcode;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedType = type.barcode;
                  });
                  _generateBarcode();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 130,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? type.color : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? type.color.withOpacity(0.3)
                            : Color(0xFF1E293B).withOpacity(0.06),
                        blurRadius: isSelected ? 12 : 8,
                        offset: Offset(0, isSelected ? 6 : 3),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected ? type.color : Color(0xFFE2E8F0),
                      width: isSelected ? 0 : 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        type.icon,
                        color: isSelected ? Colors.white : type.color,
                        size: 28,
                      ),
                      SizedBox(height: 8),
                      Text(
                        type.name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Color(0xFF334155),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBarcodeContainer() {
    return AnimatedOpacity(
      opacity: _showBarcode ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1E293B).withOpacity(0.08),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
            border: Border.all(color: Color(0xFFE2E8F0), width: 1),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF059669),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF059669).withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Generated Successfully',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Color(0xFFFAFBFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFE2E8F0), width: 2),
                ),
                child: _buildBarcodeWidget(),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xFF64748B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _barcodeData.length > 40
                      ? '${_barcodeData.substring(0, 40)}...'
                      : _barcodeData,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarcodeWidget() {
    try {
      return BarcodeWidget(
        barcode: _selectedType,
        data: _barcodeData,
        width: 260,
        height: _selectedType == Barcode.qrCode() ? 260 : 140,
        style: TextStyle(fontSize: 0),
        drawText: false,
        color: Color(0xFF0F172A),
      );
    } catch (e) {
      return Container(
        width: 260,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFFECACA), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFDC2626),
              size: 36,
            ),
            SizedBox(height: 12),
            Text(
              'Invalid Data Format',
              style: TextStyle(
                color: Color(0xFFDC2626),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Please check your input data',
              style: TextStyle(color: Color(0xFFDC2626), fontSize: 13),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _generateBarcode,
            icon: Icon(Icons.refresh_rounded, size: 22),
            label: Text(
              'Regenerate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              shadowColor: Color(0xFF2563EB).withOpacity(0.3),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _barcodeData));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Copied to clipboard!',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: Color(0xFF059669),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.all(20),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.content_copy_rounded, size: 22),
            label: Text(
              'Copy Data',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xFF475569),
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              side: BorderSide(color: Color(0xFFE2E8F0), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class BarcodeType {
  final String name;
  final Barcode barcode;
  final IconData icon;
  final Color color;

  BarcodeType(this.name, this.barcode, this.icon, this.color);
}
