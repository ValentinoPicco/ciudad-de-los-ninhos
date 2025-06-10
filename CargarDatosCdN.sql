-- TRABAJO PRACTICO BASE DE DATOS: CIUDAD DE LOS NIÑOS
-- Autores: Levis Joaquin, Llorente Mateo, Picco Valentino.

SET search_path = "ciudadninios";

-- Inserta padrinos
INSERT INTO Padrino (dni, nom_y_ap, direccion, cp, email, facebook, fecha_nac) VALUES
(44431267, 'Laura Martínez', 'Constitución 65', 'X5800', 'laura@mail.com', 'lauram', '1989-03-12'),
(28654276, 'Carlos Gómez', 'Av. Siempre Viva 742', '1100', 'carlos@mail.com', 'carlosg', '1983-06-21');


-- Inserta teléfonos
INSERT INTO MTelefono (dni, telefono) VALUES
(44431267, '011-12345678'),
(44431267, '011-87654321'),
(28654276, '011-11223344');


-- Inserta contactos
INSERT INTO Contacto (dni, estado, fecha_prim_cont, fecha_alta, fecha_baja, fecha_adhesion, fecha_rechazo) VALUES
(44431267, 'activo', '2024-01-10', '2024-01-15', NULL, '2024-01-20', NULL),
(28654276, 'inactivo', '2024-02-05', '2024-02-10', '2024-05-10', NULL, '2024-02-15');


-- Inserta donantes (tienen que ser padrinos)
INSERT INTO Donante (dni, ocupacion, cuit_cuil) VALUES
(44431267, 'Ingeniera', '27-10010010-1'),
(28654276, 'Abogado', '20-10020020-2');


-- Inserta programas
INSERT INTO Programa (id_programa, nombre, descripcion) VALUES
(1, 'Programa Escolar', 'Apoyo económico para útiles y matrícula escolar'),
(2, 'Salud Infantil', 'Colaboración para controles médicos y medicamentos'),
(3, 'Salud teen', 'Colaboración para controles médicos y medicamentos a adolescentes');


-- Inserta medios de pago
INSERT INTO Medio_Pago (num_pago, nombre_titular) VALUES
(1, 'Laura Martínez'),
(2, 'Carlos Gómez'),
(3, 'Carlos Gómez'),
(4, 'Carlos Gómez');


-- Inserta tarjeta de crédito
INSERT INTO Tarj_Cred (num_pago, num_tarj, nombre, fecha_vto) VALUES
(1, '4111111111111111', 'Laura Martínez', '2026-08-01');

-- Inserta transferencia bancaria
INSERT INTO Trans_Deb (num_pago, num_cta, cbu, tipo_cta, nom_suc_banco) VALUES
(2, 123456, '2850590940090412345678', 'Caja de Ahorro', 'Banco Nación Sucursal 1'),
(3, 789012, '2850590940090789012345', 'Cuenta Corriente', 'Banco Galicia Sucursal 3'),
(4, 789012, '2850590940090789012345', 'Cuenta Corriente', 'Banco Galicia Sucursal 3');


-- Inserta aportes
INSERT INTO Aporte (dni, id_programa, num_pago, monto, frecuencia) VALUES
(44431267, 1, 1, 5000.00, 'mensual'),
(28654276, 2, 2, 3000.00, 'semestral'),
(28654276, 1, 3, 4000.00, 'mensual'),
(28654276, 3, 4, 7000.00, 'mensual');
