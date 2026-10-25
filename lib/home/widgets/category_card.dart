import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modules/models.dart';
import 'view_all_button.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
    required this.category,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageOnLeft = index.isEven; 
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 363 / 198.04,
        child: LayoutBuilder(
          builder: (context, c) {
            final s = c.maxWidth / 363; 

            final textSide = Padding(
              padding: EdgeInsets.all(16 * s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
      SizedBox(
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            category.title,
            maxLines: 1,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 32 * s,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
                  ViewAllButton(
                    onTap: onTap,
                    arrowOnLeft: !imageOnLeft,
                    scale: s,
                  ),
                ],
              ),
            );

            return GestureDetector(
              onTap: onTap,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(24 * s),
                ),
                child: Stack(
                  children: [
                    
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: imageOnLeft ? 0 : null,
                      right: imageOnLeft ? null : 0,
                      width: c.maxWidth * 0.55,
                      child: Image.asset(
                        category.image,
                        fit: BoxFit.cover,
                        cacheWidth: 600,
                        alignment: imageOnLeft
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                      ),
                    ),
                    
                    Positioned.fill(
                      child: Row(
                        children: imageOnLeft
                            ? [
                                const Spacer(flex: 45),
                                Expanded(flex: 55, child: textSide),
                              ]
                            : [
                                Expanded(flex: 55, child: textSide),
                                const Spacer(flex: 45),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}