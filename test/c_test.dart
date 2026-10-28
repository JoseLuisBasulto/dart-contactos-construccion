import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto_por_nombre.dart';
import 'package:dart_contactos_construccion/contacto_por_fecha.dart';
import 'package:dart_contactos_construccion/logica_de_archivos.dart';

void main() {
  // PRUEBA UNITARIA PARA LA REFACTORIZACIÓN 7
  group('Prueba para crear correctamente los árboles usando CSV fijo', () {
    
    test('Leer el archivo CSV existente e insertar correctamente los contactos en ambos árboles', () async {
      final arbolPorNombre = BinaryTree<ContactoPorNombre>();
      final arbolPorFecha = BinaryTree<ContactoPorFecha>();
      
      await crearArboles(arbolPorNombre, arbolPorFecha);

      var totalContactosNombre = 0;
      for (var _ in arbolPorNombre) {
        totalContactosNombre++;
      }

      var totalContactosFecha = 0;
      for (var _ in arbolPorFecha) {
        totalContactosFecha++;
      }
      
      expect(totalContactosNombre, equals(2));
      expect(totalContactosFecha, equals(2));

      expect(arbolPorNombre.isEmpty, false);
      expect(arbolPorFecha.isEmpty, false);

      var primerContacto = arbolPorNombre.first;
      var ultimoContacto = arbolPorNombre.last;

      expect(primerContacto.nombre, equals('Alejandro Osorno'));
      expect(ultimoContacto.nombre, equals('Fernando Osorno'));
    });
  });
}