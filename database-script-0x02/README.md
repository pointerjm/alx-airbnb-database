# AirBnB Database Seed Data

## Overview
The `database-script-0x02` directory contains SQL scripts to populate the AirBnB database with **sample data**, reflecting real-world usage scenarios. This data supports testing and development of the AirBnB platform, covering:

- User management with different roles (**admin**, **host**, **guest**)  
- Property listings across various locations  
- Booking system with different statuses  
- Payment processing for bookings  
- Review system for properties  
- Messaging between users  

The seed data is designed for **PostgreSQL** and aligns with the schema defined in `database-script-0x01/schema.sql`.

---

## Files

### ***seed.sql***
Contains SQL `INSERT` statements to populate the database.

**Key Features:**

- Sample data for **users**, **properties**, **bookings**, **payments**, **reviews**, and **messages**.  
- Realistic scenarios:
  - 5 users (1 admin, 2 hosts, 2 guests)  
  - 4 properties with varied locations and prices  
  - 6 bookings with different statuses (**confirmed**, **pending**, **canceled**)  
  - 4 payments using different methods (**credit_card**, **paypal**, **stripe**)  
  - 3 reviews with ratings and comments  
  - 4 messages between users (e.g., inquiries and responses)  

- Respects **foreign key constraints** and **data integrity** (e.g., `total_price` calculated as `(end_date - start_date) * pricepernight`).  
- Uses PostgreSQL’s `uuid-ossp` extension for UUID generation.  

---

## Usage

### ***Populating the Database***
To seed the database:

1. Ensure a PostgreSQL environment is set up and the schema from `database-script-0x01/schema.sql` has been executed.  
2. Run the `seed.sql` script to insert sample data:

```bash
psql -U <username> -d <database_name> -f seed.sql
