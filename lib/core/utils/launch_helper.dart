import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> openExternalUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  var ok = false;
  if (uri != null) {
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }
  }
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open the article.')),
    );
  }
}