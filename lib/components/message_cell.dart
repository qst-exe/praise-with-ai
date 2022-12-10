import 'package:flutter/material.dart';
import '/data/model/message.dart';

class MessageCell extends StatelessWidget {
  const MessageCell({required this.message, Key? key});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
        padding: const EdgeInsets.only(
            left: 10, top: 10, bottom: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            message.isSelf
                ? Container()
                : const Icon(
              Icons.account_box,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: message.isSelf ? 70 : 10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      message.isSelf
                          ? Container()
                          : Text(
                        'ほめのびくん',
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: message.isSelf
                            ? screenWidth - 200
                            : 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: message.isSelf
                            ? Colors.grey[200]
                            : Colors.pink[100],
                        borderRadius:
                        const BorderRadius.all(
                            Radius.circular(10))),
                    width: screenWidth - 100,
                    child: Text(
                      message.text,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

