# Lab | Database normalization

### Instructions

1. Use [dbdiagram.io](https://dbdiagram.io/home) or [draw.io](https://draw.io) to propose a new structure for the `Sakila` database.
2. Define primary keys and foreign keys for the new database.

![Sakila database](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/3.4-lab-sakila-normalization.png)


### Improved Design

1. added new table `rental_rate` and connecected via PK `rental_rate_id` from `rental_rate` table to FK `rental_rate_id` in `film` table

![Screen Shot 2022-12-03 at 17 07 32](https://user-images.githubusercontent.com/25902252/205450615-a8f388ce-43f4-4a0c-bfee-51e2b6a31769.png)
