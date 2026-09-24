import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const AnimatedSearchBar(
          hintText: 'Search activity...',
          defaultTitle: Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildGraph(context),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final bool isPayment = index % 3 == 0;
                  final bool isYou = index % 2 == 0;
                  return AnimatedListItem(
                    index: index,
                    child: Column(
                      children: [
                        _buildActivityItem(isPayment, isYou, index),
                        if (index < 14) const Divider(height: 1, indent: 72),
                      ],
                    ),
                  );
                },
                childCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(BuildContext context) {
    return const FinancialLineChartCard();
  }

  Widget _buildActivityItem(bool isPayment, bool isYou, int index) {
    String title = '';
    String subtitle = '';
    String amount = '';
    IconData icon;
    Color iconBgColor;
    Color iconColor;

    if (isPayment) {
      icon = Icons.payments_rounded;
      iconColor = AppColors.success;
      iconBgColor = AppColors.success.withOpacity(0.1);
      if (isYou) {
        title = 'You paid Alex';
        subtitle = 'Bali Trip 2026 • Yesterday';
        amount = '\$25.00';
      } else {
        title = 'Sarah paid you';
        subtitle = 'Roommates • 2 days ago';
        amount = '\$12.50';
      }
    } else {
      icon = Icons.receipt_long_rounded;
      iconColor = AppColors.primary;
      iconBgColor = AppColors.primaryLight;
      if (isYou) {
        title = 'You added "Dinner at Jimbaran"';
        subtitle = 'Bali Trip 2026 • Yesterday';
        amount = '\$85.00';
      } else {
        title = 'Alex added "Groceries"';
        subtitle = 'Roommates • 3 days ago';
        amount = '\$45.20';
      }
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: isPayment ? AppColors.success : AppColors.textPrimary,
        ),
      ),
      onTap: () {},
    );
  }
}

class ChartDataPoint {
  final String day;
  final double withdraw;
  final double deposit;

  const ChartDataPoint({
    required this.day,
    required this.withdraw,
    required this.deposit,
  });
}

class FinancialLineChartCard extends StatefulWidget {
  const FinancialLineChartCard({super.key});

  @override
  State<FinancialLineChartCard> createState() => _FinancialLineChartCardState();
}

class _FinancialLineChartCardState extends State<FinancialLineChartCard> {
  int? _selectedIndex; // Currently inspected day index (null = weekly total)
  double? _dragDx; // Raw touch X position for fluid line tracking
  bool _showDeposit = true;
  bool _showWithdraw = true;

  final List<ChartDataPoint> _data = const [
    ChartDataPoint(day: 'Mon', withdraw: 45.0, deposit: 120.0),
    ChartDataPoint(day: 'Tue', withdraw: 95.0, deposit: 40.0),
    ChartDataPoint(day: 'Wed', withdraw: 30.0, deposit: 160.0),
    ChartDataPoint(day: 'Thu', withdraw: 140.0, deposit: 60.0),
    ChartDataPoint(day: 'Fri', withdraw: 65.0, deposit: 210.0),
    ChartDataPoint(day: 'Sat', withdraw: 110.0, deposit: 85.0),
    ChartDataPoint(day: 'Sun', withdraw: 40.0, deposit: 130.0),
  ];

  double get _totalWithdraw => _data.fold(0, (sum, item) => sum + item.withdraw);
  double get _totalDeposit => _data.fold(0, (sum, item) => sum + item.deposit);

  void _handleTouch(Offset localPosition, double boxWidth) {
    const double horizontalPadding = 12.0;
    final double chartWidth = boxWidth - (horizontalPadding * 2);
    final double dx = (localPosition.dx - horizontalPadding).clamp(0.0, chartWidth);
    final double fraction = dx / chartWidth;
    final int index = (fraction * (_data.length - 1)).round().clamp(0, _data.length - 1);

    setState(() {
      _dragDx = localPosition.dx.clamp(horizontalPadding, boxWidth - horizontalPadding);
      _selectedIndex = index;
    });
  }

