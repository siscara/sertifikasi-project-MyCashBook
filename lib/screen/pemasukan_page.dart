import 'package:crud_sisca/model/transaction_model.dart';
import 'package:crud_sisca/screen/home_page.dart';
import 'package:crud_sisca/widget/card_input.dart';
import 'package:crud_sisca/widget/card_input_nominal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemasukanPage extends StatefulWidget {
  const PemasukanPage({super.key});

  @override
  State<PemasukanPage> createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  List<Transaction> listTransaksi = [];

  @override
  void initState() {
    getTransaction();
    super.initState();
  }

  getTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? transDecode = prefs.getString('list_tr');
    if (transDecode.toString().contains("null")) {
    } else {
      listTransaksi = Transaction.decode(transDecode.toString());
      setState(() {});
    }
  }

  addData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Transaction.encode(listTransaksi);
    await prefs.setString('list_tr', encodedData);
  }

  reset() {
    dateInput.text = "01/01/2021";
    nominalController.text = "";
    keteranganController.text = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pemasukan"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: TextField(
                  controller: dateInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Pilih Tanggal"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2024),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CardInputNominal(
                controller: nominalController,
                title: "Nominal",
                hint: "Masukkan Nominal",
                isObsecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CardInput(
                controller: keteranganController,
                title: "Keterangan",
                hint: "Masukkan keterangan",
                isObsecure: false,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black),
              onPressed: () {
                reset();
              },
              child: const Text("Reset"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.black),
              onPressed: () {
                listTransaksi.add(
                  Transaction(
                    date: dateInput.text,
                    type: "pemasukan",
                    notes: keteranganController.text.isEmpty
                        ? ""
                        : keteranganController.text,
                    nominal: int.parse(nominalController.text),
                  ),
                );
                addData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text("Simpan"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("<< Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
