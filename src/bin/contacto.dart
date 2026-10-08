class Contacto {
  String nombre;
  DateTime fechaNacimiento;
  String telefono;
  String correoElectronico;

  Contacto(
    this.nombre,
    this.fechaNacimiento,
    this.telefono,
    this.correoElectronico,
  );

  //Hay que modificar el toString para que muestre la fecha de nacimiento en formato DD/MM y tenga mejor formato
  @override
  String toString() {
    return '  \n\nNombre: $nombre\n  Cumpleaños: ${fechaNacimiento.day}/${fechaNacimiento.month}\n  Teléfono: $telefono\n  Correo Electrónico: $correoElectronico';
  }
}

// Estas clases son para poder usar el mismo tipo de dato en los dos árboles, pero con diferentes criterios de comparación
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
