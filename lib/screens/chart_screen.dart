import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final completedTasks =
        todoProvider.tasks.where((task) => task.isCompleted).length;
    final pendingTasks =
        todoProvider.tasks.where((task) => !task.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estadisticas de Tarea',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Gráfico de torta en una tarjeta
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: completedTasks.toDouble(),
                            color: Colors.green,
                            title: 'Completada',
                            radius: 80, // Tamaño de la sección
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: pendingTasks.toDouble(),
                            color: Colors.orange,
                            title: 'Pendiente',
                            radius: 80, // Tamaño de la sección
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        centerSpaceRadius:
                            40, // Espacio en el centro del gráfico
                        sectionsSpace: 2, // Espacio entre las secciones
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Leyenda en una tarjeta
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.square, color: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        'Completada',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.square, color: Colors.orange),
                      SizedBox(width: 5),
                      Text(
                        'Pendiente',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Texto de estadísticas en una tarjeta
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Completadas: $completedTasks, Pendientes: $pendingTasks',
                    style: TextStyle(fontSize: 16),
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
