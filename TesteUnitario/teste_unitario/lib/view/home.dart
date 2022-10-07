import 'dart:async';
import 'package:teste_unitario/controller/buscaCEP.dart';
import 'package:teste_unitario/model/estado.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Estado> novoEstado;
  late int id = 37701000;
  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    novoEstado = buscarCEP(http.Client());
  }

  void refresh() => setState(() {
        novoEstado = buscarNovoCEP(id.toString());
      });

  void outroCEP() => setState(() {
        id++;
        if (id >= 37701008) {
          id = 37701008;
        }
      });
  void antesCEP() => setState(() {
        id--;
        if (id <= 37700999) {
          id = 37701000;
        }
      });
  List<Color> background = [
    const Color.fromARGB(255, 125, 188, 190),
    const Color.fromRGBO(69, 123, 157, 1),
    const Color.fromRGBO(29, 53, 87, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: background,
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft)),
          child: Center(
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.only(top: 150, bottom: 20),
                  child: Text(
                    'Busca\nCEP',
                    style: titleStyle,
                  )),
              FutureBuilder<Estado>(
                future: novoEstado,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return outputCard(snapshot.data!.localidade,
                        snapshot.data!.ibge, snapshot.data!.cep);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              navigationButtons()
            ]),
          ),
        ),
      ),
    );
  }

  Widget outputCard(String title, String id, String userId) {
    TextStyle nameStyle =
        GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600);

    TextStyle contentStyle = GoogleFonts.openSans(fontWeight: FontWeight.w400);

    return SizedBox(
      width: 200,
      height: 200,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              SizedBox(
                  width: 220,
                  height: 80,
                  child: AutoSizeText(
                    maxLines: 2,
                    title,
                    style: nameStyle,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Id: $id',
                  style: contentStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'User id: $userId',
                  style: contentStyle,
                ),
              ),
            ])),
      ),
    );
  }

  Widget navigationButtons() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {antesCEP(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_left_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {outroCEP(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_right_outlined),
            ),
          ),
        ]));
  }
}
