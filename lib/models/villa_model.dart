import 'facilities_model.dart';

class Villa {
  String imageUrl;
  String description;
  int harga;
  int jarak;
  int kapasitas;
  List fasilitas;

  Villa({
    this.imageUrl,
    this.description,
    this.harga,
    this.jarak,
    this.kapasitas,
    this.fasilitas,
  });
}

List<Villa> villas = [
  Villa(
    imageUrl: 'assets/images/curugcimahi.jpg',
    description: 'Kunjungi untuk ketenangan untuk meditasi.',
    harga: 1000000,
    jarak: ,
    fasilitas: ['Parkiran 4x4','Dapur'],
  ),
];
