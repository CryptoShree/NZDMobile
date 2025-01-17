import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_funds_bloc.freezed.dart';

class AddFundsBloc extends Bloc<AddFundsEvent, AddFundsState> {
  AddFundsBloc({
    required AddFundsRepository repository,
  })  : _repository = repository,
        super(const AddFundsState.initial()) {
    on<AddFundsEvent>(_eventHandler, transformer: sequential());
  }

  final AddFundsRepository _repository;

  EventHandler<AddFundsEvent, AddFundsState> get _eventHandler =>
      (event, emit) => event.map(
            urlRequested: (event) => _onUrlRequested(event, emit),
          );

  Future<void> _onUrlRequested(
    AddFundsUrlRequested event,
    Emitter<AddFundsState> emit,
  ) async {
    emit(const AddFundsState.processing());
    try {
      final url = await _repository.signFundsRequest(
        event.walletAddress,
        event.amount,
      );
      emit(AddFundsState.success(url));
    } on Exception catch (e) {
      emit(AddFundsState.failure(e));
    }
  }
}

@freezed
class AddFundsEvent with _$AddFundsEvent {
  const factory AddFundsEvent.urlRequested({
    required String walletAddress,
    required Amount amount,
  }) = AddFundsUrlRequested;
}

typedef AddFundsState = Flow<Exception, String>;
