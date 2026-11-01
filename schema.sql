-- 1. Tabelul Roluri
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    denumire VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabelul Utilizatori
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    parola_hash VARCHAR(255) NOT NULL,
    telefon VARCHAR(20),
    rol_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_role FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- 3. Tabelul Tipuri de Abonamente
CREATE TABLE IF NOT EXISTS membership_types (
    id SERIAL PRIMARY KEY,
    denumire VARCHAR(100) NOT NULL,
    pret DECIMAL(10, 2) NOT NULL CHECK (pret > 0),
    durata_zile INT NOT NULL CHECK (durata_zile > 0)
);

-- 4. Tabelul Abonamente Clienți
CREATE TABLE IF NOT EXISTS subscriptions (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    membership_type_id INT NOT NULL,
    data_start DATE NOT NULL DEFAULT CURRENT_DATE,
    data_sfarsit DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'activ' CHECK (status IN ('activ', 'expirat', 'anulat')),
    CONSTRAINT fk_sub_client FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_sub_type FOREIGN KEY (membership_type_id) REFERENCES membership_types(id) ON DELETE RESTRICT
);

-- 5. Tabelul Clase de Fitness
CREATE TABLE IF NOT EXISTS fitness_classes (
    id SERIAL PRIMARY KEY,
    titlu VARCHAR(100) NOT NULL,
    trainer_id INT NOT NULL,
    capacitate_maxima INT NOT NULL CHECK (capacitate_maxima > 0),
    data_ora TIMESTAMP NOT NULL,
    sala VARCHAR(50) NOT NULL,
    CONSTRAINT fk_class_trainer FOREIGN KEY (trainer_id) REFERENCES users(id) ON DELETE RESTRICT
);

-- 6. Tabelul Programări (Bookings)
CREATE TABLE IF NOT EXISTS bookings (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    class_id INT NOT NULL,
    data_rezervare TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'confirmata' CHECK (status IN ('confirmata', 'anulata')),
    CONSTRAINT fk_booking_client FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_class FOREIGN KEY (class_id) REFERENCES fitness_classes(id) ON DELETE CASCADE,
    CONSTRAINT unique_client_class UNIQUE (client_id, class_id)
);