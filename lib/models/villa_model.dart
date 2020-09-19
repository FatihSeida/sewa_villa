import 'package:sewa_villa/models/activity_model.dart';

import 'activity_model.dart';

class Villa {
  String imageUrl;
  String description;
  String nama;
  int harga;
  var jarakLat;
  var jarakLong;
  int kapasitas;
  List fasilitas;
  List<Activity> activities;

  Villa({
    this.imageUrl,
    this.description,
    this.nama,
    this.harga,
    this.jarakLat,
    this.jarakLong,
    this.kapasitas,
    this.fasilitas,
    this.activities,
  });
}

List<Villa> villas = [
  Villa(
    nama: 'Villa Datuk Manglayang',
    imageUrl: 'assets/images/curugcimahi.jpg',
    description: 'Kunjungi untuk ketenangan untuk meditasi.',
    harga: 1000000,
    kapasitas: 120,
    jarakLat: -6.910925,
    jarakLong: 107.755293,
    fasilitas: ['Parkiran 4x4', 'Dapur'],
    activities: activities,
  ),
];

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/hiking.jpg',
    name: 'Hiking Gunung Manglayang',
    type: 'Mencari Sunset & Sunrise',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 150000,
  ),
  Activity(
    imageUrl: 'assets/images/sepedahan.jpg',
    name: 'Sepedahan Daerah Lembang',
    type: 'Explore Kota Bandung',
    startTimes: ['07:00 am', '11:00 am'],
    rating: 4,
    price: 50000,
  ),
  Activity(
    imageUrl: 'assets/images/outbond.jpg',
    name: 'Outbond Cantigi Park',
    type: 'Bersenang - senang bersama keluarga',
    startTimes: ['07:30 am', '12:00 pm'],
    rating: 3,
    price: 100000,
  ),
];
