# Lab | Database normalization

### Instructions

1. Use [dbdiagram.io](https://dbdiagram.io/home) or [draw.io](https://draw.io) to propose a new structure for the `Sakila` database.
2. Define primary keys and foreign keys for the new database.

![Sakila database](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/3.4-lab-sakila-normalization.png)


### Improved Design

1. added new table `film_rental_rate` with PK `rental_rate_id` and FK `film_id`
2. added new table `special_feature` with PK `feature_id`
3. added connecting table `film_special_feature` with PK `feature_id` AND PK `film_id` > thus this PK will be a composite to guarantee uniqueness


![Screen Shot 2022-12-06 at 09 58 12](https://user-images.githubusercontent.com/25902252/205866159-6bb092b4-e0a2-41e0-bb30-5a326725f5e0.png)
