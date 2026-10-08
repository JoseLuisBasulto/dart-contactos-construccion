import 'package:test/test.dart';
import '../bin/contacto.dart';
import '../bin/menus.dart';
import 'package:binary_tree/binary_tree.dart';

void main(){
  test('consultarContacto() devuelve el contacto consultado correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();
    final arbolPorFecha = BinaryTree<ContactoPorFecha>();

    ContactoPorNombre contactoN1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );
    ContactoPorFecha contactoF1 = ContactoPorFecha(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );
    ContactoPorNombre contactoN2 = ContactoPorNombre(
      "Joel", 
      DateTime(2000, 5, 14), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );
    ContactoPorFecha contactoF2 = ContactoPorFecha(
      "Joel", 
      DateTime(2000, 5, 14), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    agregarContacto(arbolPorNombre, arbolPorFecha, contactoN1, contactoF1);
    agregarContacto(arbolPorNombre, arbolPorFecha, contactoN2, contactoF2);

    expect(arbolPorNombre.isEmpty, false);
    expect(arbolPorFecha.isEmpty, false);
    expect(consultarContacto(arbolPorNombre, contactoN1), contactoN1);
    expect(consultarContacto(arbolPorNombre, contactoN2), contactoN2);
    expect(buscarPorFecha(arbolPorFecha, contactoF1.nombre), contactoF1);
    expect(buscarPorFecha(arbolPorFecha, contactoF2.nombre), contactoF2);
  });
}