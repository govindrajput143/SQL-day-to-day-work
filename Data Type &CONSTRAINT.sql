-- Select database
USE newdb2;

-- ---------------------------------------------------
-- Example 1: INT Data Type & Data Type Validation
-- ---------------------------------------------------
CREATE TABLE test1(
    rollno INT
); -- DDL Statement

INSERT INTO test1 VALUES(10);     -- DML Statement (Valid)
INSERT INTO test1 VALUES(30);     -- DML Statement (Valid)
-- INSERT INTO test1 VALUES('aman'); -- ERROR: String cannot be inserted into INT column

SELECT * FROM test1;             -- DQL Statement


-- ---------------------------------------------------
-- Example 2: TINYINT Data Type & Range Limits (-128 to 127)
-- ---------------------------------------------------
CREATE TABLE test2(
    rollno TINYINT
); -- DDL Statement

-- Valid insertions (Within -128 to 127)
INSERT INTO test2 VALUES(127);
INSERT INTO test2 VALUES(-128);
INSERT INTO test2 VALUES(True);   -- Evaluates to 1 in MySQL

-- Invalid insertion (Out of range)
-- INSERT INTO test2 VALUES(128);  -- ERROR 1264: Out of range value

SELECT * FROM test2;


-- =================================================================
-- 1. DATABASE SELECTION & DDL vs DML vs DQL
-- =================================================================

/*
  SQL COMMAND TYPES:
  ------------------
  1. DDL (Data Definition Language): Structural changes ke liye (e.g., CREATE, ALTER, DROP).
  2. DML (Data Manipulation Language): Data insert, update ya delete karne ke liye (e.g., INSERT, UPDATE, DELETE).
  3. DQL (Data Query Language): Data read/view karne ke liye (e.g., SELECT).
*/

-- Table banana (DDL)
CREATE TABLE test1 (
    rollno INT
);

-- Data insert karna (DML)
INSERT INTO test1 VALUES (10);
INSERT INTO test1 VALUES (30);

-- Data view karna (DQL)
SELECT * FROM test1;


-- =================================================================
-- 2. DATA TYPE ERROR (Mismatched Data Types)
-- =================================================================

/*
  CONCEPT:
  - Jab hum kisi column ka datatype 'INT' rakhte hain, toh usme sirf numbers hi jaa sakte hain.
  - Agar hum text/string (jaise 'aman') insert karenge, toh SQL "Incorrect integer value" ka ERROR dega.
*/

-- Example of Error:
-- INSERT INTO test1 VALUES ('aman'); 
-- ERROR: String value ko INT column mein insert nahi kar sakte!


-- =================================================================
-- 3. TINYINT & MEMORY RANGE (-128 to 127)
-- =================================================================

/*
  CONCEPT:
  - TINYINT memory mein 1 Byte (8 Bits) jagah leta hai.
  - Total combinations = 2^8 = 256.
  - Standard Signed TINYINT ki range: -128 se leke +127 tak hoti hai.
  
  RANGE BREAKDOWN:
  - Minimum allowed value = -128
  - Maximum allowed value = 127
  - Range se bahar ka koi bhi number "Out of range value" ERROR dega!
*/

-- Table banana (DDL)
CREATE TABLE test2 (
    rollno TINYINT
);

-- Valid Insertions (Range ke andar hain):
INSERT INTO test2 VALUES (127);   -- Maximum limit (SUCCESS)
INSERT INTO test2 VALUES (-128);  -- Minimum limit (SUCCESS)

-- Invalid Insertion (Out of Range Error):
-- INSERT INTO test2 VALUES (128); 
-- ERROR 1264: Out of range value for column 'rollno' (Kyunki 128 > 127)


-- =================================================================
-- 4. BOOLEAN (True / False) IN MYSQL
-- =================================================================

/*
  CONCEPT:
  - MySQL mein koi alag se pure Boolean data type nahi hota.
  - Internally MySQL 'True' ko 1 aur 'False' ko 0 ki tarah treat karta hai (jo TINYINT(1) hota hai).
  - Isliye jab hum TINYINT column mein 'True' insert karte hain, toh wo '1' store kar leta hai.
*/

-- Valid Insertion:
INSERT INTO test2 VALUES (True);  -- Internally 1 store hoga (SUCCESS)

-- Result check karne ke liye (DQL):
SELECT * FROM test2;



