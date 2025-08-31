-- Seed data for AirBnB database
-- Assumes schema.sql has been executed (with uuid-ossp extension enabled)

-- Insert Users (1 admin, 2 hosts, 2 guests)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
  (uuid_generate_v4(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_1', '+12345678901', 'admin', '2025-08-01 10:00:00'),
  (uuid_generate_v4(), 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_2', '+12345678902', 'host', '2025-08-01 10:15:00'),
  (uuid_generate_v4(), 'Carol', 'Williams', 'carol.williams@example.com', 'hashed_password_3', '+12345678903', 'host', '2025-08-01 10:30:00'),
  (uuid_generate_v4(), 'Dave', 'Brown', 'dave.brown@example.com', 'hashed_password_4', NULL, 'guest', '2025-08-02 09:00:00'),
  (uuid_generate_v4(), 'Eve', 'Davis', 'eve.davis@example.com', 'hashed_password_5', '+12345678905', 'guest', '2025-08-02 09:30:00');

-- Insert Properties (4 properties owned by Bob and Carol)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob.johnson@example.com'), 'Cozy Beach Cottage', 'A charming cottage by the sea with stunning views.', 'Miami, FL', 120.00, '2025-08-03 12:00:00', '2025-08-03 12:00:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob.johnson@example.com'), 'Downtown Loft', 'Modern loft in the heart of the city.', 'New York, NY', 200.00, '2025-08-03 12:30:00', '2025-08-03 12:30:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'carol.williams@example.com'), 'Mountain Retreat', 'A serene cabin in the mountains.', 'Aspen, CO', 150.00, '2025-08-04 14:00:00', '2025-08-04 14:00:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'carol.williams@example.com'), 'Urban Studio', 'Compact studio with city vibes.', 'Chicago, IL', 80.00, '2025-08-04 14:30:00', '2025-08-04 14:30:00');

-- Insert Bookings (6 bookings by Dave and Eve for various properties)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Cozy Beach Cottage'), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), '2025-09-01', '2025-09-03', 240.00, 'confirmed', '2025-08-05 09:00:00'), -- 2 nights * 120
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Downtown Loft'), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), '2025-09-10', '2025-09-12', 400.00, 'pending', '2025-08-06 10:00:00'), -- 2 nights * 200
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Mountain Retreat'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), '2025-09-15', '2025-09-20', 750.00, 'confirmed', '2025-08-07 11:00:00'), -- 5 nights * 150
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Urban Studio'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), '2025-09-01', '2025-09-04', 240.00, 'confirmed', '2025-08-08 12:00:00'), -- 3 nights * 80
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Cozy Beach Cottage'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), '2025-09-05', '2025-09-07', 240.00, 'canceled', '2025-08-09 13:00:00'), -- 2 nights * 120
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Downtown Loft'), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), '2025-09-20', '2025-09-22', 400.00, 'pending', '2025-08-10 14:00:00'); -- 2 nights * 200

-- Insert Payments (4 payments for confirmed/pending bookings)
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
  (uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE start_date = '2025-09-01' AND property_id = (SELECT property_id FROM properties WHERE name = 'Cozy Beach Cottage')), 240.00, '2025-08-05 09:30:00', 'credit_card'),
  (uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE start_date = '2025-09-10' AND property_id = (SELECT property_id FROM properties WHERE name = 'Downtown Loft')), 400.00, '2025-08-06 10:30:00', 'paypal'),
  (uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE start_date = '2025-09-15' AND property_id = (SELECT property_id FROM properties WHERE name = 'Mountain Retreat')), 750.00, '2025-08-07 11:30:00', 'stripe'),
  (uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE start_date = '2025-09-01' AND property_id = (SELECT property_id FROM properties WHERE name = 'Urban Studio')), 240.00, '2025-08-08 12:30:00', 'credit_card');

-- Insert Reviews (3 reviews by Dave and Eve for properties they booked)
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Cozy Beach Cottage'), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), 5, 'Amazing beach views, very relaxing!', '2025-09-04 10:00:00'),
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Mountain Retreat'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), 4, 'Great location, but a bit chilly at night.', '2025-09-21 11:00:00'),
  (uuid_generate_v4(), (SELECT property_id FROM properties WHERE name = 'Urban Studio'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), 3, 'Convenient location, but smaller than expected.', '2025-09-05 12:00:00');

-- Insert Messages (4 messages between users)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), (SELECT user_id FROM users WHERE email = 'bob.johnson@example.com'), 'Is the beach cottage available for September?', '2025-08-04 08:00:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob.johnson@example.com'), (SELECT user_id FROM users WHERE email = 'dave.brown@example.com'), 'Yes, it’s available! Let me know if you want to book.', '2025-08-04 09:00:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), (SELECT user_id FROM users WHERE email = 'carol.williams@example.com'), 'Can you confirm if pets are allowed in the mountain retreat?', '2025-08-06 10:00:00'),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'carol.williams@example.com'), (SELECT user_id FROM users WHERE email = 'eve.davis@example.com'), 'Sorry, no pets allowed in the mountain retreat.', '2025-08-06 11:00:00');