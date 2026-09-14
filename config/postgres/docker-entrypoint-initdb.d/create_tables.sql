-- Create a table
CREATE TABLE IF NOT EXISTS t_person (
    person_id uuid NOT NULL DEFAULT uuidv7(),
    person_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert predefined data
INSERT INTO users (person_name, email) VALUES
('andrew', 'andrew@example.com'),
('bob', 'bob@example.com');