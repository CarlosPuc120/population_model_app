import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PopulationChart extends StatelessWidget {
  final List<double> data;

  PopulationChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: data
                .asMap()
                .entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                .toList(),
            isCurved: true,
            barWidth: 2,
            colors: [Colors.blue],
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
