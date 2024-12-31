import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_app/model/currency_model.dart';
import 'package:web_socket_app/view_model/home_view_model_states.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(HomeViewModelInitialState());

  static HomeViewModel get(context) => BlocProvider.of<HomeViewModel>(context);

  final Uri _bitcoinWebSocketUrl = Uri.parse("wss://stream.binance.com:9443/ws/btcusdt@trade");
  final Uri _ethereumWebSocketUrl = Uri.parse("wss://stream.binance.com:9443/ws/ethusdt@trade");

  WebSocketChannel get bitcoinWebSocketClient => WebSocketChannel.connect(_bitcoinWebSocketUrl);
  WebSocketChannel get ethereumWebSocketClient => WebSocketChannel.connect(_ethereumWebSocketUrl);

  CurrenyModel? bitcoinModel;
  CurrenyModel? ethereumModel;

  void listenToWebSocketStream() {
    bitcoinWebSocketClient.stream.listen((message) {
      bitcoinModel = CurrenyModel.fromJson(jsonDecode(message));

      emit(SuccessGetBitcoinDataFromStreamState());
    });

    ethereumWebSocketClient.stream.listen((message) {
      ethereumModel = CurrenyModel.fromJson(jsonDecode(message));

      emit(SuccessGetEthereumDataFromStreamState());
    });
  }

  void cancelListeningToStream() {
    bitcoinWebSocketClient.sink.close();
    ethereumWebSocketClient.sink.close();
    bitcoinModel = null;
    ethereumModel = null;

    emit(ReloadGetDataFromStreamState());
  }

  void reload() {
    cancelListeningToStream();
    listenToWebSocketStream();
  }
}