-- =================================================================
-- 1. INTEGER DATA TYPES & MEMORY ALLOCATION
-- =================================================================

/*
  CONCEPT:
  SQL mein alag-alag range ke numbers store karne ke liye alag datatypes hote hain.
  Kitni memory lagti hai aur kitni values store kar sakte hain:
  
  1. TINYINT  => 1 Byte  (8 Bits)  -> Range: -128 to 127
  2. SMALLINT => 2 Bytes (16 Bits) -> Range: -32,768 to 32,767
  3. INT      => 4 Bytes (32 Bits) -> Range: ~2 Billion (-2.14B to +2.14B)
  4. BIGINT   => 8 Bytes (64 Bits) -> Maximum Range (~18 Quintillion values)
*/


-- =================================================================
-- 2. SIGNED vs UNSIGNED (TINYINT UNSIGNED)
-- =================================================================

/*
  CONCEPT:
  - By default, Integer datatypes SIGNED hote hain (negative aur positive dono allow karte hain).
  - Agar hum 'UNSIGNED' keyword lagate hain, toh negative values band ho jaati hain
    aur poori capacity positive numbers ke liye use hoti hai.
  
  - Signed TINYINT   => -128 to 127
  - Unsigned TINYINT => 0 to 255 (No negative numbers!)
*/

-- Table creation with UNSIGNED
CREATE TABLE test3 (
    rollno TINYINT UNSIGNED
); -- DDL Statement

-- Valid Insertions (0 se 255 ke andar hain):
INSERT INTO test3 VALUES (129); -- SUCCESS (Signed mein 129 error deta, par Unsigned mein valid hai)
INSERT INTO test3 VALUES (255); -- SUCCESS (Maximum allowed value)

-- Invalid Insertion (Out of Range):
-- INSERT INTO test3 VALUES (256); 
-- ERROR 1264: Out of range value for column 'rollno' (Kyunki 256 > 255)


-- =================================================================
-- 3. STRING DATA TYPES: CHAR vs VARCHAR
-- =================================================================

/*
  CHAR (Fixed Length Character):
  - Fixed memory block karta hai.
  - Agar aapne CHAR(10) likha aur 'OM' (2 characters) store kiya, toh bhi SQL
    poori 10 characters ki memory reserve karega (baaki 8 spaces pad kar deta hai).
  - Best for: Fixed length data jaise Gender ('M'/'F'), Country Code ('IND'), Pin code.

  VARCHAR (Variable Length Character):
  - Dynamic memory allocation karta hai.
  - Agar aapne VARCHAR(20) likha aur 'OM' (2 characters) store kiya, toh sirf
    2 characters (+ 1-2 bytes length header) jitni jagah hi use karega.
  - Best for: Variable length data jaise Names, Emails, Addresses.
*/

-- CHAR example
CREATE TABLE test4 (
    gender CHAR(10)
);
INSERT INTO test4 VALUES ('M');
INSERT INTO test4 VALUES ('Male');
INSERT INTO test4 VALUES ('OM');

-- VARCHAR example
CREATE TABLE test6 (
    name VARCHAR(20)
);
INSERT INTO test6 VALUES ('OM');

-- Combined CHAR vs VARCHAR Demonstration Table
CREATE TABLE test7 (
    name CHAR(10),
    name2 VARCHAR(10)
);

INSERT INTO test7 VALUES ('abc', 'abc');
INSERT INTO test7 VALUES ('def  ', 'def  '); -- Trailing spaces handle hote hain
INSERT INTO test7 VALUES ('aman', NULL);     -- NULL value insert kar sakte hain

SELECT * FROM test7;


-- =================================================================
-- 4. METADATA QUERYING (Listing Database Tables)
-- =================================================================

/*
  CONCEPT:
  - database() function: Currently active database ka naam batata hai.
  - information_schema.tables: System table jo saari databases aur tables ki details rakhti hai.
  - Yeh query current database ki saari tables ki list show karti hai.
*/

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = database();


-- =================================================================
-- 1. CHAR vs VARCHAR: CREATION AND INSERTION
-- =================================================================

/*
  CONCEPT:
  - CHAR(N): Fixed-length string. Unused characters ko spaces se fill/pad kar deta hai.
  - VARCHAR(N): Variable-length string. Dynamic length handle karta hai.
*/

