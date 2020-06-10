import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Bar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Bar(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  static List<charts.Series<OrdinalData, String>> createSampleData(bool isBlue) {
    final data = [
      OrdinalData('Jan', 10),
      OrdinalData('Fev', 25),
      OrdinalData('Mar', 60),
      OrdinalData('Abr', 125),
      OrdinalData('Mai', 140),
      OrdinalData('Jun', 167),
    ];

    return [
      new charts.Series<OrdinalData, String>(
        id: 'Sales',
        colorFn: (_, __) => isBlue ? charts.MaterialPalette.blue.shadeDefault : charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalData sales, _) => sales.month,
        measureFn: (OrdinalData sales, _) => sales.data,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalData {
  final String month;
  final int data;

  OrdinalData(this.month, this.data);
}