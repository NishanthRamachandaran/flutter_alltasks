import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors/default_colors.dart';

class QuickActionsGrid extends ConsumerStatefulWidget {
  const QuickActionsGrid({super.key});

  @override
  ConsumerState<QuickActionsGrid> createState() => _QuickActionsGridState();
}

class _QuickActionsGridState extends ConsumerState<QuickActionsGrid>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: AnimatedBorderPainter(
            animationValue: _animation.value,
            borderRadius: 16,        // radius stays constant
            strokeWidth: 2,          // border thickness stays constant
          ),
          child: Container(
            width: screenWidth * 0.90,
            height: screenHeight * 0.12,
            padding: const EdgeInsets.all(14),  // static padding
            decoration: BoxDecoration(
              color: DefaultColors.whiteF3,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: DefaultColors.grayCA,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(context, icon: Icons.swap_horiz, label: "Transfer"),
                _actionButton(context, icon: Icons.list, label: "Request"),
                _actionButton(context, icon: Icons.trending_up, label: "Stocks"),
                _actionButton(context, icon: Icons.auto_awesome, label: "Products"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton(BuildContext context, {required IconData icon, required String label}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.12,
          height: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: DefaultColors.blue_0,
            borderRadius: BorderRadius.circular(12), // static radius
          ),
          child: Center(
            child: Icon(
              icon,
              size: screenWidth * 0.06, // MEDIAQUERY applied
              color: DefaultColors.black,
            ),
          ),
        ),

        const SizedBox(height: 6), // static padding

        SizedBox(
          width: screenWidth * 0.15,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,  
              color: DefaultColors.black,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedBorderPainter extends CustomPainter {
  final double animationValue;
  final double borderRadius;
  final double strokeWidth;

  AnimatedBorderPainter({
    required this.animationValue,
    required this.borderRadius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics().first;
    final totalLength = pathMetrics.length;

    final segmentLength = totalLength * 0.25;
    final centerPoint = (animationValue * totalLength) % totalLength;

    final startPoint = (centerPoint - segmentLength / 2) % totalLength;
    final endPoint   = (centerPoint + segmentLength / 2) % totalLength;

    Path animatedPath;
    if (endPoint > startPoint) {
      animatedPath = pathMetrics.extractPath(startPoint, endPoint);
    } else {
      animatedPath = pathMetrics.extractPath(startPoint, totalLength);
      animatedPath.addPath(pathMetrics.extractPath(0, endPoint), Offset.zero);
    }

    final tangent = pathMetrics.getTangentForOffset(centerPoint);
    final centerPos = tangent?.position ?? Offset.zero;

    final gradientStart = Offset(centerPos.dx - segmentLength / 2, centerPos.dy);
    final gradientEnd   = Offset(centerPos.dx + segmentLength / 2, centerPos.dy);

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          DefaultColors.blueLightBase.withOpacity(0.0),
          DefaultColors.blueLightBase.withOpacity(0.4),
          DefaultColors.blueLightBase.withOpacity(0.8),
          DefaultColors.blueLightBase,
          DefaultColors.blueLightBase.withOpacity(0.8),
          DefaultColors.blueLightBase.withOpacity(0.4),
          DefaultColors.blueLightBase.withOpacity(0.0),
        ],
        stops: const [0, 0.15, 0.3, 0.5, 0.7, 0.85, 1],
      ).createShader(Rect.fromPoints(gradientStart, gradientEnd))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedBorderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