CREATE TABLE  test6 (
    name VARCHAR(20)
); -- DDL Statement

-- Inserting values into VARCHAR & CHAR
INSERT INTO test6 VALUES ('OM'); -- Dynamic length (2 characters + 1-2 bytes length overhead)
INSERT INTO test4 VALUES ('OM'); -- CHAR(10) mein 'OM' ke baad spaces pad honge

-- Table status to inspect engine, row format, and data length
SHOW TABLE STATUS LIKE 'test4';


-- =================================================================
-- 2. CHAR vs VARCHAR: TRAILING SPACES & LENGTH BEHAVIOR
-- =================================================================

/*
  IMPORTANT BEHAVIOR:
  - CHAR column mein jab aap trailing spaces (jaise 'def  ') insert karte hain,
    toh retrieved output mein MySQL trailing spaces ko STRIP (remove) kar deta hai.
    Isliye CHAR_LENGTH('def  ') CHAR column ke liye 3 return karta hai.
    
  - VARCHAR column trailing spaces ko PRESERVE (save) karta hai.
    Isliye CHAR_LENGTH('def  ') VARCHAR column ke liye 5 return karta hai.
*/

CREATE TABLE test7 (
    name CHAR(10),
    name2 VARCHAR(10)
);

-- Test Case 1: Without Trailing Spaces
INSERT INTO test7 VALUES ('abc', 'abc');

SELECT 
    name, 
    CHAR_LENGTH(name) AS char_len_name, 
    name2, 
    CHAR_LENGTH(name2) AS varchar_len_name2
FROM test7;
-- Result: Both return length = 3

-- Test Case 2: With Trailing Spaces ('def  ' -> 'def' followed by 2 spaces)
INSERT INTO test7 VALUES ('def  ', 'def  ');

SELECT 
    name, 
    CHAR_LENGTH(name) AS char_len_name, 
    name2, 
    CHAR_LENGTH(name2) AS varchar_len_name2
FROM test7;
-- Result: 
-- CHAR(10) name     => Length = 3 (Trailing spaces strip ho gaye)
-- VARCHAR(10) name2 => Length = 5 (Trailing spaces preserve hue)


-- =================================================================
-- 3. METADATA QUERYING: LISTING TABLES IN CURRENT DATABASE
-- =================================================================

/*
  CONCEPT:
  - information_schema.tables ek system metadata view hai.
  - database() function system mein currently active database ka naam deta hai.
  - Yeh query current schema/database ki saari user tables list karti hai.
*/

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = database();




-- =================================================================
-- 1. IMPLICIT NULL VALUES & PARTIAL INSERTION
-- =================================================================

/*
  CONCEPT:
  - Agar hum kisi table mein insert karte waqt explicit columns pass karte hain 
    (jaise `INSERT INTO test10(id)`), toh baaki un-specified columns mein 
    by default 'NULL' value chali jaati hai (agar DEFAULT constraint predefined nahi hai).
*/

CREATE TABLE test10 (
    id INT,
    name VARCHAR(20)
);

-- Full Column Insertion
INSERT INTO test10 VALUES (10, 'abhishek');

-- Partial Insertion (Sirf 'id' ki value di hai)
INSERT INTO test10(id) VALUES (11);
-- Result: id = 11, name = NULL (automatically default NULL ho jata hai)

SELECT * FROM test10;


-- =================================================================
-- 2. DEFAULT CONSTRAINT
-- =================================================================

/*
  CONCEPT:
  - 'DEFAULT' constraint tab trigger hota hai jab insert query mein kisi column 
    ki value specify NAHI ki jaati.
  - Jab hum specific columns insert karte hain, toh skip hone wale column par 
    uske assigned default value apply ho jati hai.
*/

CREATE TABLE test12 (
    id INT,
    name VARCHAR(20) DEFAULT 'regex'
);

-- Case 1: Value explicitly pass ki hai ('abhishek')
INSERT INTO test12 VALUES (10, 'abhishek'); 
-- Result: name = 'abhishek'

-- Case 2: 'name' column pass nahi kiya (Partial Insert)
INSERT INTO test12(id) VALUES (11); 
-- Result: id = 11, name = 'regex' (DEFAULT value applied)

-- Case 3: 'id' column pass nahi kiya, par 'name' kiya
INSERT INTO test12(name) VALUES ('tushar'); 
-- Result: id = NULL, name = 'tushar'

