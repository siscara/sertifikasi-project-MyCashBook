import 'package:crud_sisca/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Transaction> listTransaksi = [];

  @override
  void initState() {
    getTransaction();
    super.initState();
  }

  getTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? transDecode = prefs.getString('list_tr');
    final String? action = prefs.getString('password');
    print(action);
    if (transDecode.toString().contains("null")) {
    } else {
      listTransaksi = Transaction.decode(transDecode.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Cash Flow"),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: listTransaksi.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  trailing: listTransaksi[index].type == "pemasukan"
                      ? const Icon(Icons.arrow_back_ios)
                      : const Icon(Icons.arrow_forward_ios),
                  title: Text(
                    "${listTransaksi[index].type == "pemasukan" ? "+" : "-"} ${convertNominal(listTransaksi[index].nominal)}",
                  ),
                  subtitle: listTransaksi[index].notes.isEmpty
                      ? Text(listTransaksi[index].date)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listTransaksi[index].notes),
                            Text(listTransaksi[index].date),
                          ],
                        ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("kembali"),
          )
        ],
      ),
    );
  }
}
