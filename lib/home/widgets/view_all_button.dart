import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAllButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool arrowOnLeft;
  final double scale;
  const ViewAllButton({
    super.key,
    required this.onTap,
    required this.arrowOnLeft,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 50 * scale,
      height: 50 * scale,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(
        arrowOnLeft ? Icons.chevron_left : Icons.chevron_right,
        color: Colors.white,
        size: 28 * scale,
      ),
    );

    final label = Text(
      'View All',
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 24 * scale,
        fontWeight: FontWeight.w500,
        height: 1.5, 
        letterSpacing: -0.022 * 24 * scale, 
      ),
    );

    final gap = SizedBox(width: 8 * scale);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF6B6B6B), 
          borderRadius: BorderRadius.circular(40 * scale),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: arrowOnLeft
              ? [circle, gap, label, SizedBox(width: 14 * scale)]
              : [SizedBox(width: 14 * scale), label, gap, circle],
        ),
      ),
    );
  }
}