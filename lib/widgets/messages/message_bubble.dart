import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  @override
  final Key key;
  final String message;
  final String userName;
  final String image_url;
  final bool isMe;
  const MessageBubble(this.message, this.userName, this.image_url, this.isMe,
      {required this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: !isMe
                        ? Colors.grey[300]
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: !isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(14),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(14),
                    ), // BorderRadius.only
                  ),
                  width: 140,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    ?.color,
                          ),
                        ), // Text
                        Text(
                          message,
                          style: TextStyle(
                            color: !isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    ?.color,
                          ),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                        ),
                      ])),
            ]),
        Positioned(
            top: 0,
            left: isMe ? 120 : null,
            right: !isMe ? 120 : null,
            child: CircleAvatar(backgroundImage: NetworkImage(image_url)))
      ],
    );
  }
}
