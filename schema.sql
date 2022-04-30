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

/* Milestone 2: update animals table */

ALTER TABLE animals
ADD COLUMN species VARCHAR(250);

/* Milestone 3: query multiple tables */

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(250),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT constraint_species
FOREIGN KEY (species_id)
REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT constraint_owner
FOREIGN KEY (owner_id)
REFERENCES owners;

/* Milestone 4: add "join table" for visits. */

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations(
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id INT,
    species_id INT,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id),
    PRIMARY KEY(id)
);

CREATE TABLE visits(
    id INT GENERATED ALWAYS AS IDENTITY,
    animals_id INT,
    vet_id INT,
    date_of_visit DATE,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animals_id) REFERENCES animals(id),
    PRIMARY KEY(id)
);
