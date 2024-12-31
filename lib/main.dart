import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
  late List<_WaterConsumptionData> _waterConsumptionData;
  late ChartSeriesController _chartSeriesController;
  late TooltipBehavior _tooltipBehavior;

  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);
  final String _apiKey = '';

  /// Generates water consumption data for the chart.
  List<_WaterConsumptionData> _generateWaterConsumptionData() {
    return <_WaterConsumptionData>[
      _WaterConsumptionData(
        year: 2004,
        waterConsumptionInGallons: 1100.0,
        population: 8075020,
      ),
      _WaterConsumptionData(
        year: 2005,
        waterConsumptionInGallons: 1138.0,
        population: 8091705.5,
      ),
      _WaterConsumptionData(
        year: 2006,
        waterConsumptionInGallons: 1069.0,
        population: 8108391,
      ),
      _WaterConsumptionData(
        year: 2007,
        waterConsumptionInGallons: 1114.0,
        population: 8125076.5,
      ),
      _WaterConsumptionData(
        year: 2008,
        waterConsumptionInGallons: 1098.0,
        population: 8141762,
      ),
      _WaterConsumptionData(
        year: 2009,
        waterConsumptionInGallons: 1008.0,
        population: 8158447.5,
      ),
      _WaterConsumptionData(
        year: 2010,
        waterConsumptionInGallons: 1039.0,
        population: 8175133,
      ),
      _WaterConsumptionData(
        year: 2011,
        waterConsumptionInGallons: 1021.0,
        population: 8337995,
      ),
      _WaterConsumptionData(
        year: 2012,
        waterConsumptionInGallons: 1009.0,
        population: 8463949,
      ),
      _WaterConsumptionData(
        year: 2013,
        waterConsumptionInGallons: 1006.0,
        population: 8565546,
      ),
      _WaterConsumptionData(
        year: 2014,
        waterConsumptionInGallons: 996.0,
        population: 8655309,
      ),
      _WaterConsumptionData(
        year: 2015,
        waterConsumptionInGallons: 1009.0,
        population: 8736703,
      ),
      _WaterConsumptionData(
        year: 2016,
        waterConsumptionInGallons: 1002.0,
        population: 8794605,
      ),
      _WaterConsumptionData(
        year: 2017,
        waterConsumptionInGallons: 990.0,
        population: 8815448,
      ),
      _WaterConsumptionData(
        year: 2018,
        waterConsumptionInGallons: 1008.0,
        population: 8826472,
      ),
      _WaterConsumptionData(
        year: 2019,
        waterConsumptionInGallons: 987.0,
        population: 8824887,
      ),
      _WaterConsumptionData(
        year: 2020,
        waterConsumptionInGallons: 981.0,
        population: 8804190,
      ),
      _WaterConsumptionData(
        year: 2021,
        waterConsumptionInGallons: 979.0,
        population: 8467513,
      ),
      _WaterConsumptionData(
        year: 2022,
        waterConsumptionInGallons: 999.0,
        population: 8335897,
      ),
      _WaterConsumptionData(
        year: 2023,
        waterConsumptionInGallons: 997.0,
        population: 8825800,
      ),
    ];
  }

  /// Builds the Cartesian chart widget for visualizing the water consumption
  /// in New york with attractive and good looking UI.
  Widget _buildCartesianChart() {
    DateTimeAxis buildDateTimeAxis() {
      return DateTimeAxis(
        interval: 1,
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
        interval: 20.0,
        maximumLabels: 10,
        anchorRangeToVisiblePoints: true,
        rangePadding: ChartRangePadding.additional,
        majorTickLines: const MajorTickLines(width: 0.0),
        title: AxisTitle(
          text: 'NYC Consumption (million gallons per day)',
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
      );
    }

    SplineSeries<_WaterConsumptionData, DateTime> buildSplineSeries() {
      return SplineSeries<_WaterConsumptionData, DateTime>(
        dataSource: _waterConsumptionData,
        xValueMapper: (_WaterConsumptionData waterConsumptionData, int index) {
          return DateTime(waterConsumptionData.year);
        },
        yValueMapper: (_WaterConsumptionData waterConsumptionData, int index) {
          return waterConsumptionData.waterConsumptionInGallons;
        },
        width: 5.0,
        markerSettings: const MarkerSettings(isVisible: true),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        onRendererCreated:
            (ChartSeriesController<_WaterConsumptionData, DateTime>
                chartSeriesController) {
          _chartSeriesController = chartSeriesController;
        },
        pointColorMapper:
            (_WaterConsumptionData waterConsumptionData, int index) {
          return waterConsumptionData.isAIPredicted
              ? Colors.lightBlueAccent
              : Colors.blueAccent;
        },
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SfCartesianChart(
          title: ChartTitle(
            text: 'Water Consumption Level in New York',
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          tooltipBehavior: _tooltipBehavior,
          onTooltipRender: (TooltipArgs tooltipArgs) {
            tooltipArgs.header = '';
            if (tooltipArgs.pointIndex != null) {
              final _WaterConsumptionData waterConsumptionData =
                  _waterConsumptionData[tooltipArgs.pointIndex!.toInt()];
              tooltipArgs.text =
                  '''X: ${waterConsumptionData.year}\nY: ${waterConsumptionData.waterConsumptionInGallons.toInt()}''';
            }
          },
          primaryXAxis: buildDateTimeAxis(),
          primaryYAxis: buildNumericAxis(),
          series: <CartesianSeries<_WaterConsumptionData, DateTime>>[
            buildSplineSeries()
          ],
        );
      },
    );
  }

  /// Builds the customized AI prediction button.
  Widget _buildAIButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Tooltip(
        message: 'Predicts future trends from 2024 - 2029',
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: _AIButton(
          onPressed: () async {
            if (_apiKey.isEmpty) return;

            final String prompt = _generatePrompt();
            await _sendAIChatMessage(prompt, _apiKey);
          },
        ),
      ),
    );
  }

  /// Generates the prompt to predict future trend for water consumption
  /// in New York based on historical data and population growth
  /// for next 05 years.
  String _generatePrompt() {
    final List<_WaterConsumptionData> items = <_WaterConsumptionData>[];
    final int length = _waterConsumptionData.length - 1;

    for (int index = length; index >= 0; index--) {
      items.add(_waterConsumptionData[index]);
    }
    final String reversedData = _waterConsumptionData.reversed.map(
      (_WaterConsumptionData data) {
        return '''${data.year}: ${data.waterConsumptionInGallons}: ${data.population}''';
      },
    ).join('\n');

    String prompt = '''
    Predict New York City's water consumption for the next 05 years (2024 - 2029)
    using the historical consumption data (2004-2023) and city population
    trends as references. Your predictions should realistically 
    reflect past trends and fluctuations, avoiding simple patterns like 
    uniform increases, decreases, or irrelevant zig-zag patterns. 
    Consider both historical consumption patterns and population growth 
    when generating predictions. The x-axis represents years, 
    while the y-axis represents water consumption in million gallons per day.
    Do not output any data values for population explicitly, but consider 
    the population growth in your predictions for water consumption
    in New York city based on historical city and water consumption growth.
    Ensure each predicted data point meets the following conditions:\n\n
    $reversedData
    ''';

    prompt += '''Output the predictions only in this format: "yyyy:yValue".
        (yValue represents consumption data in gallons).
        Do not include explanations, headers, or any additional text.\n''';

    return prompt;
  }

  /// Sends the created prompt to the Google AI.
  /// Converts the response into chart data.
  /// Update the cartesian chart based on the predicted data.
  Future<void> _sendAIChatMessage(String prompt, String apiKey) async {
    // Sets the loading state for asynchronous operations.
    if (mounted) {
      _isLoadingNotifier.value = true;
    }

    try {
      final GenerativeModel model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey, // Replace your api key here to predict future data.
      );
      final ChatSession chat = model.startChat();
      final GenerateContentResponse response = await chat.sendMessage(
        Content.text(prompt),
      );

      final List<_WaterConsumptionData> aiRespondedWaterConsumptionEntries =
          _convertAIResponseToChartData(response.text);

      await _updateChartRangeWithDelay(aiRespondedWaterConsumptionEntries);
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Some error has been occurred $error'),
          ),
        );
      }
    }
  }

  /// Converts AI response into chart data.
  List<_WaterConsumptionData> _convertAIResponseToChartData(String? data) {
    if (data == null || data.isEmpty) return [];

    final List<_WaterConsumptionData> aiConsumptionData = [];
    final List<String> pairs = data.split('\n');
    for (final String pair in pairs) {
      final List<String> parts = pair.split(':');
      if (parts.length == 2) {
        final int year = int.parse(parts[0].trim());
        final double consumption = double.parse(parts[1].trim());
        aiConsumptionData.add(
          _WaterConsumptionData(
            year: year,
            waterConsumptionInGallons: consumption,
            isAIPredicted: true,
          ),
        );
      }
    }

    return aiConsumptionData;
  }

  /// Updates the chart data with a delay for animation effect.
  Future<void> _updateChartRangeWithDelay(
      List<_WaterConsumptionData> waterConsumptionDataEntries) async {
    // Sets the loading state for asynchronous operations.
    if (mounted) {
      _isLoadingNotifier.value = false;
    }

    // Add the first data point without delay.
    _waterConsumptionData.add(waterConsumptionDataEntries.first);
    _chartSeriesController.updateDataSource(
      addedDataIndexes: <int>[_waterConsumptionData.length - 1],
    );

    // Delay for the rest of the data points.
    for (int i = 1; i < waterConsumptionDataEntries.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      _waterConsumptionData.add(waterConsumptionDataEntries[i]);
      _chartSeriesController.updateDataSource(
        addedDataIndexes: <int>[_waterConsumptionData.length - 1],
      );
    }
  }

  /// Builds the circular progress indicator while updating the predicted data.
  Widget _buildCircularProgressIndicator() {
    return ValueListenableBuilder(
      valueListenable: _isLoadingNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return Visibility(
          visible: _isLoadingNotifier.value,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _waterConsumptionData = _generateWaterConsumptionData();

    _tooltipBehavior = TooltipBehavior(
      canShowMarker: false,
      enable: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _waterConsumptionData.clear();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
            _buildCartesianChart(),
            _buildAIButton(context),
            _buildCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _AIButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AIButton({
    required this.onPressed,
  });

  @override
  State<_AIButton> createState() => _AIButtonState();
}

class _AIButtonState extends State<_AIButton>
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
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0.0, _animation.value),
          child: IconButton(
            onPressed: widget.onPressed,
            hoverColor: Colors.lightBlueAccent.shade100,
            icon: SizedBox(
              width: 50.0,
              height: 50.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      Colors.lightBlueAccent.shade100,
                      Colors.lightBlueAccent.shade700,
                      Colors.transparent,
                    ],
                    center: const Alignment(0.1, 0.1),
                    radius: 0.9,
                  ),
                  boxShadow: const <BoxShadow>[
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
          ),
        );
      },
    );
  }
}

class _WaterConsumptionData {
  _WaterConsumptionData({
    required this.year,
    required this.waterConsumptionInGallons,
    this.population,
    this.isAIPredicted = false,
  });

  final int year;
  final double waterConsumptionInGallons;
  final double? population;
  final bool isAIPredicted;
}
