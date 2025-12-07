import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aurora_widgets.dart';
import 'constants.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const ActionButton({super.key, required this.label, this.icon, this.onPressed, this.isPrimary = true});

  @override
  Widget build(BuildContext context) {
    final buttonContent = icon != null
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        )
      : Text(label);

    return SizedBox(
      height: 60,
      width: double.infinity,
      child: isPrimary
          ? AuroraBorder(
              borderRadius: BorderRadius.circular(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: darkCharcoal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onPressed: onPressed,
                child: buttonContent,
              ),
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withAlpha(128)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onPressed: onPressed,
              child: buttonContent,
            ),
    );
  }
}
