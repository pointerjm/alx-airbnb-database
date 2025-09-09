-- Partitioning the bookings table by start_date (range partitioning by year)
-- Step 1: Create a parent table (no data, just structure)
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_id FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE RESTRICT,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    CONSTRAINT check_dates CHECK (end_date >= start_date)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for 2025 and 2026
CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Step 3: Create indexes on partitions
CREATE INDEX idx_bookings_2025_property_id ON bookings_2025(property_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025(start_date);

CREATE INDEX idx_bookings_2026_property_id ON bookings_2026(property_id);
CREATE INDEX idx_bookings_2026_user_id ON bookings_2026(user_id);
CREATE INDEX idx_bookings_2026_start_date ON bookings_2026(start_date);

-- Step 4: Migrate data from original bookings table to partitioned table
INSERT INTO bookings_partitioned
SELECT * FROM bookings;

-- Step 5: Drop the original bookings table (after verifying data migration)
-- DROP TABLE bookings;

-- Step 6: Rename partitioned table to original name
ALTER TABLE bookings_partitioned RENAME TO bookings;