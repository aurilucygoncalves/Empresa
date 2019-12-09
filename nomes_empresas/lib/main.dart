import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

final dummySnapshot = [
  {"name": "BP Biocombustíveis", "cnpj" : "4646456456463", "id" : 1},
  {"name": "Syngenta","cnpj" : "4656456456463", "id" : 2},
  {"name": "Gazin","cnpj" : "4646566456463", "id" : 3},
  {"name": "SEBRAE", "cnpj" : "4646476456463", "id" : 4},
  {"name": "Supergasbras", "cnpj" : "5946456456463", "id" : 5},
  {"name": "JV ENGENHARIA", "cnpj" : "6946456456463", "id" : 6},
  {"name": "Roche", "cnpj" : "7946456456463", "id" : 7},
  {"name": "Novo Nordisk Brasil", "cnpj" : "8946456456463", "id" : 8},
];

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Lista de Empresas',
      home: MyHomePage(),      
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Empresas')),
      body: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context){
    return _buildList(context, dummySnapshot);
  }

  Widget _buildList(BuildContext context, List<Map> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),      
    );
  }
  Widget _buildListItem(BuildContext context, Map data){
    final record = Record.fromMap(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.cnpj.toString()),
          onTap: () {},
        ),
      ),
    );
  }
}
class Record{
  final String name;
  final String cnpj;
  final int id;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['cnpj'] != null),
        assert(map['id'] != null),
        name = map['name'],
        cnpj = map['cnpj'],
        id = map['id'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Record<$name:$cnpj, $id>";          
}