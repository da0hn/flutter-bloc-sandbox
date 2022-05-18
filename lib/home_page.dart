import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/client_states.dart';

import 'client.dart';
import 'client_bloc.dart';
import 'client_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ClientBloc bloc;

  String _randomName() {
    final random = Random();

    final position = random.nextInt(4);

    return [
      'Sallyann',
      'Stormy Staab',
      'Arika Cotten',
      'Soyla Vickers',
      'Johnhenry Kerr',
    ].elementAt(position);
  }

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.sink.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Proof Of Concept'),
        actions: [
          IconButton(
            onPressed: () {
              final newClient = Client(name: _randomName());
              bloc.sink.add(AddClientEvent(client: newClient));
            },
            icon: const Icon(
              Icons.person_add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder<ClientState>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<ClientState> snapshot) {
            final clients = snapshot.data?.clients ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ListView.separated(
                itemCount: clients.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return _buildList(client, context);
                },
              ),
            );
          }),
    );
  }

  _buildList(Client client, context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: CircleAvatar(
        backgroundColor: _randomColor(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Text(
            client.name.substring(0, 1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        client.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.person_remove, color: Colors.red),
        onPressed: () {
          bloc.sink.add(RemoveClientEvent(client: client));
        },
      ),
    );
  }

  _randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
