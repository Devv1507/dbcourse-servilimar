-- =============================================================================
-- SCRIPT DML PARA EL SISTEMA DE TURNOS LIMAR (PostgreSQL)
-- =============================================================================

-- SECCIÓN 1: Inserción en tablas sin dependencias externas

INSERT INTO special_condition (condition_id, condition_name) VALUES
    (1, 'Adulto Mayor'),
    (2, 'Embarazo'),
    (3, 'Requiere Silla de Ruedas'),
    (4, 'Discapacidad Visual'),
    (5, 'Discapacidad Auditiva'),
    (6, 'Condición Postoperatoria'),
    (7, 'Enfermedad Crónica'),
    (8, 'Requiere Asistencia Especial'),
    (9, 'Sindrome de Down'),
    (10, 'Grupo Cancer');

INSERT INTO city (city_id, city_name, post_code) VALUES
    (1, 'Bogota', '110111'),
    (2, 'Medellin', '050015'),
    (3, 'Cali', '760001'),
    (4, 'Barranquilla', '080001'),
    (5, 'Cartagena', '130001'),
    (6, 'Bucaramanga', '680001'),
    (7, 'Cucuta', '540001'),
    (8, 'Pereira', '660001'),
    (9, 'Santa Marta', '470001'),
    (10, 'Ibague', '730001');

INSERT INTO user_type (user_type_id, type_name) VALUES
    (1, 'Cliente'),
    (2, 'Empleado'),
    (3, 'Proveedor'),
    (4, 'Auditor');

INSERT INTO contact_media (media_id, media_type) VALUES
    (1, 'Email'),
    (2, 'SMS'),
    (3, 'Llamada Telefónica'),
    (4, 'WhatsApp'),
    (5, 'Notificación Push App'),
    (6, 'Telegram'),
    (7, 'Correo Postal'),
    (8, 'Fax'),
    (9, 'Mensaje en Portal Web'),
    (10, 'Visita Presencial');

INSERT INTO position (position_id, position_name) VALUES
    (1, 'Cajero'),
    (2, 'Asesor de Servicio'),
    (3, 'Gerente de Tienda'),
    (4, 'Técnico de Soporte'),
    (5, 'Consultor'),
    (6, 'Recepcionista'),
    (7, 'Supervisor de Operaciones'),
    (8, 'Especialista de Producto'),
    (9, 'Auxiliar Administrativo'),
    (10, 'Jefe de Despachos');

INSERT INTO job_department (department_id, department_name) VALUES
    (1, 'Ventas'),
    (2, 'Atención al Cliente'),
    (3, 'Soporte Técnico'),
    (4, 'Recursos Humanos'),
    (5, 'Finanzas y Contabilidad'),
    (6, 'Despacho y Logística'),
    (7, 'Administración'),
    (8, 'Mercadeo'),
    (9, 'Operaciones'),
    (10, 'Gerencia');

INSERT INTO service (service_id, service_name, service_state, description) VALUES
    (1, 'Despacho de Artículos', 'Activo', 'Entrega de productos comprados en línea.'),
    (2, 'Recepción de Mercancía', 'Activo', 'Recepción de devoluciones o productos para reparación.'),
    (3, 'Atención al Cliente Presencial', 'Activo', 'Resolución de dudas y quejas en punto físico.'),
    (4, 'Consultoría General', 'Activo', 'Asesoría especializada sobre nuestros servicios.'),
    (5, 'Pago de Facturas', 'Activo', 'Recepción de pagos para servicios y productos.'),
    (6, 'Soporte Técnico Nivel 1', 'Activo', 'Diagnóstico y solución de problemas básicos.'),
    (7, 'Radicación de Documentos', 'Activo', 'Recepción de correspondencia y documentos oficiales.'),
    (8, 'Reclamación de Garantía', 'Activo', 'Gestión de garantías de productos.'),
    (9, 'Activación de Servicios', 'Activo', 'Puesta en marcha de nuevos servicios contratados.'),
    (10, 'Recogida en Tienda', 'Activo', 'Entrega de compras realizadas por internet.');

-- SECCIÓN 2: Inserción en tablas de entidades principales

INSERT INTO limar_user (user_id, first_name, last_name, city_id, user_type_id) VALUES
    (1, 'Carlos', 'Gomez', 1, 1),   -- Cliente
    (2, 'Lucia', 'Fernandez', 2, 3), -- Proveedor
    (3, 'Pedro', 'Martinez', 3, 4),  -- Auditor
    (4, 'Ana', 'Garcia', 1, 2), -- Empleados (7 empleados)
    (5, 'Juan', 'Vargas', 2, 2),
    (6, 'Maria', 'Castro', 3, 2),
    (7, 'Jorge', 'Mendoza', 4, 2),
    (8, 'Laura', 'Jimenez', 5, 2),
    (9, 'Diego', 'Herrera', 6, 2),
    (10, 'Paula', 'Moreno', 7, 2),
    (11, 'José', 'Velasquez', 1, NULL); -- Usuario sin tipo asignado

