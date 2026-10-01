import 'package:binary_tree/binary_tree.dart';
import 'package:csv/csv.dart';
import 'contacto.dart';
import 'dart:io';

/// Método 1: Crear árboles desde CSV
Future<void> crearArboles(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha,
) async {
  // Leer archivo CSV como string
  final csvString = await File('bin/contactos.csv').readAsString();

  // Decodificar CSV a lista de listas usando Csv
  final campos = Csv().decoder.convert(csvString);

  // Cabecera: Nombre, FechaNacimiento, Teléfono, CorreoElectronico
  for (var i = 1; i < campos.length; i++) {
    var fila = campos[i];

    String nombre = fila[0].toString();
    DateTime fechaNacimiento = DateTime.parse(fila[1].toString());
    String telefono = fila[2].toString();
    String correoElectronico = fila[3].toString();

    var contactoNombre = ContactoPorNombre(
      nombre,
      fechaNacimiento,
      telefono,
      correoElectronico,
    );
    var contactoFecha = ContactoPorFecha(
      nombre,
      fechaNacimiento,
      telefono,
      correoElectronico,
    );

    arbolPorNombre.insert(contactoNombre);
    arbolPorFecha.insert(contactoFecha);
  }
}

void guardarArboles(BinaryTree<ContactoPorNombre> arbolPorNombre) {
  // Cabecera
  List<List<dynamic>> rows = [
    ['Nombre', 'FechaNacimiento', 'Teléfono', 'CorreoElectronico'],
  ];

  // Recorrer árbol y agregar filas
  for (var contacto in arbolPorNombre) {
    rows.add([
      contacto.nombre,
      contacto.fechaNacimiento.toIso8601String().split('T')[0],
      contacto.telefono,
      contacto.correoElectronico,
    ]);
  }

  // Convertir lista a CSV string usando Csv (versión 8.x)
  String csvData = Csv().encoder.convert(rows);

  // Sobrescribir archivo original
  File('bin/contactos.csv').writeAsStringSync(csvData);
}
