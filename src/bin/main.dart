import 'menus.dart';
import 'contacto.dart';
import 'package:binary_tree/binary_tree.dart';
import 'logica_de_archivos.dart';

Future<void> main(List<String> arguments) async {
  final arbolPorNombre = BinaryTree<ContactoPorNombre>();
  final arbolPorFecha = BinaryTree<ContactoPorFecha>();

  // Esperar a que se llenen los árboles desde el archivo CSV
  await crearArboles(arbolPorNombre, arbolPorFecha);

  // Una vez cargados, mostrar el menú principal
  menuPrincipal(arbolPorNombre, arbolPorFecha);
}
