import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
      document: PdfDocument.openFile(pdfPath),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
