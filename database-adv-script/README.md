AirBnB Advanced Database Scripts
Overview
The database-adv-script directory contains advanced SQL scripts and documentation for the AirBnB database, focusing on complex queries, performance optimization, and scalability. These scripts build upon the schema defined in database-script-0x01 and the seed data from database-script-0x02. The tasks cover:

Complex SQL queries using joins, subqueries, and window functions
Indexing for performance optimization
Query refactoring and optimization
Table partitioning for large datasets
Performance monitoring and analysis

Prerequisites

PostgreSQL environment with the schema from database-script-0x01/schema.sql executed.
Seed data from database-script-0x02/seed.sql loaded for testing.
Enable the uuid-ossp extension in PostgreSQL (CREATE EXTENSION IF NOT EXISTS "uuid-ossp";).

Files
joins_queries.sql
Contains SQL queries demonstrating different types of joins:

INNER JOIN to retrieve bookings with user details.
LEFT JOIN to retrieve properties and their reviews (including properties without reviews).
FULL OUTER JOIN to retrieve all users and bookings.

subqueries.sql
Contains SQL queries using subqueries:

Non-correlated subquery to find properties with an average rating > 4.0.
Correlated subquery to find users with more than 3 bookings.

aggregations_and_window_functions.sql
Contains SQL queries using aggregations and window functions:

COUNT and GROUP BY to show the total number of bookings per user.
Window function (RANK) to rank properties by the number of bookings.

index_performance.md
Describes the creation of indexes on high-usage columns in the users, bookings, and properties tables, along with performance analysis using EXPLAIN or ANALYZE.
perfomance.sql
Contains an initial complex query joining bookings, users, properties, and payments tables, used as a baseline for optimization.
optimization_report.md
Documents the performance analysis of the query in perfomance.sql, identifies inefficiencies, and describes the refactored query with performance improvements.
partitioning.sql
Contains SQL commands to partition the bookings table by start_date to improve query performance on large datasets.
partition_performance.md
Reports the performance improvements observed after partitioning the bookings table, including query execution times for date range queries.
performance_monitoring.md
Describes the monitoring of frequently used queries using EXPLAIN ANALYZE, identifies bottlenecks, and documents schema or index adjustments for improved performance.
Usage

Ensure the PostgreSQL database is set up with the schema and seed data.
Execute the SQL scripts in the following order if needed:psql -U <username> -d <database_name> -f joins_queries.sql
psql -U <username> -d <database_name> -f subqueries.sql
psql -U <username> -d <database_name> -f aggregations_and_window_functions.sql
psql -U <username> -d <database_name> -f partitioning.sql


Review the .md files for performance analysis and optimization details.
Use EXPLAIN or EXPLAIN ANALYZE to evaluate query performance before and after applying optimizations.
