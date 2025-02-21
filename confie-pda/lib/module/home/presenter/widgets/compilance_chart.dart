import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComplianceChart extends StatefulWidget {
  const ComplianceChart({Key? key}) : super(key: key);

  @override
  State<ComplianceChart> createState() => _ComplianceChartState();
}

class _ComplianceChartState extends State<ComplianceChart> {
  late List<ComplianceData> chartData;

  @override
  void initState() {
    super.initState();
    chartData = getChartData();
  }

  List<ComplianceData> getChartData() {
    return [
      ComplianceData('Conformidades', 75),
      ComplianceData('Não Conformidades', 25),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise de Conformidade'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Informações'),
                  content: const Text('Esta é a análise das conformidades e não conformidades na gestão de risco.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Fechar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCircularChart(
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              series: <CircularSeries>[
                DoughnutSeries<ComplianceData, String>(
                  dataSource: chartData,
                  xValueMapper: (ComplianceData data, _) => data.category,
                  yValueMapper: (ComplianceData data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Detalhes da Conformidade',
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Categoria')),
              DataColumn(label: Text('Percentual')),
            ],
            rows: chartData
                .map(
                  (data) => DataRow(cells: [
                    DataCell(Text(data.category)),
                    DataCell(Text('${data.value}%')),
                  ]),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ComplianceData {
  final String category;
  final double value;

  ComplianceData(this.category, this.value);
}
