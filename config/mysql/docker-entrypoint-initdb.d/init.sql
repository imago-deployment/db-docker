SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS db_imago;

USE db_imago;

CREATE TABLE t_person (
    person_id VARCHAR(36) PRIMARY KEY,
    last_name varchar(255),
    first_name varchar(255),
    email varchar(255),
    city varchar(255)
);

INSERT INTO db_imago.t_person (
    person_id,
    last_name,
    first_name,
    email,
    city )
VALUES (
    UUID(),
    'Zhao',
    'Andrew',
    'andrew@imago.us',
    'KL');
