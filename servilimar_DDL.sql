-- =============================================================================
-- SCRIPT DDL PARA LA CREACIÓN DEL SISTEMA DE TURNOS LIMAR (PostgreSQL)
-- =============================================================================

-- =============================================================================
-- 1. TABLAS DE LISTAS Y ENTIDADES SIN DEPENDENCIAS EXTERNAS
-- =============================================================================

CREATE TABLE IF NOT EXISTS special_condition (
    condition_id INT NOT NULL PRIMARY KEY,
    condition_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS city (
    city_id INT NOT NULL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    post_code VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS user_type (
    user_type_id INT NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS contact_media (
    media_id INT NOT NULL PRIMARY KEY,
    media_type VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS position (
    position_id INT NOT NULL PRIMARY KEY,
    position_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS job_department (
    department_id INT NOT NULL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS service (
    service_id INT NOT NULL PRIMARY KEY,
    service_name VARCHAR(150) NOT NULL,
    service_state VARCHAR(50) NOT NULL,
    description TEXT
);


-- =============================================================================
-- 2. TABLAS DE ENTIDADES PRINCIPALES CON DEPENDENCIAS
-- =============================================================================

CREATE TABLE IF NOT EXISTS limar_user (
    user_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    user_type_id INT,

    FOREIGN KEY (city_id) REFERENCES city(city_id),
    FOREIGN KEY (user_type_id) REFERENCES user_type(user_type_id)
);

CREATE TABLE IF NOT EXISTS employee (
    employee_id INT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,

    FOREIGN KEY (user_id) REFERENCES limar_user(user_id)
);

CREATE TABLE IF NOT EXISTS notification (
    notification_id INT NOT NULL PRIMARY KEY,
    send_date TIMESTAMP NOT NULL,
    notification_state VARCHAR(50) NOT NULL,
    message TEXT,
    user_id INT NOT NULL,
    media_id INT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES limar_user(user_id),
    FOREIGN KEY (media_id) REFERENCES contact_media(media_id)
);


-- =============================================================================
-- 3. TABLAS DE RELACIONES
-- =============================================================================

CREATE TABLE IF NOT EXISTS user_condition (
    user_id INT NOT NULL,
    condition_id INT NOT NULL,

    PRIMARY KEY (user_id, condition_id),
    FOREIGN KEY (user_id) REFERENCES limar_user(user_id),
    FOREIGN KEY (condition_id) REFERENCES special_condition(condition_id)
);

CREATE TABLE IF NOT EXISTS employee_position (
    employee_id INT NOT NULL,
    position_id INT NOT NULL,

    PRIMARY KEY (employee_id, position_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (position_id) REFERENCES position(position_id)
);

CREATE TABLE IF NOT EXISTS employee_department (
    employee_id INT NOT NULL,
    department_id INT NOT NULL,

    PRIMARY KEY (employee_id, department_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES job_department(department_id)
);

CREATE TABLE IF NOT EXISTS turn (
    turn_id INT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    employee_id INT NOT NULL,
    turn_date TIMESTAMP NOT NULL,
    start_hour TIME NOT NULL,
    end_hour TIME NOT NULL,

    FOREIGN KEY (user_id) REFERENCES limar_user(user_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);