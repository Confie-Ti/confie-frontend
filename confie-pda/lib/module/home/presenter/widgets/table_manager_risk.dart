import 'package:conformeia/core/extensions/build_context_utils.dart';
import 'package:conformeia/core/styles/colors.dart';
import 'package:conformeia/module/home/infra/data/cache_manager.dart';
import 'package:conformeia/module/home/presenter/screens/edit_pdf_screen.dart';
import 'package:conformeia/module/home/presenter/screens/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class TableManagerRisk extends StatefulWidget {
  const TableManagerRisk({super.key});

  @override
  State<TableManagerRisk> createState() => _TableManagerRiskState();
}

class _TableManagerRiskState extends State<TableManagerRisk> {
  final int rowsPerPage = 6;
  int currentPage = 0;

  final List<Map<String, String>> data = [];

  @override
  void initState() {
    super.initState();
    _loadSectors();
  }

  void _loadSectors() async {
    try {
      final sectors = await CacheManager().getSectors();
      setState(() {
        data.addAll(sectors);
      });
    } catch (e) {
      print("Erro ao carregar setores: $e");
    }
  }

Future<void> _downloadPdf(String pdfPath) async {
  try {
    final file = File(pdfPath);
    
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Arquivo PDF não encontrado no caminho fornecido.')),
      );
      return;
    }
    
    final directory = await getApplicationDocumentsDirectory();
    final fileName = path.basename(pdfPath);
    final newFile = File(path.join(directory.path, fileName));
    await newFile.writeAsBytes(await file.readAsBytes());
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF baixado em: ${newFile.path}')),
    );
  } catch (e) {
    print("Erro ao baixar PDF: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao baixar PDF')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: context.mediaWidth * 1.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFEFEFE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: context.mediaWidth * 0.9,
                  ),
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFFF2F5FA)),
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    dataRowHeight: 56,
                    headingRowHeight: 56,
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Numero do Setor',
                        style: TextStyle(
                            color: Color(0xFF6E7D87),
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Nome',
                        style: TextStyle(
                            color: Color(0xFF6E7D87),
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Descricao',
                        style: TextStyle(
                            color: Color(0xFF6E7D87),
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Ações',
                        style: TextStyle(
                            color: Color(0xFF6E7D87),
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                    rows: _getCurrentPageRows(),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPaginationControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _getCurrentPageRows() {
    int startIndex = currentPage * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;

    return data
        .sublist(startIndex, endIndex > data.length ? data.length : endIndex)
        .map((row) => _buildDataRow(row))
        .toList();
  }

  DataRow _buildDataRow(Map<String, String> row) {
    return DataRow(cells: [
      DataCell(Text(row['sectorNumber']!,
          style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF2C3A4B)))),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(row['name']!,
            style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF2C3A4B))),
      )),
      DataCell(Text(row['description']!,
          style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF2C3A4B)))),
      DataCell(Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(pdfPath: row['pdfPath']!),
                ),
              );
            },
            child: Text('Ver Estrutura',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPdfScreen(sector: row),
                ),
              );
            },
            child: Text('Substituir Estrutura',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => _downloadPdf(row['pdfPath']!),
            child: Text('Baixar Estrutura',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
          ),
        ],
      )),
    ]);
  }

  Widget _buildPaginationControls() {
    int totalPages = (data.length / rowsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  currentPage == index ? AppColors.primary : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                currentPage = index;
              });
            },
            child: Text(
              '${index + 1}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
