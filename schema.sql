/* Database schema to keep the structure of entire database. */

/* Milestone 1: animals_table */

/* Create a database named vet_clinic if not exist. */
CREATE DATABASE vet_clinic

/* Create a table named animals */
CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  PRIMARY KEY(id)
);
