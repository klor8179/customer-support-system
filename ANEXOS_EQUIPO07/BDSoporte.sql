-- Crear base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS bdsoporte;
USE bdsoporte;

-- 1. Cliente
CREATE TABLE IF NOT EXISTS Cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  INDEX idx_email (email)  -- Índice para búsquedas por email
);

-- 2. Solicitud
CREATE TABLE IF NOT EXISTS Solicitud (
  id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
  fecha_registro DATE NOT NULL,
  tipo ENUM('ERROR','CAPACITACION','REQUERIMIENTO') NOT NULL,
  motivo TEXT NOT NULL,
  estado ENUM('ABIERTA','EN_PROCESO','CERRADA') DEFAULT 'ABIERTA',
  fk_cliente INT NOT NULL,
  FOREIGN KEY (fk_cliente) REFERENCES Cliente(id_cliente),
  INDEX idx_fecha_registro (fecha_registro)  -- Índice para filtros por fecha
);

-- 3. Colaborador
CREATE TABLE IF NOT EXISTS Colaborador (
  id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,  -- Email único
  rol ENUM('TECNICO','COORDINADOR','ADMIN') NOT NULL,
  INDEX idx_rol (rol)  -- Índice para filtros por rol
);

-- 4. Asignacion
CREATE TABLE IF NOT EXISTS Asignacion (
  id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
  coordinador BOOLEAN DEFAULT FALSE,
  fk_solicitud INT NOT NULL,
  fk_colaborador INT NOT NULL,
  FOREIGN KEY (fk_solicitud) REFERENCES Solicitud(id_solicitud),
  FOREIGN KEY (fk_colaborador) REFERENCES Colaborador(id_colaborador),
  UNIQUE KEY unique_asignacion (fk_solicitud, fk_colaborador)  -- Evita asignaciones duplicadas
);

-- 5. Actividad
CREATE TABLE IF NOT EXISTS Actividad (
  id_actividad INT AUTO_INCREMENT PRIMARY KEY,
  descripcion TEXT NOT NULL,
  tiempo_horas DECIMAL(5,2) NOT NULL CHECK (tiempo_horas > 0),  -- Validación de horas
  fecha_actividad DATE NOT NULL,
  fk_asignacion INT NOT NULL,
  FOREIGN KEY (fk_asignacion) REFERENCES Asignacion(id_asignacion),
  INDEX idx_fecha_actividad (fecha_actividad)  -- Índice para reportes por fecha
);