-- Duplicate values in DEFAULT columns are allowed unless UNIQUE is added:
INSERT INTO test12 VALUES (10, 'abhishek'); -- Works completely fine

SELECT * FROM test12;


-- =================================================================
-- 3. UNIQUE CONSTRAINT & NULL BEHAVIOR
-- =================================================================

/*
  CONCEPT:
  - 'UNIQUE' constraint duplicate non-null values allow nahi karta.
  - ERROR 1062: Duplicate entry aati hai jab aap repeated non-null value insert karte ho.
  - IMPORTANT: UNIQUE constraint Multiple NULL values ALLOW karta hai, 
    kyunki SQL mein 'NULL != NULL' hota hai!
*/

CREATE TABLE test13 (
    id INT UNIQUE,
    name VARCHAR(20)
);

-- First Entry (Valid)
INSERT INTO test13 VALUES (10, 'abhishek');

-- Duplicate Entry in UNIQUE column (Invalid -> ERROR 1062)
-- INSERT INTO test13 VALUES (10, 'ujjwal'); 
-- Error Code: 1062. Duplicate entry '10' for key 'test13.id'

-- Unique column but different value, duplicate name (Valid)
INSERT INTO test13 VALUES (11, 'abhishek'); -- Non-unique columns can have duplicate data

-- Inserting NULL in UNIQUE column (Valid)
INSERT INTO test13 VALUES (NULL, 'happy'); -- Works!

-- Inserting SECOND NULL in UNIQUE column (Valid)
INSERT INTO test13 VALUES (NULL, 'isha');  -- Works! (Multiple NULLs allowed in UNIQUE key)

SELECT * FROM test13;




-- =================================================================
-- 1. SQL CONSTRAINTS DEFINITION
-- =================================================================

/*
  DEFINITION:
  - Constraints columns par apply hone wale Rules ka ek set hote hain.
  - Purpose: Invalid data entry ko prevent karna (Data Integrity maintain rakhna).
  - Real life analogy: Like an "Entry Security Guard" (jo invalid/bad entry rokta hai).
*/


-- =================================================================
-- 2. NOT NULL CONSTRAINT
-- =================================================================

/*
  CONCEPT:
  - Default behavior: SQL mein columns NULL values accept karte hain.
  - Jab hum kisi column par `NOT NULL` specify karte hain, toh wo column 
    empty (NULL) values strictly disallow kar deta hai.
*/

-- Without NOT NULL (Default Behavior):
CREATE TABLE test9_demo (
    id INT,
    name VARCHAR(20)
);

INSERT INTO test9_demo VALUES (10, 'abhishek');
INSERT INTO test9_demo VALUES (10, NULL); -- Works fine (NULL stored)

DROP TABLE test9_demo;


-- With NOT NULL Constraint:
CREATE TABLE test9 (
    id INT,
    name VARCHAR(20) NOT NULL
);

INSERT INTO test9 VALUES (10, 'abhishek'); -- Valid

-- Trying to insert NULL into NOT NULL column:
-- INSERT INTO test9 VALUES (10, NULL); 
-- Result: ERROR 1048 (23000): Column 'name' cannot be null

SELECT * FROM test9;


-- =================================================================
-- 3. PRIMARY KEY CONSTRAINT
-- =================================================================

/*
  CONCEPT:
  - PRIMARY KEY = UNIQUE + NOT NULL
  - Characteristics:
    1. Table ke har row ko uniquely identify karta hai.
    2. Strict Rule: Ek Table mein sirf ONE PRIMARY KEY ho sakti hai ("1 table only 1").
    3. Duplicate values allow nahi hoti.
    4. NULL values allow nahi hoti.
*/

CREATE TABLE test14 (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);

-- First Entry (Valid)
INSERT INTO test14 VALUES (10, 'abhishek');

-- Duplicate Key Insertion (Invalid -> Fails UNIQUE property)
-- INSERT INTO test14 VALUES (10, 'ads'); 
-- Result: Error Code 1062: Duplicate entry '10' for key 'test14.PRIMARY'

-- NULL Key Insertion (Invalid -> Fails NOT NULL property)
-- INSERT INTO test14 VALUES (NULL, 'ads'); 
-- Result: Error Code 1048: Column 'id' cannot be null

SELECT * FROM test14;
