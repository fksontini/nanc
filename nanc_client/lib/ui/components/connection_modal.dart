import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanc_client/logic/bloc/page_bloc.dart';
import 'package:nanc_client/logic/bloc/page_state.dart';
import 'package:tools/tools.dart';
import 'package:ui_kit/ui_kit.dart';

class ConnectionModal extends StatefulWidget {
  const ConnectionModal({super.key});

  @override
  State<ConnectionModal> createState() => _ConnectionModalState();
}

class _ConnectionModalState extends State<ConnectionModal> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size size = context.query.size;
    final PageBloc pageBloc = context.read();

    return Center(
      child: KitBaseModal(
        width: size.width - 50,
        header: null,
        body: Padding(
          padding: const EdgeInsets.only(top: Gap.extra, bottom: Gap.extra),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                KitTextField(
                  controller: context.read<PageBloc>().roomIdController,
                  isRequired: true,
                  placeholder: 'Paste NANC ID from the QR-code',
                  helper: 'Backend ID',
                  maxLines: 1,
                  validator: (String? roomId) {
                    final RegExp roomIdRegExp = RegExp(r'^.{30,}=?$');
                    final String? expiredError = pageBloc.validateRoomId();
                    if (expiredError != null) {
                      return expiredError;
                    }
                    if (roomId != null && roomId.isNotEmpty && roomIdRegExp.hasMatch(roomId)) {
                      return null;
                    }
                    if ((roomId ?? '').trim() == '') {
                      return 'Value is empty';
                    }
                    return 'Incorrect value';
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Gap.large),
                  child: BlocBuilder<PageBloc, PageState>(
                    builder: (BuildContext context, PageState state) {
                      String buttonText = 'Connect';
                      if (state.isConnectingToTheBackend) {
                        buttonText = 'Connecting...';
                      }
                      if (state.isConnectedToTheBackend) {
                        buttonText = 'Disconnect';
                      }

                      return KitRoundedButton(
                        expanded: true,
                        onPressed: state.isConnectingToTheBackend
                            ? null
                            : state.isConnectedToTheBackend
                                ? pageBloc.disconnect
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      return pageBloc.connectToBackend();
                                    }
                                  },
                        color: state.isConnectedToTheBackend ? context.theme.colorScheme.error : context.theme.colorScheme.primary,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: state.isConnectingToTheBackend
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: Gap.regular),
                                      child: SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          backgroundColor: context.theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                buttonText,
                                key: ValueKey(buttonText),
                                style: TextStyle(
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottom: null,
      ),
    );
  }
}

/*

                Expanded(
                  child: TextField(
                    controller: offerTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Paste connection info here',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 4),
                  child: IconButton(
                    onPressed: () async => rtcClientService.connectToBackend(offerTextController.text),
                    icon: const Icon(MdiIcons.connection),
                  ),
                ),
 */
