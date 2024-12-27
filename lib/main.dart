import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const WaterConsumption(),
    ),
  );
}

class WaterConsumption extends StatefulWidget {
  const WaterConsumption({super.key});

  @override
  State<WaterConsumption> createState() => _WaterConsumptionState();
}

class _WaterConsumptionState extends State<WaterConsumption> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  String apiKey = '';

  /// Generates water consumption data for the chart.
  List<_ConsumptionData> _generateConsumptionData() {
    return <_ConsumptionData>[
      _ConsumptionData(1979, 1512.0, population: 7102100),
      _ConsumptionData(1980, 1506.0, population: 7071639),
      _ConsumptionData(1981, 1309.0, population: 7089241),
      _ConsumptionData(1982, 1382.0, population: 7109105),
      _ConsumptionData(1983, 1424.0, population: 7181224),
      _ConsumptionData(1984, 1465.0, population: 7234514),
      _ConsumptionData(1985, 1326.0, population: 7274054),
      _ConsumptionData(1986, 1351.0, population: 7319246),
      _ConsumptionData(1987, 1447.0, population: 7342476),
      _ConsumptionData(1988, 1484.0, population: 7353719),
      _ConsumptionData(1989, 1402.0, population: 7344175),
      _ConsumptionData(1990, 1424.0, population: 7335650),
      _ConsumptionData(1991, 1469.0, population: 7374501),
      _ConsumptionData(1992, 1369.0, population: 7428944),
      _ConsumptionData(1993, 1369.0, population: 7506166),
      _ConsumptionData(1994, 1358.0, population: 7570458),
      _ConsumptionData(1995, 1326.0, population: 7633040),
      _ConsumptionData(1996, 1298.0, population: 7697812),
      _ConsumptionData(1997, 1206.0, population: 7773443),
      _ConsumptionData(1998, 1220.0, population: 7858259),
      _ConsumptionData(1999, 1237.0, population: 7947660),
      _ConsumptionData(2000, 1240.0, population: 8008278),
      _ConsumptionData(2001, 1184.0, population: 8024963.5),
      _ConsumptionData(2002, 1136.0, population: 8041649),
      _ConsumptionData(2003, 1094.0, population: 8058334.5),
      _ConsumptionData(2004, 1100.0, population: 8075020),
      _ConsumptionData(2005, 1138.0, population: 8091705.5),
      _ConsumptionData(2006, 1069.0, population: 8108391),
      _ConsumptionData(2007, 1114.0, population: 8125076.5),
      _ConsumptionData(2008, 1098.0, population: 8141762),
      _ConsumptionData(2009, 1008.0, population: 8158447.5),
      _ConsumptionData(2010, 1039.0, population: 8175133),
      _ConsumptionData(2011, 1021.0, population: 8337995),
      _ConsumptionData(2012, 1009.0, population: 8463949),
      _ConsumptionData(2013, 1006.0, population: 8565546),
      _ConsumptionData(2014, 996.0, population: 8655309),
      _ConsumptionData(2015, 1009.0, population: 8736703),
      _ConsumptionData(2016, 1002.0, population: 8794605),
      _ConsumptionData(2017, 990.0, population: 8815448),
      _ConsumptionData(2018, 1008.0, population: 8826472),
      _ConsumptionData(2019, 987.0, population: 8824887),
      _ConsumptionData(2020, 981.0, population: 8804190),
      _ConsumptionData(2021, 979.0, population: 8467513),
      _ConsumptionData(2022, 999.0, population: 8335897),
      _ConsumptionData(2023, 997.0, population: 8825800),
    ];
  }

  /// Builds the Cartesian chart widget for visualizing the water consumption
  /// in New york with attractive and good looking UI.
  Widget _buildCartesianChart() {
    double? yMinimum;
    double? yMaximum;
    DateTime? xMinimum;
    DateTime? xMaximum;

    DateTimeAxis buildDateTimeAxis() {
      return DateTimeAxis(
        interval: 1,
        minimum: xMinimum,
        maximum: xMaximum,
        maximumLabels: 10,
        desiredIntervals: 10,
        autoScrollingDelta: 10,
        enableAutoIntervalOnZooming: false,
        intervalType: DateTimeIntervalType.years,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0.0),
        autoScrollingDeltaType: DateTimeIntervalType.years,
        plotBands: [
          PlotBand(
            opacity: 0.10,
            start: DateTime(2023, 12, 31),
          ),
        ],
        title: AxisTitle(
          text: 'Year',
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
      );
    }

    NumericAxis buildNumericAxis() {
      return NumericAxis(
        interval: 10.0,
        minimum: yMinimum,
        maximum: yMaximum,
        maximumLabels: 10,
        anchorRangeToVisiblePoints: true,
        enableAutoIntervalOnZooming: false,
        majorTickLines: const MajorTickLines(width: 0.0),
        majorGridLines: const MajorGridLines(
          dashArray: [4.0, 2.0],
          width: 0.0,
          color: Colors.red,
        ),
        title: AxisTitle(
          text: 'NYC Consumption (million gallons/day)',
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
      );
    }

    SplineSeries<_ConsumptionData, DateTime> buildSplineSeries() {
      return SplineSeries<_ConsumptionData, DateTime>(
        width: 5.0,
        animationDuration: 800.0,
        dataSource: _consumptionData,
        markerSettings: const MarkerSettings(isVisible: true),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        xValueMapper: (_ConsumptionData data, int index) => DateTime(data.year),
        yValueMapper: (_ConsumptionData data, int index) => data.consumption,
        onRendererCreated:
            (ChartSeriesController<_ConsumptionData, DateTime> controller) {
          _chartSeriesController = controller;
        },
        pointColorMapper: (_ConsumptionData data, int index) {
          return data.isPredictedData
              ? Colors.lightBlueAccent
              : Colors.blueAccent;
        },
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SfCartesianChart(
          title: ChartTitle(
            text: 'Water Consumption Prediction',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: _tooltipBehavior,
          onTooltipRender: (TooltipArgs tooltipArgs) {
            tooltipArgs.header = '';
            if (tooltipArgs.pointIndex != null) {
              final _ConsumptionData consumptionData =
                  _consumptionData[tooltipArgs.pointIndex!.toInt()];
              tooltipArgs.text =
                  'X: ${consumptionData.year}\nY: ${consumptionData.consumption.toInt()}';
            }
          },
          onActualRangeChanged: (ActualRangeChangedArgs rangeChangedArgs) {
            if (rangeChangedArgs.orientation == AxisOrientation.horizontal) {
              xMinimum = DateTime(_consumptionData.first.year);
              xMaximum = DateTime(_consumptionData.last.year);
              rangeChangedArgs.visibleMax = xMaximum?.millisecondsSinceEpoch;
            } else {
              yMinimum = _consumptionData
                  .map((_ConsumptionData data) => data.consumption)
                  .reduce((double a, double b) => a < b ? a : b);
              yMaximum = _consumptionData
                  .map((_ConsumptionData data) => data.consumption)
                  .reduce((double a, double b) => a > b ? a : b);
            }
          },
          primaryXAxis: buildDateTimeAxis(),
          primaryYAxis: buildNumericAxis(),
          series: <CartesianSeries<_ConsumptionData, DateTime>>[
            buildSplineSeries()
          ],
        );
      },
    );
  }

  /// Builds the customized AI prediction button.
  Widget _buildCustomAIButton(BuildContext context) {
    return Tooltip(
      message: 'Predicts future trends for next 20 years',
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _CustomAIButton(
        onPressed: () async {
          if (apiKey.isNotEmpty) {
            final String prompt = _generatePrompt();
            await _sendAIChatMessage(
              prompt,
              apiKey,
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'API Key is required.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  content: const Text(
                      'Kindly provide the API Key to predict the future data trend using AI.'),
                );
              },
            );
          }
        },
      ),
    );
  }

  /// Sets the loading state for asynchronous operations.
  void _setLoading(bool value) {
    if (mounted) {
      _isLoading.value = value;
    }
  }

  /// Generates the prompt to predict future trend for water consumption
  /// in New York based on historical data and population growth
  /// for next 20 years.
  String _generatePrompt() {
    final List<_ConsumptionData> items = <_ConsumptionData>[];
    final int length = _consumptionData.length - 1;

    for (int index = length; index >= 0; index--) {
      items.add(_consumptionData[index]);
    }
    final String reversedData =
        _consumptionData.reversed.map((_ConsumptionData data) {
      return '${data.year}: ${data.consumption}: ${data.population}';
    }).join('\n');

    String prompt = '''
    Predict New York City's water consumption for the next 20 years using historical consumption data (1979-2023) and city population trends as reference points. Your predictions should realistically reflect past trends and fluctuations, avoiding simple patterns like uniform increases, decreases, or irrelevant zig-zag patterns. Consider both historical consumption patterns and population growth when generating predictions. The x-axis corresponds to years, while the y-axis represents water consumption in million gallons per day. Do not provide data values for population but just consider the population too while predicting the future values for water consumption in New York city based on the historical city and water consumption growth. Please ensure that the following conditions are met for each predicted data point:\n\n
    $reversedData
    ''';

    prompt +=
        'and Output only the prediction in this format: "yyyy:yValue".  (yValue means consumption data in gallon). No explanations, headers, or additional text needed.\n';

    return prompt;
  }

  /// Sends the created prompt to the Google AI.
  /// Converts the response into chart data.
  /// Update the cartesian chart based on the predicted data.
  Future<void> _sendAIChatMessage(String prompt, String apiKey) async {
    _setLoading(true);

    try {
      final GenerativeModel model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey, // Replace your api key here to predict future data.
      );
      final ChatSession chat = model.startChat();

      final GenerateContentResponse response = await chat.sendMessage(
        Content.text(prompt),
      );

      final List<_ConsumptionData> aiRespondedDatas =
          _convertAIResponseToChartData(response.text);

      await _updateChartRangeWithDelay(aiRespondedDatas);
    } on Object catch (error) {
      debugPrint('error => $error');
    }
  }

  /// Converts AI response into chart data.
  List<_ConsumptionData> _convertAIResponseToChartData(String? data) {
    if (data == null || data.isEmpty) return [];

    List<_ConsumptionData> aiConsumptionData = [];

    final List<String> pairs = data.split('\n');

    for (final String pair in pairs) {
      final List<String> parts = pair.split(':');
      if (parts.length == 2) {
        final int year = int.parse(parts[0].trim());
        final double consumption = double.parse(parts[1].trim());
        aiConsumptionData
            .add(_ConsumptionData(year, consumption, isPredictedData: true));
      }
    }

    return aiConsumptionData;
  }

  /// Updates the chart data with a delay for animation effect.
  Future<void> _updateChartRangeWithDelay(List<_ConsumptionData> value) async {
    _setLoading(false);
    for (final _ConsumptionData item in value) {
      await Future.delayed(
        const Duration(milliseconds: 300),
        () {
          _consumptionData.add(item);
          _chartSeriesController.updateDataSource(
            addedDataIndexes: <int>[_consumptionData.length - 1],
          );
        },
      );
    }
  }

  late List<_ConsumptionData> _consumptionData;
  late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _consumptionData = _generateConsumptionData();

    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
    );
    _tooltipBehavior = TooltipBehavior(
      canShowMarker: false,
      enable: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _consumptionData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              _buildCartesianChart(),
              Positioned(
                top: 0,
                right: 20.0,
                child: _buildCustomAIButton(context),
              ),
              ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (BuildContext context, bool value, Widget? child) {
                  return Visibility(
                    visible: _isLoading.value,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAIButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _CustomAIButton({
    required this.onPressed,
  });

  @override
  State<_CustomAIButton> createState() => _CustomAIButtonState();
}

class _CustomAIButtonState extends State<_CustomAIButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: IconButton(
            onPressed: widget.onPressed,
            hoverColor: Colors.lightBlueAccent.shade100,
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.lightBlueAccent.shade100,
                    Colors.lightBlueAccent.shade700,
                    Colors.transparent,
                  ],
                  center: const Alignment(0.1, 0.1),
                  radius: 0.9,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(120, 25, 25, 112),
                    offset: Offset(8.0, 8.0),
                    blurRadius: 18.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(120, 255, 255, 255),
                    offset: Offset(-8.0, -8.0),
                    blurRadius: 18.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/ai_assist_view.png',
                  height: 30,
                  width: 40,
                  color: const Color.fromARGB(255, 0, 51, 102),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ConsumptionData {
  final int year;
  final double consumption;
  final bool isPredictedData;
  final double? population;

  _ConsumptionData(this.year, this.consumption,
      {this.isPredictedData = false, this.population});
}
