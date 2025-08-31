# Entity-Relationship Diagram for AirBnB Database

## Entities and Attributes

### User
- **user_id** (PK, UUID, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL, Indexed)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- **property_id** (PK, UUID, Indexed)
- host_id (FK, references User(user_id))
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- pricepernight (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- **booking_id** (PK, UUID, Indexed)
- property_id (FK, references Property(property_id), Indexed)
- user_id (FK, references User(user_id))
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- **payment_id** (PK, UUID, Indexed)
- booking_id (FK, references Booking(booking_id), Indexed)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

### Review
- **review_id** (PK, UUID, Indexed)
- property_id (FK, references Property(property_id), Indexed)
- user_id (FK, references User(user_id))
- rating (INTEGER, CHECK: 1-5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- **message_id** (PK, UUID, Indexed)
- sender_id (FK, references User(user_id))
- recipient_id (FK, references User(user_id))
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships
1. **User hosts Property** (1:N)
   - User.user_id → Property.host_id
   - One User (host) can have many Properties; one Property has one User (host).

2. **User books Booking** (1:N)
   - User.user_id → Booking.user_id
   - One User (guest) can have many Bookings; one Booking has one User.

3. **Property has Booking** (1:N)
   - Property.property_id → Booking.property_id
   - One Property can have many Bookings; one Booking is for one Property.

4. **Booking has Payment** (1:N)
   - Booking.booking_id → Payment.booking_id
   - One Booking can have many Payments; one Payment is for one Booking.

5. **User writes Review** (1:N)
   - User.user_id → Review.user_id
   - One User can write many Reviews; one Review is written by one User.

6. **Property has Review** (1:N)
   - Property.property_id → Review.property_id
   - One Property can have many Reviews; one Review is for one Property.

7. **User sends/receives Message** (N:N)
   - User.user_id → Message.sender_id
   - User.user_id → Message.recipient_id
   - One User can send/receive many Messages; one Message has one sender and one recipient.

## Constraints
- **User**: UNIQUE on email.
- **Booking**: status limited to pending, confirmed, canceled.
- **Payment**: payment_method limited to credit_card, paypal, stripe.
- **Review**: rating constrained to 1-5.
- **Foreign Keys**: Ensure referential integrity (e.g., Property.host_id must exist in User.user_id).
- **Indexes**: On primary keys, User.email, Property.property_id, Booking.property_id, Booking.booking_id, Payment.booking_id.