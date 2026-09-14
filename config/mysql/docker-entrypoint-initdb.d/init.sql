SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS db_imago;

USE db_imago;

CREATE TABLE t_person (
    person_id int,
    last_name varchar(255),
    first_name varchar(255),
    email varchar(255),
    city varchar(255)
);
