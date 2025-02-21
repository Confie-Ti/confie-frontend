import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:conformeia/module/home/infra/data/cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPdfScreen extends StatefulWidget {
  final Map<String, String> sector;

  const EditPdfScreen({super.key, required this.sector});

  @override
  _EditPdfScreenState createState() => _EditPdfScreenState();
}

class _EditPdfScreenState extends State<EditPdfScreen> {
  String? _selectedPdfPath;

  @override
  void initState() {
    super.initState();
    _selectedPdfPath = widget.sector['pdfPath'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_file),
                Text(_selectedPdfPath?.split('/').last ?? "Nenhum arquivo selecionado",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    )),
                TextButton(
                  onPressed: _selectPdf,
                  child: Text("Selecionar PDF"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updatePdf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Salvar',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdfPath = result.files.single.path;
      });
    }
  }

  void _updatePdf() async {
    if (_selectedPdfPath != null) {
      widget.sector['pdfPath'] = _selectedPdfPath!;
      await CacheManager().updateSector(widget.sector);

      // Navegar de volta para a tela anterior
      Navigator.pop(context);
    }
  }
}
