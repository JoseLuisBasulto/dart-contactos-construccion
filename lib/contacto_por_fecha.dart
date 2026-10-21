import 'contacto.dart';

class ContactoPorFecha extends Contacto
    implements Comparable<ContactoPorFecha> {
  ContactoPorFecha(
    super.nombre,
    super.fechaNacimiento,
    super.telefono,
    super.correoElectronico,
  );

  @override
  int compareTo(ContactoPorFecha other) =>
      fechaNacimiento.compareTo(other.fechaNacimiento);
}
