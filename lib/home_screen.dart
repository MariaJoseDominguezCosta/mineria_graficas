import 'package:flutter/material.dart';
import 'charts_widget.dart';
import 'chat_bot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Printing Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Sección de gráficas y estadísticas
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Gráficas en la parte superior
                  const Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ChartWidget(
                              chartType: ChartType.pie,
                              title: 'Completed Prints',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ChartWidget(
                              chartType: ChartType.line,
                              title: 'Temperature',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bloques de estadísticas en la parte inferior
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Finished Jobs',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 8),
                                Text('Actual Income'),
                                SizedBox(height: 8),
                                Text('Predicted Income'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Send Print Job',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Sección del chatbot
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const ChatBot(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
