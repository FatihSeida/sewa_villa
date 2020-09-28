import 'package:sewa_villa/models/activity_model.dart';
import 'package:sewa_villa/profile_matching.dart';

import 'activity_model.dart';

class Villa {
  final String imageUrl;
  final String description;
  final String nama;
  final int harga;
  final int kapasitas;
  final List<String> fasilitas;
  final List<Activity> activities;
  final double latitude;
  final double longitude;
  int get fasilitasLength => fasilitas.length;

  const Villa({
    this.imageUrl,
    this.description,
    this.nama,
    this.harga,
    this.kapasitas,
    this.fasilitas,
    this.activities,
    this.latitude,
    this.longitude,
  });
}

List<Villa> villas = [
  Villa(
    nama: 'Villa Datuk Manglayang',
    imageUrl: 'assets/images/curugcimahi.jpg',
    description: 'Kunjungi untuk ketenangan untuk meditasi.',
    harga: 1000000,
    kapasitas: 120,
    latitude: -6.910925,
    longitude: 107.755293,
    fasilitas: ['Parkiran 4x4', 'Dapur'],
    activities: activities,
  ),
  Villa(
    nama: 'Villa 2',
    imageUrl: 'assets/images/curugcimahi.jpg',
    description: 'Kunjungi villa 1.',
    harga: 800000,
    kapasitas: 130,
    latitude: -6.811541,
    longitude: 107.622722,
    fasilitas: ['Parkiran 4x4', 'Dapur'],
    activities: activities,
  ),
  Villa(
    nama: 'Villa 3',
    imageUrl: 'assets/images/curugcimahi.jpg',
    description: 'Kunjungi villa 2.',
    harga: 1500000,
    kapasitas: 160,
    latitude: -6.924936,
    longitude: 107.717547,
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
