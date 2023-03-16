create schema negocio;

use negocio;

-- Tabla de tipos de productos
CREATE TABLE tipos_de_productos (
  id INT PRIMARY KEY, -- Identificador único del tipo de producto
  nombre VARCHAR(50) -- Nombre del tipo de producto
);

-- Tabla de proveedores
CREATE TABLE proveedores (
  id INT PRIMARY KEY, -- Identificador único del proveedor
  nombre VARCHAR(50), -- Nombre del proveedor
  telefono VARCHAR(20) -- Teléfono del proveedor
);

-- Tabla de productos
CREATE TABLE productos (
  id INT PRIMARY KEY, -- Identificador único del producto
  nombre VARCHAR(100), -- Nombre del producto
  precio DECIMAL(10, 2), -- Precio del producto
  tipo_id INT, -- Identificador del tipo de producto al que pertenece
  proveedor_id INT, -- Identificador del proveedor del producto
  FOREIGN KEY (tipo_id) REFERENCES tipos_de_productos(id), -- Restricción de clave foránea para el tipo de producto
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) -- Restricción de clave foránea para el proveedor
);

-- Tabla de ventas
CREATE TABLE ventas (
  id INT PRIMARY KEY, -- Identificador único de la venta
  fecha DATE, -- Fecha en que se realizó la venta
  total DECIMAL(10, 2) -- Total de la venta
);

-- Tabla de detalles de ventas
CREATE TABLE detalles_de_ventas (
  id INT PRIMARY KEY, -- Identificador único del detalle de venta
  venta_id INT, -- Identificador de la venta a la que pertenece el detalle
  producto_id INT, -- Identificador del producto vendido en el detalle
  cantidad INT, -- Cantidad vendida del producto en el detalle
  precio DECIMAL(10, 2), -- Precio del producto en la venta
  FOREIGN KEY (venta_id) REFERENCES ventas(id), -- Restricción de clave foránea para la venta
  FOREIGN KEY (producto_id) REFERENCES productos(id) -- Restricción de clave foránea para el producto
);

-- Insertar algunos tipos de productos
INSERT INTO tipos_de_productos (id, nombre) VALUES
  (1, 'Alimentos'),
  (2, 'Bebidas'),
  (3, 'Limpieza');

-- Insertar algunos proveedores
INSERT INTO proveedores (id, nombre, telefono) VALUES
  (1, 'Pastelitos Pedrito', '+56 9 24575487'),
  (2, 'Mayorista Generation', '+56 9 26555387'),
  (3, 'Femit Industries', '+56 9 24598486');

-- Insertar algunos productos
INSERT INTO productos (id, nombre, precio, tipo_id, proveedor_id) VALUES
  (1, 'Arroz', 2.00, 1, 1),
  (2, 'porotos', 1500, 1, 2),
  (3, 'bebida generica', 1250, 2, 2),
  (4, 'Jabón', 2399, 3, 1),
  (5, 'Desinfectante', 1875, 3, 3);

-- Insertar algunas ventas
INSERT INTO ventas (id, fecha, total) VALUES
  (1, '2022-01-01', 5448),
  (2, '2022-01-15', 4124),
  (3, '2022-02-01', 2825);

-- Insertar detalles de ventas
INSERT INTO detalles_de_ventas (id, venta_id, producto_id, cantidad, precio) VALUES
  (1, 1, 1, 2, 1599),
  (2, 1, 2, 1, 999),
  (3, 1, 3, 3, 1250),
  (4, 2, 2, 2, 999),
  (5, 2, 4, 1, 2599),
  (6, 3, 1, 1, 1599),
  (7, 3, 5, 2, 1875);

-- Generamos las consultas

-- Seleccionamos las columnas que queremos obtener en el resultado:
-- El id del producto, el nombre del producto y el nombre del proveedor
SELECT p.id AS producto_id, p.nombre AS producto_nombre, pr.nombre AS proveedor_nombre
-- Especificamos de qué tablas vamos a obtener los datos, y les asignamos alias para abreviar:
FROM productos AS p
JOIN proveedores AS pr -- Realizamos un JOIN con la tabla de proveedores
ON p.proveedor_id = pr.id; -- Especificamos la condición de unión entre las tablas

-- Otra consulta
-- El id del producto, el nombre del producto y el nombre del proveedor
SELECT p.id AS producto_id, p.nombre AS producto_nombre, pr.nombre AS proveedor_nombre
-- Especificamos de qué tablas vamos a obtener los datos, y les asignamos alias para abreviar:
FROM productos AS p
JOIN proveedores AS pr -- Realizamos un JOIN con la tabla de proveedores
ON p.proveedor_id = pr.id; -- Especificamos la condición de unión entre las tablas

-- Ventas anuales
-- Seleccionamos el año de la venta usando la función YEAR() en la columna fecha de la tabla ventas
-- También calculamos la suma del total de la venta para cada año usando la función SUM() en la columna total de la tabla ventas
-- Y usamos el alias 'ventas_anuales' para el resultado de la consulta
SELECT YEAR(fecha) AS año, SUM(total) AS ventas_anuales
FROM ventas
-- Agrupamos los resultados por el año de la venta usando la función GROUP BY()
GROUP BY YEAR(fecha);

