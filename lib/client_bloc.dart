import 'dart:async';

import 'client.dart';
import 'client_events.dart';
import 'client_repository.dart';
import 'client_states.dart';

class ClientBloc {
  final _repository = ClientRepository();

  final _inputClientController = StreamController<ClientEvent>();
  final _outputClientController = StreamController<ClientState>();

  Sink<ClientEvent> get sink => _inputClientController.sink;

  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_handleClientEvent);
  }

  void _handleClientEvent(ClientEvent event) {
    var clients = <Client>[];

    if (event is AddClientEvent) {
      clients = _repository.add(event.client);
    }
    if (event is LoadClientEvent) {
      clients = _repository.load();
    }
    if (event is RemoveClientEvent) {
      clients = _repository.remove(event.client);
    }
    _outputClientController.add(ClientSuccessState(clients: clients));
  }
}
