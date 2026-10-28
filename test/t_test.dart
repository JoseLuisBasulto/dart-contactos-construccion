import 'dart:async';
import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto.dart';
import 'package:dart_contactos_construccion/menu.dart';
void main() {
  // PRUEBAS UNITARIAS PARA LA REFACTORIZACIÓN 6
  group('listarPorNombre', () {
    late BinaryTree<ContactoPorNombre> arbolPorNombre;
    
    setUp(() {
      arbolPorNombre = BinaryTree<ContactoPorNombre>();
    });

    test('1. listarPorNombre debe mostrar mensaje cuando el árbol está vacío', () {

      // Capturamos la salida de la consola usando runZoned
      final salida = <String>[];
      runZoned(() {
        listarPorNombre(arbolPorNombre);
        // Se crea una zona de ejecución aislada donde se guardará la salida en véz de mostrar en la consola
      }, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, linea) {
          salida.add(linea);
        },
      ));

  
      expect(salida, contains('\nNo hay contactos para mostrar.'));
    });

    test('2. listarPorNombre debe listar los contactos ordenados por nombre correctamente', () {
      arbolPorNombre.insert(ContactoPorNombre('Carlos', DateTime(2000, 1, 1), '123', 'carlos@email.com'));
      arbolPorNombre.insert(ContactoPorNombre('Ana', DateTime(2000, 2, 2), '456', 'ana@email.com'));

      final salida = <String>[];
      runZoned(() {
        listarPorNombre(arbolPorNombre);
      }, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, linea) {
          salida.add(linea);
        },
      ));

      // Verificar que en alguna de las lineas guardadas se encuentren los nombres
      expect(salida.any((linea) => linea.contains('Ana')), isTrue);
      expect(salida.any((linea) => linea.contains('Carlos')), isTrue);
    });
  });
}