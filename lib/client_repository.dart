import 'client.dart';

class ClientRepository {
  final List<Client> _clients = [];

  List<Client> load() {
    _clients.addAll([
      Client(name: 'Gabriel'),
      Client(name: 'João'),
      Client(name: 'Aurora'),
      Client(name: 'Bruno'),
      Client(name: 'Nathally')
    ]);
    return _clients;
  }

  List<Client> add(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> remove(Client client) {
    _clients.remove(client);
    return _clients;
  }
}
