import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sewa_villa/profile_matching.dart';
import 'package:sewa_villa/screens/villa_screen.dart';
import '../models/villa_model.dart';

class SearchScreen extends StatefulWidget {
  final int harga;
  final Position jarak;
  final int kapasitas;
  final Villa villa;

  SearchScreen(
    this.harga,
    this.jarak,
    this.kapasitas,
    this.villa,
  );

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;
  List<int> villaTerbaik = [];
  Villa villa;

  String formatCurrency(int value) {
    return NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp. ",
      decimalDigits: 0,
    ).format(value);
  }

  String formatDesimal(int value) {
    return NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    ).format(value);
  }

  Future<List<IndexPoint>> compare(
      int hargaUser, Position jarakUser, int kapasitasUser) async {
    var pm = new ProfileMatching(
      currentHarga: hargaUser,
      currentKapasitas: kapasitasUser,
      currentLatitude: jarakUser.latitude,
      currentLongitude: jarakUser.longitude,
      datas: villas,
    );
    await Future.delayed(Duration(seconds: 1));
    return await pm.perhitungan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<IndexPoint>>(
          future: compare(widget.harga, widget.jarak, widget.kapasitas),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(child: Text("Data error"));
            } else if (snapshot.hasData) {
              final villas = snapshot.data;
              var listView = ListView.builder(
                itemCount: villas.length,
                itemBuilder: (context, index) {
                  final villa = villas[index];
                  return ListTile(
                    title: Text(villa.villa.nama),
                    subtitle: Text(
                        "Jarak: ${formatDesimal(villa.jarak)} m    " +
                            "Harga: ${villa.harga}"),
                    trailing: Chip(label: Text(" ${villa.poin.toString()}")),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VillaScreen(
                            villa: villa.villa,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Harga"),
                            Text(formatCurrency(widget.harga)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Koordinat saat ini"),
                            Text(
                                "${widget.jarak.latitude}, ${widget.jarak.longitude}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Kapasitas"),
                            Text("${widget.kapasitas}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: listView,
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
