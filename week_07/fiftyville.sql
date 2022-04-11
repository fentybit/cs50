-- Keep a log of any SQL queries you execute as you solve the mystery.

SELECT * FROM crime_scene_reports WHERE year = 2021 AND month = 7 AND day = 28 AND street = 'Humphrey Street' AND description LIKE '%CS50%';
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

SELECT * FROM interviews WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE '%thief%';
-- Ruth: Thief exit the bakery parking lot around 10:25am
-- Eugene: Thief withdrew money from atm machine on Leggett Street before the incident?
-- Raymond: Thief flying out tomorrow and ask a friend to purchase the flight

SELECT * FROM airports WHERE city = 'Fiftyville';
-- +----+--------------+-----------------------------+------------+
-- | id | abbreviation |          full_name          |    city    |
-- +----+--------------+-----------------------------+------------+
-- | 8  | CSF          | Fiftyville Regional Airport | Fiftyville |
-- +----+--------------+-----------------------------+------------+

SELECT * FROM flights WHERE year = 2021 AND month = 7 AND day = 29;
-- 5 outbounds flight from Fiftyville

SELECT flights.* FROM flights
JOIN airports on airports.id = flights.origin_airport_id
WHERE airports.city = 'Fiftyville'
AND flights.year = 2021 AND flights.month = 7 AND flights.day = 29
ORDER BY flights.hour, flights.minute;
-- Found the earliest flight, flights.id = 36
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
-- | 43 | 8                 | 1                      | 2021 | 7     | 29  | 9    | 30     |
-- | 23 | 8                 | 11                     | 2021 | 7     | 29  | 12   | 15     |
-- | 53 | 8                 | 9                      | 2021 | 7     | 29  | 15   | 20     |
-- | 18 | 8                 | 6                      | 2021 | 7     | 29  | 16   | 0      |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+

SELECT people.* FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON flights.id = passengers.flight_id
JOIN airports ON flights.origin_airport_id = airports.id
WHERE airports.city = 'Fiftyville'
AND flights.year = 2021 AND flights.month = 7 AND flights.day = 29
ORDER BY flights.hour AND flights.minute;
-- People flying out from Fiftyville on the next day

SELECT * FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60;
-- 9 calls

SELECT * FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration < 60;
-- 9 possible thiefs

SELECT * FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute < 25 AND activity = 'exit';
-- 8 cars exiting

SELECT * FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type='withdraw';
-- 8 transactions

SELECT people.* FROM people
JOIN bank_accounts ON people.id = bank_accounts.person_id
JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
WHERE atm_transactions.year = 2021 AND atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.transaction_type='withdraw';
-- 8 possible thiefs

SELECT people.* FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration < 60
AND bakery_security_logs.year = 2021 AND bakery_security_logs.month = 7 AND bakery_security_logs.day = 28 AND hour = 10 AND minute >= 15 AND minute < 25 AND bakery_security_logs.activity = 'exit';
-- Narrow down to 5 possible thiefs

-- SQL finale
SELECT name FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration < 60
AND bakery_security_logs.year = 2021 AND bakery_security_logs.month = 7 AND bakery_security_logs.day = 28 AND hour = 10 AND minute >= 15 AND minute < 25 AND bakery_security_logs.activity = 'exit'
INTERSECT
SELECT name FROM people
JOIN bank_accounts ON people.id = bank_accounts.person_id
JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
WHERE atm_transactions.year = 2021 AND atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.transaction_type='withdraw'
INTERSECT
SELECT name FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON flights.id = passengers.flight_id
JOIN airports ON flights.origin_airport_id = airports.id
WHERE airports.city = 'Fiftyville'
AND flights.id = 36 AND flights.year = 2021 AND flights.month = 7 AND flights.day = 29;
-- Bruce

SELECT * FROM airports
JOIN flights ON airports.id = flights.destination_airport_id
WHERE flights.destination_airport_id = 4;
-- New York City

SELECT * FROM people WHERE name = 'Bruce';
-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+

SELECT * FROM people
JOIN phone_calls ON people.phone_number = phone_calls.receiver
WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration < 60 AND phone_calls.caller = '(367) 555-5533';
-- Robin