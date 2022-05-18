import 'package:bloc/bloc.dart';

import 'client_events.dart';
import 'client_repository.dart';
import 'client_states.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _repository = ClientRepository();

  ClientBloc() : super(ClientInitialState()) {
    on<LoadClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(clients: _repository.load()),
      ),
    );
    on<AddClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(clients: _repository.add(event.client)),
      ),
    );
    on<RemoveClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(clients: _repository.remove(event.client)),
      ),
    );
  }
}
