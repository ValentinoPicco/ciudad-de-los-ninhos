-- TRABAJO PRACTICO BASE DE DATOS: CIUDAD DE LOS NIÑOS
-- Autores: Levis Joaquin, Llorente Mateo, Picco Valentino.

CREATE SCHEMA IF NOT EXISTS ciudadninios;
SET search_path = "ciudadninios";

DROP TABLE IF EXISTS Aporte;
DROP TABLE IF EXISTS Tarj_Cred;
DROP TABLE IF EXISTS Trans_Deb;
DROP TABLE IF EXISTS Medio_Pago;
DROP TABLE IF EXISTS Programa;
DROP TABLE IF EXISTS Donante;
DROP TABLE IF EXISTS Auditoria;
DROP FUNCTION IF EXISTS funcion_auditoria;
DROP TABLE IF EXISTS Contacto;
DROP TABLE IF EXISTS MTelefono;
DROP TABLE IF EXISTS Padrino;

CREATE TABLE Padrino (
	dni INTEGER PRIMARY KEY CHECK (dni > 0),
	nom_y_ap VARCHAR(30) NOT NULL,
	direccion VARCHAR(20) NOT NULL,
	cp VARCHAR(8) NOT NULL,
	email VARCHAR(30) NOT NULL,
	facebook VARCHAR(20) NOT NULL,
	fecha_nac DATE NOT NULL
);

CREATE TABLE MTelefono (
 	dni INTEGER NOT NULL, 
	telefono VARCHAR(20) PRIMARY KEY,
	FOREIGN KEY (dni) REFERENCES Padrino(dni)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contacto (
	dni INTEGER NOT NULL,
	estado VARCHAR(20) NOT NULL,
	fecha_prim_cont DATE,
	fecha_alta DATE,
	fecha_baja DATE,
	fecha_adhesion DATE,
	fecha_rechazo DATE,
	FOREIGN KEY (dni) REFERENCES Padrino(dni)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT control_alta_baja CHECK (
		fecha_baja IS NULL OR fecha_baja >= fecha_alta
	)
);

CREATE TABLE Donante (
	dni INTEGER PRIMARY KEY,
	ocupacion VARCHAR(50),
	cuit_cuil VARCHAR(13) NOT NULL,	
	FOREIGN KEY (dni) REFERENCES Padrino(dni)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Auditoria (
	id_auditoria SERIAL PRIMARY KEY,
	dni_donante INTEGER,
	fecha_auditoria DATE
);

CREATE FUNCTION funcion_auditoria () returns trigger as 'begin insert into
auditoria (dni_donante, fecha_auditoria) values(old.dni,now());
return new;
end;'
LANGUAGE 'plpgsql';

CREATE TRIGGER trigger_auditoria AFTER DELETE ON donante FOR EACH ROW
EXECUTE PROCEDURE funcion_auditoria();

CREATE TABLE Programa (
	id_programa INTEGER PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	descripcion VARCHAR(150)
);

CREATE TABLE Medio_Pago (
	num_pago INTEGER PRIMARY KEY,
	nombre_titular VARCHAR(30) NOT NULL
);

CREATE TABLE Tarj_Cred (
	num_pago INTEGER PRIMARY KEY,
	num_tarj VARCHAR(25) NOT NULL,
	nombre VARCHAR(15) NOT NULL,
	fecha_vto DATE NOT NULL,
	FOREIGN KEY (num_pago) REFERENCES Medio_Pago(num_pago)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Trans_Deb (
	num_pago INTEGER PRIMARY KEY,
	num_cta INTEGER NOT NULL,
	cbu VARCHAR(22) NOT NULL,
	tipo_cta VARCHAR(20) NOT NULL,
	nom_suc_banco VARCHAR(50) NOT NULL,
	FOREIGN KEY (num_pago) REFERENCES Medio_Pago(num_pago)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Aporte (
	dni INTEGER NOT NULL,
	id_programa INTEGER NOT NULL,
	num_pago INTEGER NOT NULL,
	monto DECIMAL(9,2) NOT NULL CHECK (monto > 0),
	frecuencia TEXT CHECK (frecuencia IN ('semestral', 'mensual')) NOT NULL,
	FOREIGN KEY (dni) REFERENCES Donante(dni)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_programa) REFERENCES Programa(id_programa)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (num_pago) REFERENCES Medio_Pago(num_pago)
	ON DELETE CASCADE ON UPDATE CASCADE
);
