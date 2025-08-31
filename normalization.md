# Database Normalization for AirBnB Database

## Objective
This document outlines the normalization process applied to the AirBnB database schema to ensure it adheres to the **Third Normal Form (3NF)**, eliminating redundancies and maintaining data integrity.

## Normalization Principles
To achieve 3NF, the database must satisfy:
1. **First Normal Form (1NF)**: All attributes are atomic, tables have primary keys, and there are no multi-valued attributes.
2. **Second Normal Form (2NF)**: Must be in 1NF, and all non-key attributes depend on the entire primary key (no partial dependencies).
3. **Third Normal Form (3NF)**: Must be in 2NF, and there are no transitive dependencies (non-key attributes do not depend on other non-key attributes).

## Normalization Analysis

### Step 1: First Normal Form (1NF)
All tables (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) satisfy 1NF:
- **Atomic Attributes**: All attributes are atomic (e.g., `User.email` stores a single email, `Property.description` is a single TEXT value).
- **Primary Keys**: Each table has a single-column primary key (UUID, indexed).
- **No Multi-valued Attributes**: Attributes like `role` (ENUM) and `payment_method` (ENUM) store single values.

**Conclusion**: All tables are in 1NF.

### Step 2: Second Normal Form (2NF)
Since all tables have single-column primary keys (e.g., `user_id`, `property_id`), there are no composite keys, and thus no partial dependencies. All non-key attributes depend on their respective primary keys.

**Conclusion**: All tables are in 2NF.

### Step 3: Third Normal Form (3NF)
We analyzed each table for transitive dependencies:

1. **User Table**
   - Attributes: `user_id` (PK), `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`
   - All non-key attributes depend solely on `user_id`.
   - No transitive dependencies (e.g., `first_name` does not determine `email`).
   - **Conclusion**: In 3NF.

2. **Property Table**
   - Attributes: `property_id` (PK), `host_id` (FK), `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`
   - All non-key attributes depend on `property_id`.
   - No transitive dependencies (e.g., `location` does not determine `pricepernight`).
   - **Conclusion**: In 3NF.

3. **Booking Table**
   - Attributes: `booking_id` (PK), `property_id` (FK), `user_id` (FK), `start_date`, `end_date`, `total_price`, `status`, `created_at`
   - **Issue**: The `total_price` attribute could be calculated as `(end_date - start_date) * Property.pricepernight`, introducing a transitive dependency (via `property_id` to `Property.pricepernight`).
   - **Resolution**: Storing `total_price` is a deliberate denormalization to preserve the price at booking time (for historical accuracy) and improve query performance. Consistency must be enforced via application logic or triggers.
   - **Conclusion**: In 3NF with noted denormalization for `total_price`.

4. **Payment Table**
   - Attributes: `payment_id` (PK), `booking_id` (FK), `amount`, `payment_date`, `payment_method`
   - All non-key attributes depend on `payment_id`.
   - No transitive dependencies.
   - **Conclusion**: In 3NF.

5. **Review Table**
   - Attributes: `review_id` (PK), `property_id` (FK), `user_id` (FK), `rating`, `comment`, `created_at`
   - All non-key attributes depend on `review_id`.
   - No transitive dependencies.
   - **Conclusion**: In 3NF.

6. **Message Table**
   - Attributes: `message_id` (PK), `sender_id` (FK), `recipient_id` (FK), `message_body`, `sent_at`
   - All non-key attributes depend on `message_id`.
   - No transitive dependencies.
   - **Conclusion**: In 3NF.

## Adjustments Made
- **Booking Table**: Retained `total_price` as a denormalized attribute to store the agreed-upon price at booking time. This decision prioritizes historical accuracy and performance but requires application logic to ensure `total_price` is consistent with `start_date`, `end_date`, and `Property.pricepernight`.
- No other structural changes were necessary, as all tables were already in 3NF or required only the noted denormalization.

## Final Schema
The database schema remains as specified, with the denormalization of `total_price` in the `Booking` table documented. All tables are in 3NF, with the exception of the deliberate denormalization in the `Booking` table.

## Conclusion
The AirBnB database schema is normalized to 3NF, with a single deliberate denormalization in the `Booking` table for `total_price`. This design balances data integrity, performance, and practical requirements for a booking system. Application logic or database triggers should enforce consistency for `total_price`.