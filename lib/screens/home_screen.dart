import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/villa_model.dart';
import 'search_screen.dart';
import 'villa_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hargaController = TextEditingController();
  final kapasitasController = TextEditingController();
  final hargaFocus = FocusNode();
  final kapasitasFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  double distanceInMeters;
  int _selectedIndex = 0;
  int _currentTab = 0;
  Villa villa;

  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  bool enableButton = false;
  void validateInputs() {
    if (_formKey.currentState.validate() && locationSet) {
      _formKey.currentState.save();
      setState(() {
        enableButton = true;
      });
    } else {
      setState(() {
        enableButton = false;
      });
    }
  }

  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position currentPosition;
  bool get locationSet => currentPosition != null;
  bool loadingLocation = false;

  Future<void> getLocation() async {
    try {
      await geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) {
        setState(() {
          currentPosition = value;
        });
      });
    } catch (error) {
      print(error.message);
    }
  }

  String get location => locationSet
      ? '${currentPosition?.latitude}, ${currentPosition?.longitude}'
      : 'Lokasi tidak ada';

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).accentColor
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          _icons[index],
          size: 25,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).cursorColor;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 30),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Apa yang sedang kamu cari?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _icons
                      .asMap()
                      .entries
                      .map(
                        (MapEntry map) => _buildIcon(map.key),
                      )
                      .toList(),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  onChanged: validateInputs,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: hargaController,
                        focusNode: hargaFocus,
                        cursorColor: cursorColor,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Berapa Harga yang kamu inginkan?',
                          labelText: 'Harga',
                        ),
                        validator: (val) {
                          if (val.length > 0) {
                            return null;
                          } else {
                            return 'Isi form ini';
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(kapasitasFocus);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: kapasitasController,
                        focusNode: kapasitasFocus,
                        cursorColor: cursorColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Kapasitas yang kamu butuhkan?',
                          labelText: 'Kapasitas',
                        ),
                        validator: (val) {
                          if (val.length > 0) {
                            return null;
                          } else {
                            return 'Isi form ini';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Tentukan Lokasi: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    "${loadingLocation ? 'Loading Lokasi' : location}"),
                          ])),
                        ],
                      ),
                      ButtonBar(
                        children: [
                          !locationSet
                              ? RaisedButton(
                                  child: Text('Set Location'),
                                  onPressed: () {
                                    setState(() => loadingLocation = true);
                                    getLocation().then((_) {
                                      validateInputs();
                                      print(
                                          "${currentPosition.latitude}, ${currentPosition.longitude}");
                                      setState(() => loadingLocation = false);
                                    });
                                  },
                                )
                              : RaisedButton(
                                  child: Text('Clear Location'),
                                  onPressed: () {
                                    setState(() => currentPosition = null);
                                    validateInputs();
                                  },
                                ),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: !enableButton
                                ? null
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                            int.parse(hargaController.text),
                                            currentPosition,
                                            int.parse(kapasitasController.text),
                                            villa,
                                          );
                                        },
                                      ),
                                    );
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Villa Terbaik',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => print('Lihat Semua'),
                            child: Text(
                              'Lihat Semua',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: villas.length,
                        itemBuilder: (BuildContext context, int index) {
                          villa = villas[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VillaScreen(
                                  villa: villa,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              width: 210.0,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Positioned(
                                    bottom: 15.0,
                                    child: Container(
                                      height: 120.0,
                                      width: 200.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${villa.activities.length} Aktifitas',
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                            Text(
                                              villa.description,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Hero(
                                          tag: villa.nama,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image(
                                              height: 180.0,
                                              width: 180.0,
                                              image: AssetImage(villa.imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10.0,
                                          bottom: 10.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                villa.nama,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.dollarSign,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Text(
                                                    '${villa.harga}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (int value) {
            setState(() {
              _currentTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_pizza,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundImage: AssetImage('assets/images/hiking.jpg'),
              ),
              title: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
