import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Pie extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Pie(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      behaviors: [charts.DatumLegend()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearCovid, String>> createSampleData(confirmed, deaths) {
    final data = [
      LinearCovid('C', confirmed),
      LinearCovid('D', deaths),
    ];

    return [
      new charts.Series<LinearCovid, String>(
        id: 'Deaths',
        domainFn: (LinearCovid sales, _) => sales.label,
        measureFn: (LinearCovid sales, _) => sales.qtde,
        data: data,
      )
    ];
  }
}

class LinearCovid {
  final String label;
  final int qtde;

  LinearCovid(this.label, this.qtde);
}
