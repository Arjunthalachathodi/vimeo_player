import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/bloc/bloc/vedio_player_bloc.dart';

class VimeoPlayerScreen extends StatelessWidget {
  const VimeoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VedioPlayerBloc()
        ..add(const VedioPlayerEvent.initializePlayer(videoId: '1173688059')),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Vimeo Video"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BlocBuilder<VedioPlayerBloc, VedioPlayerState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  ready: (WebViewController controller) {
                    return WebViewWidget(controller: controller);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
