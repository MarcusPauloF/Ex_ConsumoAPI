import 'package:consumo_servico_avancado/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _urlBase = Uri(
    scheme: "https",
    host: 'jsonplaceholder.typicode.com',
    path: "/posts",
  );

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(_urlBase);
    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];
    for (var post in dadosJson) {
      print("post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
    //print( postagens.toString() );
  }

  _post() async {
    var corpo = json.encode({
      "userId": 120,
      "id": null,
      "title": "Titulo5",
      "body": "Corpo da postagem5"
    });

    http.Response response = await http.post(_urlBase,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  _put(int id) async {
    var corpo = json.encode({
      "userId": 50,
      "id": id,
      "title": "Titulo alterado",
      "body": "Corpo da postagem alterado"
    });

    http.Response response = await http.put(Uri.parse("$_urlBase/$id"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  _patch() async {
    var corpo = json.encode({
      "userId": 20,
      "body": "Corpo da postagem alterado aaaaaa",
    });

    http.Response response = await http.patch(Uri.parse("$_urlBase/32"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  _delete() async {
    http.Response response = await http.patch(Uri.parse("$_urlBase/65"));

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Salvar"),
                  onPressed: _post,
                ),
                ElevatedButton(
                  child: Text("Atualizar"),
                  onPressed: () => _patch(),
                ),
                ElevatedButton(
                  child: Text("Remover"),
                  onPressed: _delete,
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("lista: Erro ao carregar ");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              List<Post>? lista = snapshot.data;
                              Post post = lista![index];

                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            });
                      }
                      break;
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
