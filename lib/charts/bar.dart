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

  static List<charts.Series<OrdinalData, String>> createSampleData(bool isBlue, Map data) {
    final dataChart = [
      OrdinalData('NO', data['NO']),
      OrdinalData('NE', data['NE']),
      OrdinalData('CO', data['CO']),
      OrdinalData('SD', data['SD']),
      OrdinalData('SU', data['SU']),
    ];

    return [
      new charts.Series<OrdinalData, String>(
        id: 'Sales',
        colorFn: (_, __) => isBlue ? charts.MaterialPalette.blue.shadeDefault : charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalData sales, _) => sales.month,
        measureFn: (OrdinalData sales, _) => sales.data,
        data: dataChart,
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