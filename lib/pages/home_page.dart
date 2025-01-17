import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:resolucao_handson_pokemon/pages/pokemon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 90, 166),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 90, 166),
        centerTitle: true,
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 203, 5),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Digite o nome do Pokemon:',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 203, 5),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 203, 5),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 203, 5),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  final dio = Dio();
                  var response = await dio.get(
                      'https://pokeapi.co/api/v2/pokemon/${controller.text}');
                  String name = response.data['name'];
                  String id = response.data['id'].toString();
                  String type = response.data['types'][0]['type']['name'];
                  String imageUrl = response.data['sprites']['front_default'];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PokemonPage(
                        imageUrl: imageUrl,
                        name: name,
                        id: id,
                        type: type,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 255, 203, 5),
                ),
                child: const Text(
                  'Pesquisar',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
