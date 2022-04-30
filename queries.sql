/*Queries that provide answers to the questions from all projects.*/

/* Milestone 1: animals_table */

/* Find all animals whose name ends in "mon". */
SELECT name
FROM animals
WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT
    name,
    date_of_birth
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals
that are neutered and have less than 3 escape attempts. */
SELECT
    name,
    neutered,
    escape_attempts
FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

/* List date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT
    name,
    date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT
    name,
    escape_attempts,
    weight_kg
FROM animals
WHERE weight_kg > 10.5;

/* Find all animals that are neutered. */
SELECT
    name,
    neutered
FROM animals
WHERE neutered = TRUE;

/* Find all animals not named Gabumon. */
SELECT name
FROM animals
WHERE name != 'Gabumon';

/* Find all animals with a weight
between 10.4kg and 17.3kg
(including the animals with the weights
that equals precisely 10.4kg or 17.3kg) */
SELECT
    name,
    weight_kg
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Milestone 2: update animals table */

/* Inside a transaction update the animals table
by setting the species column to unspecified.
Verify that change was made. Then roll back the change
and verify that species columns went back to the state before transaction. */
BEGIN;
UPDATE animals
SET species = 'unspecified';

SELECT
    name,
    species
FROM animals;

ROLLBACK;

SELECT
    name,
    species
FROM animals;

/* Update the animals table by setting the species
column to digimon for all animals that have a name ending in mon. */

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

/* Update the animals table by setting the species column
to pokemon for all animals that don't have species already set. */
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

/* Commit the transaction */
COMMIT;

/* Verify that change was made and persists after commit. */
SELECT
    name,
    species
FROM animals;

/* Inside a transaction delete all records
in the animals table, then roll back the transaction. */
BEGIN;
DELETE
FROM animals;

SELECT COUNT(*)
FROM animals;

ROLLBACK;

/* verify if all records in the animals table still exist. */
SELECT COUNT(*)
FROM animals;

/* Delete all animals born after Jan 1st, 2022. */
BEGIN;
DELETE
FROM animals
WHERE date_of_birth > '2022-01-01';

/* Create a savepoint for the transaction. */
SAVEPOINT SP1;

/* Update all animals' weight to be their weight multiplied by -1. */
UPDATE animals
SET weight_kg = weight_kg * -1;

/* Rollback to the savepoint */
ROLLBACK TO SP1;

/* Update all animals' weights that are
negative to be their weight multiplied by -1. */
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

/* Commit transaction */
COMMIT;

/* How many animals are there? */
SELECT COUNT(*) AS number_of_animals
FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) AS animals_never_try_to_escape
FROM animals
WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) AS average_weight_kg
FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT
    neutered,
    MAX(escape_attempts) AS escapes_attempts
FROM animals
GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT
    species,
    MIN(weight_kg) AS min_weight_kg,
    MAX(weight_kg) AS max_weight_kg
FROM animals
GROUP BY species;

/* What is the average number of escape attempts
per animal type of those born between 1990 and 2000? */
SELECT
    species,
    AVG(escape_attempts) AS escapes_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* Milestone 3: query multiple tables */

/* What animals belong to Melody Pond? */
SELECT
    owners.full_name AS owners,
    animals.name AS animals
FROM owners
INNER JOIN animals
    ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT
    animals.name AS animals,
    species.name AS species
FROM animals
INNER JOIN species
    ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* List all owners and their animals,
remember to include those that don't own any animal. */
SELECT
    owners.full_name AS owners,
    animals.name AS animals
FROM owners
LEFT JOIN animals
    ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT
    species.name,
    COUNT(animals.name) AS total
FROM species
INNER JOIN animals
    ON species.id = animals.species_id
GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT
    owners.full_name AS owners,
    animals.name AS animals,
    species.name AS species
FROM owners
INNER JOIN animals
    ON owners.id = animals.owner_id
INNER JOIN species
    ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester
that haven't tried to escape. */
SELECT
    owners.full_name AS owners,
    animals.name AS animals,
    animals.escape_attempts AS escape_attempts
FROM owners
INNER JOIN animals
    ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* Who owns the most animals? */
SELECT
    owners.full_name AS owners,
    COUNT(animals.owner_id) AS animals
FROM owners
INNER JOIN animals
    ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animals DESC LIMIT 1;
