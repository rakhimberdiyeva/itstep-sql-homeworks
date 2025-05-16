INSERT INTO rooms(name, capacity)
VALUES
('room 1', 2),
('room 2', 3),
('room 3', 4),
('room 4', 2);

INSERT INTO users(fullname, email)
VALUES
('Rachel Green', 'rachel'),
('Monica Geller', 'monica'),
('Gabrielle Solis', 'gabi');


INSERT INTO bookings(room_id, user_id, booking_date, time_start, time_end)
VALUES
(2, 1, '2025-03-11', '2025-07-20 14:00', '2025-07-30 12:00'),
(3, 2, '2025-05-28', '2025-06-13 14:00', '2025-06-25 12:00'),
(1, 3, '2025-06-14', '2025-08-04 14:00', '2025-08-10 12:00'),
(4, 2, '2025-04-24', '2025-10-26 14:00', '2025-11-03 12:00');


