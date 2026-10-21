import 'package:proyecto_curi/menu.dart';
import 'package:proyecto_curi/contacto_por_nombre.dart';
import 'package:proyecto_curi/contacto_por_fecha.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:proyecto_curi/logica_de_archivos.dart';

Future<void> main(List<String> arguments) async {
  final arbolPorNombre = BinaryTree<ContactoPorNombre>();
  final arbolPorFecha = BinaryTree<ContactoPorFecha>();

  // Esperar a que se llenen los árboles desde el archivo CSV
  await crearArboles(arbolPorNombre, arbolPorFecha);

  // Una vez cargados, mostrar el menú principal
  final menu = Menu(arbolPorNombre, arbolPorFecha);
  menu.empezar();
}
