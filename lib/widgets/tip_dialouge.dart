import 'package:flutter/material.dart';

class TipDialog extends StatefulWidget {
  @override
  _TipDialogState createState() => _TipDialogState();
}

class _TipDialogState extends State<TipDialog>
    with SingleTickerProviderStateMixin {
  String? selectedTip;
  bool autoAddTip = true;
  late AnimationController _controller;
  late Animation<double> _characterAnimation;
  bool showAnimation = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _characterAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showAnimation = false;
        });
      }
    });
  }

  void _playAnimation() {
    setState(() {
      showAnimation = true;
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0XFFEBEBEB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Thank you for adding a Tip!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "You've made their days! 100% of the tip will go to your delivery partner for this and future orders.",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/delivery_partner.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTipButton('20'),
                      SizedBox(width: 8),
                      _buildTipButton('30'),
                      SizedBox(width: 8),
                      _buildTipButton('50'),
                      SizedBox(width: 8),
                      _buildTipButton('Other'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          autoAddTip = !autoAddTip;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: autoAddTip ? Colors.deepOrange : Colors.white,
                          borderRadius: BorderRadius.circular(1),
                          border: Border.all(
                            color: autoAddTip
                                ? Colors.deepOrange
                                : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: autoAddTip
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : null,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            autoAddTip = !autoAddTip;
                          });
                        },
                        child: Text(
                          'Add this tip automatically to future orders',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (showAnimation)
                  Container(
                    height: 43,
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _characterAnimation,
                          builder: (context, child) {
                            return Positioned(
                              left: _characterAnimation.value *
                                  MediaQuery.of(context).size.width *
                                  0.8,
                              child: Transform.scale(
                                scale: 1,
                                child: Image.asset(
                                  'assets/images/character1.png',
                                  height: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipButton(String value) {
    bool isSelected = selectedTip == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedTip == value) {
            selectedTip = null;
          } else {
            selectedTip = value;
            _playAnimation();
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.deepOrange : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value != 'Other')
              Text(
                '₹',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontSize: 14,
                ),
              ),
            Text(
              value,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontSize: 14,
              ),
            ),
            if (isSelected && value != 'Other')
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
