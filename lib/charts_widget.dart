import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

enum ChartType { pie, line }

class ChartWidget extends StatelessWidget {
  final ChartType chartType;
  final String title;

  const ChartWidget({
    super.key,
    required this.chartType,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Expanded(
          child: chartType == ChartType.pie
              ? PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.green,
                        value: 70,
                        title: 'Completed',
                      ),
                      PieChartSectionData(
                        color: Colors.red,
                        value: 30,
                        title: 'Failed',
                      ),
                    ],
                  ),
                )
              : LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 30),
                          const FlSpot(1, 35),
                          const FlSpot(2, 40),
                          const FlSpot(3, 32),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
