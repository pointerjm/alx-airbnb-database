-- Initial complex query joining bookings, users, properties, and payments
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pm.amount,
    pm.payment_date,
    pm.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pm ON b.booking_id = pm.booking_id
WHERE b.status = 'confirmed' AND b.start_date >= '2025-09-01' AND b.start_date <= '2025-09-30';

-- Analyze performance using EXPLAIN
EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pm.amount,
    pm.payment_date,
    pm.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pm ON b.booking_id = pm.booking_id
WHERE b.status = 'confirmed' AND b.start_date >= '2025-09-01' AND b.start_date <= '2025-09-30';