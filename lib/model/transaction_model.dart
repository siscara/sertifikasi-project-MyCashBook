import 'dart:convert';

import 'package:intl/intl.dart';

class Transaction {
  String date;
  String type;
  String notes;
  int nominal;
  Transaction({
    required this.date,
    required this.type,
    required this.notes,
    required this.nominal,
  });
  factory Transaction.fromJson(Map<String, dynamic> jsonData) {
    return Transaction(
      date: jsonData['date'],
      type: jsonData['type'],
      notes: jsonData['notes'],
      nominal: jsonData['nominal'],
    );
  }

  static Map<String, dynamic> toMap(Transaction trans) => {
        'date': trans.date,
        'type': trans.type,
        'notes': trans.notes,
        'nominal': trans.nominal,
      };

  static String encode(List<Transaction> transaction) => json.encode(
        transaction
            .map<Map<String, dynamic>>((trans) => Transaction.toMap(trans))
            .toList(),
      );

  static List<Transaction> decode(String transaction) =>
      (json.decode(transaction) as List<dynamic>)
          .map<Transaction>((item) => Transaction.fromJson(item))
          .toList();
}

String convertNominal(int nominal) {
  final convert = NumberFormat("#,##0.00", "id");
  return "Rp ${convert.format(nominal)}";
}

List<Transaction> listTransaksiasd = [
  Transaction(
    date: "10/10/2023",
    type: "pemasukan",
    notes: "",
    nominal: 1000000,
  ),
  Transaction(
    date: "11/11/2023",
    type: "pemasukan",
    notes: "",
    nominal: 2000000,
  ),
  Transaction(
    date: "12/12/2023",
    type: "pengeluaran",
    notes: "Beli Course Flutter",
    nominal: 1500000,
  ),
];
