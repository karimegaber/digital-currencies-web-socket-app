import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_app/utils/home_table_widget.dart';
import 'package:web_socket_app/view_model/home_view_model.dart';
import 'package:web_socket_app/view_model/home_view_model_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel get _homeBloc => HomeViewModel.get(context);

  @override
  void initState() {
    super.initState();

    _homeBloc.listenToWebSocketStream();
  }

  @override
  void dispose() {
    _homeBloc.cancelListeningToStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("WebSocket App"),
      ),
      body: BlocBuilder<HomeViewModel, HomeViewModelStates>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// [Bitcoin]
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (_homeBloc.bitcoinModel == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bitcoin (BTC/USDT)",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Table(
                            children: [
                              currencyTitleRow(),
                              currencyValuesRow(
                                currency: _homeBloc.bitcoinModel!,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 50),

              /// [Ethereum]
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (_homeBloc.ethereumModel == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ethereum (ETH/USDT)",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Table(
                            children: [
                              currencyTitleRow(),
                              currencyValuesRow(
                                currency: _homeBloc.ethereumModel!,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              const Spacer(),

              /// [Reload Button]
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _homeBloc.reload();
                  },
                  child: const Text(
                    "Reload",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
