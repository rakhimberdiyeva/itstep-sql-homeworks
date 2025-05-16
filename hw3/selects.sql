
SELECT * FROM users;

SELECT
	u.fullname,
	r.name,
	b.booking_date,
	b.time_start,
	b.time_end
FROM bookings b
LEFT JOIN users u ON b.user_id = u.id
INNER JOIN rooms r ON b.room_id = r.id;


DELETE FROM users WHERE id = 2
DELETE FROM rooms WHERE id = 1