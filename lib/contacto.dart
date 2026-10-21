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
    return '  Nombre: $nombre\n  Cumpleaños: ${fechaNacimiento.day}/${fechaNacimiento.month}\n  Teléfono: $telefono\n  Correo Electrónico: $correoElectronico';
  }
}