  void _handleTouchEnd() {
    setState(() {
      _dragDx = null; // Snap line to discrete day column
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPoint = _selectedIndex != null ? _data[_selectedIndex!] : null;

    final String depositLabel = selectedPoint != null ? '${selectedPoint.day} Deposit' : 'Deposits';
    final String withdrawLabel = selectedPoint != null ? '${selectedPoint.day} Withdraw' : 'Withdraws';

    final double displayDeposit = selectedPoint != null ? selectedPoint.deposit : _totalDeposit;
    final double displayWithdraw = selectedPoint != null ? selectedPoint.withdraw : _totalWithdraw;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title & Time Period
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedPoint != null ? '${selectedPoint.day} Overview' : 'Weekly Overview',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      const Text('Cash Flow', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = null; // Reset selection to view full week total
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      selectedPoint != null ? 'Reset View' : 'This Week',
                      style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Stat Summary Cards (Deposit & Withdraw)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_showDeposit && !_showWithdraw) {
                          _showWithdraw = true;
                        } else {
                          _showDeposit = !_showDeposit;
                          if (!_showDeposit && !_showWithdraw) _showWithdraw = true;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _showDeposit ? AppColors.success.withOpacity(0.1) : AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _showDeposit ? AppColors.success.withOpacity(0.4) : AppColors.border,
                          width: _showDeposit ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_downward_rounded, color: AppColors.success, size: 16),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  depositLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '\$${displayDeposit.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.success),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_showWithdraw && !_showDeposit) {
                          _showDeposit = true;
                        } else {
                          _showWithdraw = !_showWithdraw;
                          if (!_showDeposit && !_showWithdraw) _showDeposit = true;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _showWithdraw ? AppColors.danger.withOpacity(0.1) : AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _showWithdraw ? AppColors.danger.withOpacity(0.4) : AppColors.border,
                          width: _showWithdraw ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_upward_rounded, color: AppColors.danger, size: 16),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  withdrawLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '\$${displayWithdraw.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.danger),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Line Chart Canvas
            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                return GestureDetector(
                  onPanStart: (details) => _handleTouch(details.localPosition, width),
                  onPanUpdate: (details) => _handleTouch(details.localPosition, width),
                  onPanEnd: (_) => _handleTouchEnd(),
                  onTapDown: (details) => _handleTouch(details.localPosition, width),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: DualLineChartPainter(
                        data: _data,
                        selectedIndex: _selectedIndex,
                        dragDx: _dragDx,
                        showDeposit: _showDeposit,
                        showWithdraw: _showWithdraw,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DualLineChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final int? selectedIndex;
  final double? dragDx;
  final bool showDeposit;
  final bool showWithdraw;

  DualLineChartPainter({
    required this.data,
    required this.selectedIndex,
    required this.dragDx,
    required this.showDeposit,
    required this.showWithdraw,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    const double bottomPadding = 28.0;
    const double topPadding = 16.0;
    const double horizontalPadding = 12.0;

    final double chartWidth = size.width - (horizontalPadding * 2);
    final double chartHeight = size.height - bottomPadding - topPadding;

    // Find max value across both series for scaling
    double maxVal = 100.0;
    for (final point in data) {
      if (showDeposit && point.deposit > maxVal) maxVal = point.deposit;
      if (showWithdraw && point.withdraw > maxVal) maxVal = point.withdraw;
    }
    maxVal *= 1.15; // 15% headroom

    // 1. Draw horizontal background grid lines
    final Paint gridPaint = Paint()
      ..color = AppColors.border.withOpacity(0.5)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 3; i++) {
      final double y = topPadding + (chartHeight / 3) * i;
      canvas.drawLine(
        Offset(horizontalPadding, y),
        Offset(size.width - horizontalPadding, y),
        gridPaint,
      );
    }

    // Coordinates calculation function
    Offset getOffset(int index, double value) {
      final double x = horizontalPadding + (index / (data.length - 1)) * chartWidth;
      final double y = topPadding + chartHeight * (1.0 - (value / maxVal));
      return Offset(x, y);
    }

    final List<Offset> depositPoints = [];
    final List<Offset> withdrawPoints = [];

    for (int i = 0; i < data.length; i++) {
      depositPoints.add(getOffset(i, data[i].deposit));
      withdrawPoints.add(getOffset(i, data[i].withdraw));
    }

    // Function to draw line & gradient fill
    void drawSeries(List<Offset> points, Color color) {
      if (points.isEmpty) return;

      final Path path = Path();
      path.moveTo(points.first.dx, points.first.dy);

      for (int i = 0; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        final control1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final control2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
        path.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, p1.dx, p1.dy);
      }

      // Fill area under curve
      final Path fillPath = Path.from(path);
      fillPath.lineTo(points.last.dx, size.height - bottomPadding);
      fillPath.lineTo(points.first.dx, size.height - bottomPadding);
      fillPath.close();

      final Paint fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.18),
            color.withOpacity(0.0),
          ],
        ).createShader(Rect.fromLTWH(0, topPadding, size.width, chartHeight));

      canvas.drawPath(fillPath, fillPaint);

      // Line stroke
      final Paint strokePaint = Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPath(path, strokePaint);

      // Node dots
      final Paint dotPaint = Paint()..color = color;
      final Paint innerDotPaint = Paint()..color = Colors.white;

      for (int i = 0; i < points.length; i++) {
        final bool isSelected = i == selectedIndex;
        final double radius = isSelected ? 5.0 : 3.0;
        canvas.drawCircle(points[i], radius, dotPaint);
        canvas.drawCircle(points[i], isSelected ? 2.5 : 1.5, innerDotPaint);
      }
    }

    // 2. Draw Series Lines
    if (showDeposit) {
      drawSeries(depositPoints, AppColors.success);
    }

    if (showWithdraw) {
      drawSeries(withdrawPoints, AppColors.danger);
    }

    // 3. Draw Vertical Moveable Guide Line
    double lineX;
    if (dragDx != null) {
      lineX = dragDx!;
    } else if (selectedIndex != null && selectedIndex! < data.length) {
      lineX = depositPoints[selectedIndex!].dx;
    } else {
      lineX = -1.0;
    }

    if (lineX >= 0) {
      final Paint linePaint = Paint()
        ..color = AppColors.primary.withOpacity(0.35)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(lineX, topPadding),
        Offset(lineX, size.height - bottomPadding),
        linePaint,
      );
    }

    // 4. Draw X-Axis Day Labels
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < data.length; i++) {
      final bool isSelected = i == selectedIndex;
      final Offset pt = depositPoints[i];

      textPainter.text = TextSpan(
        text: data[i].day,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(pt.dx - (textPainter.width / 2), size.height - bottomPadding + 8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant DualLineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.dragDx != dragDx ||
        oldDelegate.showDeposit != showDeposit ||
        oldDelegate.showWithdraw != showWithdraw ||
        oldDelegate.data != data;
  }
}



