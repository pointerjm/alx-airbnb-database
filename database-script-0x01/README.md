# AirBnB Database Schema

## Overview
The `database-script-0x01` directory contains the SQL schema definition for the AirBnB database, designed to support the core functionality of an AirBnB-like platform. This includes:

- User management  
- Property listings  
- Bookings  
- Payments  
- Reviews  
- Messaging  

The schema adheres to the project requirements and is optimized for performance and data integrity.

---

## Files

### ***schema.sql***
Contains SQL `CREATE TABLE` statements to define the database schema.  

Includes:

- Table definitions for **users**, **properties**, **bookings**, **payments**, **reviews**, and **messages**.  
- Appropriate data types (e.g., `UUID`, `VARCHAR`, `DECIMAL`, `TIMESTAMP`).  

Constraints:

- `PRIMARY KEY`  
- `FOREIGN KEY`  
- `UNIQUE`  
- `NOT NULL`  
- `CHECK`  
- `ENUM`  

Other features:

- Indexes for performance optimization (e.g., on `email`, `property_id`, `booking_id`).  
- Utilizes PostgreSQL’s `uuid-ossp` extension for UUID generation.  
- Defines `ENUM` types for `role`, `status`, and `payment_method`.  

---

## Usage
To set up the database, follow these steps:

1. Ensure you have a PostgreSQL database environment.  
2. Execute the `schema.sql` script to create the tables, types, and indexes:

```bash
psql -U <username> -d <database_name> -f schema.sql
