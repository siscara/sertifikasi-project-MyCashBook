import 'package:crud_sisca/screen/history_page.dart';
import 'package:crud_sisca/screen/pemasukan_page.dart';
import 'package:crud_sisca/screen/pengeluaran_page.dart';
import 'package:crud_sisca/screen/setting_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FlSpot> chartDataPemasukan = [
    const FlSpot(1, 100000),
    const FlSpot(2, 150000),
    const FlSpot(3, 80000),
    const FlSpot(4, 20000),
    const FlSpot(5, 25000),
    const FlSpot(6, 25000),
    const FlSpot(7, 100000),
    const FlSpot(8, 300000),
    const FlSpot(9, 20000),
    const FlSpot(10, 70000),
    const FlSpot(11, 120000),
    const FlSpot(12, 70000),
  ];
  List<FlSpot> chartDataPengeluaran = [
    const FlSpot(1, 100000),
    const FlSpot(2, 120000),
    const FlSpot(3, 160000),
    const FlSpot(4, 10000),
    const FlSpot(5, 9000),
    const FlSpot(6, 8000),
    const FlSpot(7, 600000),
    const FlSpot(8, 10000),
    const FlSpot(9, 170000),
    const FlSpot(10, 2000),
    const FlSpot(11, 20000),
    const FlSpot(12, 21000),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Rangkuman Bulan Ini"),
              )),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1, child: Center(child: Text("Pengeluaran"))),
                    Expanded(flex: 3, child: Text("Rp. 1.000.000")),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1, child: Center(child: Text("Pengeluaran"))),
                    Expanded(flex: 3, child: Text("Rp. 1.000.000")),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(right: 20),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: const FlTitlesData(
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(spots: chartDataPemasukan),
                      LineChartBarData(
                          spots: chartDataPengeluaran, color: Colors.red),
                    ],
                  ),
                ),
              ),
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PemasukanPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset('assets/images/income.png'),
                        ),
                        const Text("Tambah Pemasukan")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PengeluaranPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset('assets/images/outcome.png'),
                        ),
                        const Text("Tambah Pengeluaran")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset('assets/images/history.png'),
                        ),
                        const Text("Detail Cash Flow")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset('assets/images/setting.png'),
                        ),
                        const Text("Pengaturan")
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
