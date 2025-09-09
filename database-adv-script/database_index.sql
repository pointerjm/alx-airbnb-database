-- Identify high-usage columns and create indexes
-- Columns: properties.host_id (used in joins), bookings.start_date (used in range queries)

-- Create index on properties.host_id
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- Create index on bookings.start_date
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Performance analysis using EXPLAIN
-- Query 1: Before index on bookings.start_date
EXPLAIN SELECT * FROM bookings WHERE start_date >= '2025-09-01' AND start_date <= '2025-09-30';

-- Query 1: After index on bookings.start_date
-- (Run after creating idx_bookings_start_date)
EXPLAIN SELECT * FROM bookings WHERE start_date >= '2025-09-01' AND start_date <= '2025-09-30';

-- Query 2: Before index on properties.host_id
EXPLAIN SELECT p.* FROM properties p JOIN users u ON p.host_id = u.user_id WHERE u.email = 'bob.johnson@example.com';

-- Query 2: After index on properties.host_id
-- (Run after creating idx_properties_host_id)
EXPLAIN SELECT p.* FROM properties p JOIN users u ON p.host_id = u.user_id WHERE u.email = 'bob.johnson@example.com';