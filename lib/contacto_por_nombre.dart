import 'contacto.dart';

class ContactoPorNombre extends Contacto
    implements Comparable<ContactoPorNombre> {
  ContactoPorNombre(
    super.nombre,
    super.fechaNacimiento,
    super.telefono,
    super.correoElectronico,
  );

  @override
  int compareTo(ContactoPorNombre other) => nombre.compareTo(other.nombre);
}