INSERT INTO employee (employee_id, user_id) VALUES
    (1, 4),
    (2, 5),
    (3, 6),
    (4, 7),
    (5, 8),
    (6, 9),
    (7, 10);

-- SECCIÓN 3: Inserción en tablas de relación

-- Asignar condiciones a varios usuarios
INSERT INTO user_condition (user_id, condition_id) VALUES
    (1, 1), -- Carlos es Adulto Mayor
    (1, 8), -- Carlos requiere Asistencia Especial
    (4, 10), -- Ana pertenece al Grupo Cancer
    (6, 3), -- Maria Requiere Silla de Ruedas
    (8, 1), -- Laura es Adulto Mayor
    (2, 8), -- Lucia Requiere Asistencia Especial
    (5, 4), -- Juan presenta Discapacidad Visual
    (7, 1), -- Jorge es Adulto Mayor
    (9, 8), -- Diego Requiere Asistencia Especial
    (11, 3); -- Jose Requiere Silla de Ruedas

-- Cargos de empleados (cada empleado puede tener múltiples cargos)
INSERT INTO employee_position (employee_id, position_id) VALUES
    (1, 2), -- Ana es Asesor de Servicio
    (2, 4), -- Juan es Técnico de Soporte
    (3, 6), -- Maria es Recepcionista
    (4, 1), -- Jorge es Cajero
    (5, 10),-- Laura es Jefe de Despachos
    (6, 7), -- Diego es Supervisor de Operaciones
    (7, 5), -- Paula es Consultora
    (1, 8); -- Ana también es Especialista de Producto

-- Departamentos de empleados (cada empleado puede pertenecer a múltiples departamentos)
INSERT INTO employee_department (employee_id, department_id) VALUES
    (1, 2), -- Ana en Atención al Cliente
    (2, 3), -- Juan en Soporte Técnico
    (3, 7), -- Maria en Administración
    (4, 1), -- Jorge en Ventas
    (4, 8), -- Jorge en Mercadeo
    (5, 6), -- Laura en Despacho y Logística
    (6, 9), -- Diego en Operaciones
    (7, 8); -- Paula en Mercadeo

INSERT INTO notification (notification_id, send_date, notification_state, message, user_id, media_id) VALUES
    (1, '2023-10-27 08:00:00', 'Enviado', 'Recordatorio: su turno es mañana.', 1, 1),
    (2, '2023-10-27 08:05:00', 'Entregado', 'Asignación de auditoría para la próxima semana.', 3, 2),
    (3, '2023-10-27 09:15:00', 'Leído', 'Su orden de compra ha sido aprobada.', 2, 4),
    (4, '2023-10-28 10:00:00', 'Enviado', 'Reunión de equipo el lunes a las 8 AM.', 4, 1),
    (5, '2023-10-28 11:30:00', 'Enviado', 'Capacitación obligatoria de seguridad.', 5, 1),
    (6, '2023-10-29 14:00:00', 'Enviado', 'Recordatorio de turno para cliente Carlos Gomez.', 6, 1),
    (7, '2023-10-29 15:10:00', 'Entregado', 'Actualización de software requerida.', 7, 2),
    (8, '2023-10-30 16:45:00', 'Leído', 'Bienvenido. Su cuenta ha sido creada.', 8, 1),
    (9, '2023-10-30 17:00:00', 'Enviado', 'Su pedido está listo para recoger.', 1, 4),
    (10, '2023-10-31 18:00:00', 'Enviado', 'Cierre de mes fiscal.', 3, 1);

INSERT INTO turn (turn_id, user_id, service_id, employee_id, turn_date, start_hour, end_hour) VALUES
    (1, 1, 5, 4, '2023-11-01 09:00:00', '09:00:00', '09:15:00'),
    (2, 1, 4, 1, '2023-11-01 09:15:00', '09:15:00', '10:00:00'),
    (3, 1, 2, 5, '2023-11-01 10:00:00', '10:00:00', '10:20:00'),
    (4, 1, 8, 7, '2023-11-02 11:00:00', '11:00:00', '11:30:00'),
    (5, 1, 10, 4, '2023-11-02 11:30:00', '11:30:00', '11:45:00'),
    (6, 1, 3, 3, '2023-11-03 14:00:00', '14:00:00', '14:20:00'),
    (7, 1, 7, 6, '2023-11-03 14:20:00', '14:20:00', '14:30:00'),
    (8, 1, 6, 2, '2023-11-04 15:00:00', '15:00:00', '15:45:00'),
    (9, 1, 9, 1, '2023-11-04 16:00:00', '16:00:00', '16:30:00'),
    (10, 1, 1, 5, '2023-11-05 10:00:00', '10:00:00', '10:15:00');
