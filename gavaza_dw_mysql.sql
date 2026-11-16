-- GAVAZA SESINYANI DESIGN APRONS (PTY) LTD
-- E-Commerce Sales Analytics & Data Warehouse
-- MySQL / PostgreSQL 

CREATE DATABASE IF NOT EXISTS gavaza_dw;
USE gavaza_dw;

-- 1. OLTP TABLES (RAW / SOURCE DATA) - 100 records each


CREATE TABLE locations (
    location_id    INT PRIMARY KEY,
    street_address VARCHAR(120),
    city           VARCHAR(60),
    province       VARCHAR(60),
    postal_code    VARCHAR(10),
    country        VARCHAR(60)
);

CREATE TABLE customers (
    customer_id          INT PRIMARY KEY,
    first_name           VARCHAR(60),
    last_name            VARCHAR(60),
    email                VARCHAR(120),
    phone                VARCHAR(20),
    location_id          INT,
    registration_date    DATE,
    total_lifetime_spend DECIMAL(10,2),
    segment              VARCHAR(20),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(120),
    category        VARCHAR(60),
    sku             VARCHAR(30),
    unit_price      DECIMAL(10,2),
    cost_price      DECIMAL(10,2),
    stock_quantity  INT,
    supplier        VARCHAR(80)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    location_id  INT,
    order_date   DATE,
    status       VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE order_lines (
    line_id      INT PRIMARY KEY,
    order_id     INT,
    product_id   INT,
    quantity     INT,
    unit_price   DECIMAL(10,2),
    line_total   DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id     INT PRIMARY KEY,
    order_id       INT,
    payment_date   DATE,
    payment_method VARCHAR(30),
    amount         DECIMAL(10,2),
    status         VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ---------- CLEANING: fix bad phone numbers, dedupe emails, standardise status ----------
UPDATE customers SET phone = REPLACE(phone, ' ', '') WHERE phone LIKE '% %';
UPDATE orders SET status = 'Delivered' WHERE status = 'delivered';
UPDATE payments SET status = 'Completed' WHERE status = 'completed';

-- ---------- INSERTS ----------

INSERT INTO locations (location_id, street_address, city, province, postal_code, country) VALUES
(1, '115 Mandela Road', 'Worcester', 'Western Cape', '5012', 'South Africa'),
(2, '143 Church Street', 'Pietermaritzburg', 'KwaZulu-Natal', '7912', 'South Africa'),
(3, '31 Church Avenue', 'Gqeberha', 'Eastern Cape', '4811', 'South Africa'),
(4, '617 Mandela Avenue', 'Lephalale', 'Limpopo', '9928', 'South Africa'),
(5, '226 Albertina Sisulu Road', 'Lydenburg', 'Mpumalanga', '1106', 'South Africa'),
(6, '715 Chris Hani Road', 'Potchefstroom', 'North West', '5552', 'South Africa'),
(7, '221 Pixley ka Seme Street', 'Bethlehem', 'Free State', '2519', 'South Africa'),
(8, '100 Pixley ka Seme Road', 'De Aar', 'Northern Cape', '5333', 'South Africa'),
(9, '748 Albertina Sisulu Street', 'Johannesburg', 'Gauteng', '7201', 'South Africa'),
(10, '566 Long Road', 'Cape Town', 'Western Cape', '4150', 'South Africa'),
(11, '72 Mandela Avenue', 'Umhlanga', 'KwaZulu-Natal', '5741', 'South Africa'),
(12, '876 Voortrekker Street', 'Gqeberha', 'Eastern Cape', '7227', 'South Africa'),
(13, '465 Pixley ka Seme Avenue', 'Tzaneen', 'Limpopo', '7065', 'South Africa'),
(14, '215 Long Street', 'Secunda', 'Mpumalanga', '3803', 'South Africa'),
(15, '747 Voortrekker Avenue', 'Brits', 'North West', '8573', 'South Africa'),
(16, '277 Jan Smuts Avenue', 'Sasolburg', 'Free State', '6313', 'South Africa'),
(17, '235 Mandela Road', 'Kimberley', 'Northern Cape', '7572', 'South Africa'),
(18, '68 Voortrekker Road', 'Midrand', 'Gauteng', '4483', 'South Africa'),
(19, '512 Chris Hani Drive', 'Worcester', 'Western Cape', '3340', 'South Africa'),
(20, '143 Voortrekker Road', 'Richards Bay', 'KwaZulu-Natal', '8019', 'South Africa'),
(21, '409 Pixley ka Seme Avenue', 'Mossel Bay', 'Eastern Cape', '3266', 'South Africa'),
(22, '506 Church Street', 'Lephalale', 'Limpopo', '2796', 'South Africa'),
(23, '643 Main Drive', 'Emalahleni', 'Mpumalanga', '2040', 'South Africa'),
(24, '391 Oxford Drive', 'Mahikeng', 'North West', '9669', 'South Africa'),
(25, '995 Jan Smuts Street', 'Welkom', 'Free State', '2876', 'South Africa'),
(26, '788 Pixley ka Seme Street', 'Springbok', 'Northern Cape', '5808', 'South Africa'),
(27, '162 Albertina Sisulu Street', 'Vereeniging', 'Gauteng', '5315', 'South Africa'),
(28, '781 Main Street', 'Somerset West', 'Western Cape', '5889', 'South Africa'),
(29, '520 Oxford Avenue', 'Umhlanga', 'KwaZulu-Natal', '3504', 'South Africa'),
(30, '781 Main Street', 'Mthatha', 'Eastern Cape', '6310', 'South Africa'),
(31, '20 Church Road', 'Mokopane', 'Limpopo', '6038', 'South Africa'),
(32, '60 Voortrekker Street', 'Emalahleni', 'Mpumalanga', '2403', 'South Africa'),
(33, '836 Church Avenue', 'Mahikeng', 'North West', '3103', 'South Africa'),
(34, '970 Jan Smuts Avenue', 'Sasolburg', 'Free State', '5342', 'South Africa'),
(35, '988 Voortrekker Avenue', 'De Aar', 'Northern Cape', '6107', 'South Africa'),
(36, '688 Pixley ka Seme Drive', 'Vereeniging', 'Gauteng', '9479', 'South Africa'),
(37, '124 Voortrekker Avenue', 'George', 'Western Cape', '2049', 'South Africa'),
(38, '22 Oxford Avenue', 'Richards Bay', 'KwaZulu-Natal', '4608', 'South Africa'),
(39, '73 Mandela Avenue', 'Gqeberha', 'Eastern Cape', '2104', 'South Africa'),
(40, '881 Pixley ka Seme Street', 'Polokwane', 'Limpopo', '9423', 'South Africa'),
(41, '286 Albertina Sisulu Avenue', 'Emalahleni', 'Mpumalanga', '9834', 'South Africa'),
(42, '741 Oxford Drive', 'Potchefstroom', 'North West', '4981', 'South Africa'),
(43, '827 Chris Hani Avenue', 'Sasolburg', 'Free State', '2545', 'South Africa'),
(44, '675 Chris Hani Road', 'Kimberley', 'Northern Cape', '7939', 'South Africa'),
(45, '479 Mandela Street', 'Vereeniging', 'Gauteng', '1993', 'South Africa'),
(46, '746 Pixley ka Seme Street', 'George', 'Western Cape', '5073', 'South Africa'),
(47, '195 Jan Smuts Drive', 'Pietermaritzburg', 'KwaZulu-Natal', '3296', 'South Africa'),
(48, '188 Long Drive', 'Grahamstown', 'Eastern Cape', '5092', 'South Africa'),
(49, '454 Jan Smuts Street', 'Polokwane', 'Limpopo', '1828', 'South Africa'),
(50, '857 Mandela Street', 'Ermelo', 'Mpumalanga', '4872', 'South Africa'),
(51, '417 Albertina Sisulu Drive', 'Potchefstroom', 'North West', '4502', 'South Africa'),
(52, '925 Mandela Avenue', 'Sasolburg', 'Free State', '7209', 'South Africa'),
(53, '400 Long Drive', 'Kimberley', 'Northern Cape', '5673', 'South Africa'),
(54, '714 Jan Smuts Drive', 'Vereeniging', 'Gauteng', '3536', 'South Africa'),
(55, '304 Voortrekker Street', 'Stellenbosch', 'Western Cape', '9883', 'South Africa'),
(56, '766 Pixley ka Seme Street', 'Durban', 'KwaZulu-Natal', '1821', 'South Africa'),
(57, '489 Jan Smuts Avenue', 'Mossel Bay', 'Eastern Cape', '1931', 'South Africa'),
(58, '83 Main Street', 'Lephalale', 'Limpopo', '2113', 'South Africa'),
(59, '414 Church Avenue', 'Emalahleni', 'Mpumalanga', '1651', 'South Africa'),
(60, '84 Chris Hani Road', 'Brits', 'North West', '5272', 'South Africa'),
(61, '686 Pixley ka Seme Avenue', 'Bethlehem', 'Free State', '5351', 'South Africa'),
(62, '135 Long Drive', 'De Aar', 'Northern Cape', '6180', 'South Africa'),
(63, '10 Albertina Sisulu Street', 'Pretoria', 'Gauteng', '2200', 'South Africa'),
(64, '219 Jan Smuts Road', 'Somerset West', 'Western Cape', '3170', 'South Africa'),
(65, '903 Church Avenue', 'Richards Bay', 'KwaZulu-Natal', '7054', 'South Africa'),
(66, '162 Albertina Sisulu Road', 'Mthatha', 'Eastern Cape', '9666', 'South Africa'),
(67, '684 Jan Smuts Road', 'Polokwane', 'Limpopo', '2697', 'South Africa'),
(68, '271 Church Street', 'Emalahleni', 'Mpumalanga', '3546', 'South Africa'),
(69, '289 Oxford Avenue', 'Klerksdorp', 'North West', '6617', 'South Africa'),
(70, '704 Long Drive', 'Bethlehem', 'Free State', '5114', 'South Africa'),
(71, '95 Chris Hani Road', 'Kimberley', 'Northern Cape', '1722', 'South Africa'),
(72, '342 Main Road', 'Johannesburg', 'Gauteng', '3647', 'South Africa'),
(73, '453 Jan Smuts Drive', 'Worcester', 'Western Cape', '1158', 'South Africa'),
(74, '78 Main Street', 'Durban', 'KwaZulu-Natal', '7049', 'South Africa'),
(75, '566 Main Drive', 'Mossel Bay', 'Eastern Cape', '3088', 'South Africa'),
(76, '316 Pixley ka Seme Street', 'Polokwane', 'Limpopo', '6862', 'South Africa'),
(77, '699 Voortrekker Street', 'Emalahleni', 'Mpumalanga', '6794', 'South Africa'),
(78, '906 Chris Hani Avenue', 'Brits', 'North West', '4878', 'South Africa'),
(79, '820 Main Drive', 'Bethlehem', 'Free State', '1406', 'South Africa'),
(80, '755 Pixley ka Seme Drive', 'Upington', 'Northern Cape', '5065', 'South Africa'),
(81, '164 Church Drive', 'Midrand', 'Gauteng', '1634', 'South Africa'),
(82, '228 Voortrekker Drive', 'George', 'Western Cape', '6728', 'South Africa'),
(83, '841 Voortrekker Avenue', 'Richards Bay', 'KwaZulu-Natal', '1387', 'South Africa'),
(84, '409 Pixley ka Seme Road', 'East London', 'Eastern Cape', '2137', 'South Africa'),
(85, '360 Jan Smuts Drive', 'Tzaneen', 'Limpopo', '9785', 'South Africa'),
(86, '962 Mandela Street', 'Secunda', 'Mpumalanga', '5279', 'South Africa'),
(87, '595 Long Street', 'Potchefstroom', 'North West', '2776', 'South Africa'),
(88, '445 Pixley ka Seme Road', 'Bloemfontein', 'Free State', '8149', 'South Africa'),
(89, '395 Oxford Avenue', 'Kimberley', 'Northern Cape', '5173', 'South Africa'),
(90, '726 Chris Hani Street', 'Johannesburg', 'Gauteng', '9518', 'South Africa'),
(91, '704 Voortrekker Road', 'Somerset West', 'Western Cape', '8066', 'South Africa'),
(92, '972 Pixley ka Seme Road', 'Durban', 'KwaZulu-Natal', '3041', 'South Africa'),
(93, '520 Long Drive', 'Mthatha', 'Eastern Cape', '6344', 'South Africa'),
(94, '714 Long Avenue', 'Mokopane', 'Limpopo', '4143', 'South Africa'),
(95, '681 Chris Hani Avenue', 'Lydenburg', 'Mpumalanga', '5930', 'South Africa'),
(96, '562 Mandela Road', 'Mahikeng', 'North West', '5700', 'South Africa'),
(97, '441 Oxford Road', 'Bethlehem', 'Free State', '8618', 'South Africa'),
(98, '453 Voortrekker Drive', 'De Aar', 'Northern Cape', '3780', 'South Africa'),
(99, '291 Jan Smuts Road', 'Pretoria', 'Gauteng', '2530', 'South Africa'),
(100, '689 Long Avenue', 'Stellenbosch', 'Western Cape', '4262', 'South Africa');

INSERT INTO customers (customer_id, first_name, last_name, email, phone, location_id, registration_date, total_lifetime_spend, segment) VALUES
(1, 'Karabo', 'Dlamini', 'karabo.dlamini61@outlook.com', '051 174 8461', 54, '2022-04-05', 3672.64, 'Regular'),
(2, 'Peter', 'Naidoo', 'peter.naidoo90@yahoo.com', '017 509 4997', 19, '2025-03-24', 2916.53, 'Regular'),
(3, 'Michael', 'Chetty', 'michael.chetty99@gmail.com', '051 535 4585', 23, '2022-01-12', 13389.9, 'VIP'),
(4, 'Chloe', 'Chetty', 'chloe.chetty72@gmail.com', '011 567 3184', 60, '2024-11-26', 6968.25, 'Loyal'),
(5, 'Jessica', 'du Plessis', 'jessica.duplessis97@yahoo.com', '021 934 9270', 55, '2025-02-18', 8931.78, 'Loyal'),
(6, 'Hannah', 'Coetzee', 'hannah.coetzee96@yahoo.com', '017 365 5050', 82, '2024-07-02', 13458.12, 'VIP'),
(7, 'Katlego', 'Jacobs', 'katlego.jacobs31@yahoo.com', '017 179 5681', 31, '2024-12-03', 7268.96, 'Loyal'),
(8, 'Katlego', 'Mashaba', 'katlego.mashaba11@gmail.com', '012 336 7275', 89, '2023-10-17', 13395.4, 'VIP'),
(9, 'Karabo', 'Patel', 'karabo.patel53@yahoo.com', '018 577 7812', 8, '2023-03-15', 963.43, 'New'),
(10, 'Sibusiso', 'Mabaso', 'sibusiso.mabaso75@outlook.com', '010 977 7232', 62, '2024-03-08', 13572.58, 'VIP'),
(11, 'Thabo', 'Selepe', 'thabo.selepe54@outlook.com', '041 852 9947', 78, '2023-09-04', 11302.13, 'VIP'),
(12, 'Grace', 'Shabalala', 'grace.shabalala56@yahoo.com', '010 498 6507', 86, '2024-09-26', 3291.32, 'Regular'),
(13, 'Daniel', 'Chauke', 'daniel.chauke17@outlook.com', '018 127 7455', 76, '2022-12-05', 12607.58, 'VIP'),
(14, 'Tumelo', 'Moodley', 'tumelo.moodley55@gmail.com', '017 286 1823', 34, '2022-02-25', 1259.21, 'Regular'),
(15, 'Boitumelo', 'Mahlangu', 'boitumelo.mahlangu44@yahoo.com', '014 870 7906', 33, '2023-03-10', 6820.49, 'Loyal'),
(16, 'Hannah', 'Zulu', 'hannah.zulu70@gmail.com', '015 329 2124', 100, '2024-08-21', 290.75, 'New'),
(17, 'Michael', 'Ndlovu', 'michael.ndlovu26@gmail.com', '021 256 4908', 17, '2022-03-05', 14244.18, 'VIP'),
(18, 'Rethabile', 'Moodley', 'rethabile.moodley28@yahoo.com', '041 362 7043', 22, '2022-08-23', 8459.54, 'Loyal'),
(19, 'Kea', 'Venter', 'kea.venter21@yahoo.com', '011 692 1420', 40, '2022-08-23', 11666.88, 'VIP'),
(20, 'Tumelo', 'Reddy', 'tumelo.reddy92@gmail.com', '011 706 4978', 14, '2024-02-08', 5949.82, 'Loyal'),
(21, 'Emma', 'Jacobs', 'emma.jacobs77@gmail.com', '051 679 1672', 45, '2023-09-10', 12754.4, 'VIP'),
(22, 'Neo', 'Rikhotso', 'neo.rikhotso65@outlook.com', '015 112 7882', 63, '2025-09-16', 5558.56, 'Loyal'),
(23, 'Kagiso', 'Rikhotso', 'kagiso.rikhotso59@outlook.com', '012 545 3885', 94, '2024-01-12', 9533.78, 'VIP'),
(24, 'Tsholofelo', 'Pillay', 'tsholofelo.pillay69@yahoo.com', '017 546 5397', 42, '2023-07-08', 9238.69, 'VIP'),
(25, 'Joshua', 'Ngcobo', 'joshua.ngcobo58@gmail.com', '051 575 7209', 44, '2022-06-27', 4183.92, 'Loyal'),
(26, 'Naledi', 'Botha', 'naledi.botha28@yahoo.com', '051 364 6576', 36, '2023-10-28', 2727.6, 'Regular'),
(27, 'Peter', 'Venter', 'peter.venter67@gmail.com', '011 347 7658', 63, '2023-07-20', 8336.87, 'Loyal'),
(28, 'Ofentse', 'Petersen', 'ofentse.petersen83@outlook.com', '017 558 1282', 12, '2023-05-08', 10359.14, 'VIP'),
(29, 'Dineo', 'Shabalala', 'dineo.shabalala40@outlook.com', '021 477 8753', 71, '2024-04-08', 10376.81, 'VIP'),
(30, 'Tsholofelo', 'Selepe', 'tsholofelo.selepe71@yahoo.com', '015 819 8434', 35, '2024-05-21', 14949.47, 'VIP'),
(31, 'Themba', 'Zungu', 'themba.zungu25@yahoo.com', '011 860 9779', 98, '2023-04-18', 1809.84, 'Regular'),
(32, 'Emma', 'Hadebe', 'emma.hadebe62@yahoo.com', '041 703 9595', 77, '2023-01-28', 3245.77, 'Regular'),
(33, 'Dineo', 'Maseko', 'dineo.maseko47@gmail.com', '014 114 9751', 17, '2023-02-02', 4443.7, 'Loyal'),
(34, 'Katlego', 'Ndlovu', 'katlego.ndlovu90@gmail.com', '031 989 9042', 14, '2022-04-22', 8300.38, 'Loyal'),
(35, 'Nina', 'Mokoena', 'nina.mokoena62@yahoo.com', '015 288 1841', 33, '2025-03-21', 4265.09, 'Loyal'),
(36, 'Nina', 'van der Merwe', 'nina.vandermerwe52@yahoo.com', '011 690 1878', 20, '2022-08-22', 12331.73, 'VIP'),
(37, 'Karabo', 'Fourie', 'karabo.fourie32@gmail.com', '018 882 7818', 78, '2023-09-15', 1277.71, 'Regular'),
(38, 'Kea', 'Oosthuizen', 'kea.oosthuizen49@yahoo.com', '017 404 8025', 40, '2023-04-08', 11635.4, 'VIP'),
(39, 'Tumelo', 'Oosthuizen', 'tumelo.oosthuizen95@gmail.com', '051 312 4457', 34, '2022-05-04', 9144.46, 'VIP'),
(40, 'Jessica', 'Zulu', 'jessica.zulu71@gmail.com', '012 102 7693', 58, '2022-11-18', 3597.98, 'Regular'),
(41, 'Emma', 'Venter', 'emma.venter30@yahoo.com', '041 389 8438', 10, '2024-08-20', 4368.89, 'Loyal'),
(42, 'Daniel', 'Shabalala', 'daniel.shabalala81@outlook.com', '031 923 4241', 55, '2023-06-26', 11817.42, 'VIP'),
(43, 'Palesa', 'Steyn', 'palesa.steyn35@gmail.com', '011 161 3718', 40, '2023-04-06', 9714.52, 'VIP'),
(44, 'Kea', 'Abrahams', 'kea.abrahams57@gmail.com', '017 805 5982', 90, '2025-03-11', 13817.89, 'VIP'),
(45, 'Kefilwe', 'Mdluli', 'kefilwe.mdluli57@gmail.com', '021 140 8078', 95, '2024-10-21', 8099.72, 'Loyal'),
(46, 'Anelisa', 'Venter', 'anelisa.venter30@outlook.com', '021 701 1339', 98, '2023-05-28', 387.97, 'New'),
(47, 'Daniel', 'Mdluli', 'daniel.mdluli97@gmail.com', '017 631 8245', 36, '2025-03-26', 603.48, 'New'),
(48, 'Mandla', 'Nel', 'mandla.nel63@gmail.com', '017 456 7690', 43, '2024-06-11', 9521.77, 'VIP'),
(49, 'Anelisa', 'Moodley', 'anelisa.moodley43@yahoo.com', '041 607 5722', 85, '2022-08-03', 12866.0, 'VIP'),
(50, 'Kefilwe', 'Petersen', 'kefilwe.petersen12@yahoo.com', '014 431 2899', 99, '2025-01-31', 550.46, 'New'),
(51, 'Kefilwe', 'Pretorius', 'kefilwe.pretorius70@yahoo.com', '016 155 4073', 67, '2022-01-03', 9864.91, 'VIP'),
(52, 'Musa', 'Oosthuizen', 'musa.oosthuizen98@gmail.com', '013 373 9998', 17, '2024-10-17', 9381.13, 'VIP'),
(53, 'Rebecca', 'Gumede', 'rebecca.gumede63@gmail.com', '010 745 4920', 91, '2024-06-16', 13212.7, 'VIP'),
(54, 'Ayanda', 'Ndovela', 'ayanda.ndovela53@gmail.com', '013 961 2858', 60, '2025-02-02', 205.12, 'New'),
(55, 'Palesa', 'Pillay', 'palesa.pillay92@yahoo.com', '018 822 5479', 54, '2022-11-12', 7475.63, 'Loyal'),
(56, 'Hannah', 'van der Merwe', 'hannah.vandermerwe71@gmail.com', '016 295 9327', 96, '2024-08-25', 3655.96, 'Regular'),
(57, 'Peter', 'Cele', 'peter.cele54@yahoo.com', '051 619 5377', 1, '2022-05-23', 4143.71, 'Loyal'),
(58, 'Dineo', 'Isaacs', 'dineo.isaacs75@outlook.com', '017 986 3434', 58, '2023-09-04', 12562.14, 'VIP'),
(59, 'Neo', 'van der Merwe', 'neo.vandermerwe98@outlook.com', '016 566 6272', 25, '2023-12-08', 4986.6, 'Loyal'),
(60, 'Emma', 'Ngcobo', 'emma.ngcobo53@gmail.com', '015 862 8749', 91, '2025-03-17', 5744.56, 'Loyal'),
(61, 'David', 'Baloyi', 'david.baloyi84@gmail.com', '017 137 3068', 65, '2024-03-01', 14826.21, 'VIP'),
(62, 'Mpho', 'Mashaba', 'mpho.mashaba57@gmail.com', '018 567 1251', 93, '2022-07-25', 13112.86, 'VIP'),
(63, 'Karabo', 'Mabaso', 'karabo.mabaso10@yahoo.com', '051 371 6546', 80, '2025-09-02', 14549.35, 'VIP'),
(64, 'Emma', 'Chauke', 'emma.chauke43@outlook.com', '018 489 6188', 81, '2025-08-23', 1204.73, 'Regular'),
(65, 'James', 'Petersen', 'james.petersen5@outlook.com', '011 340 5708', 30, '2024-09-26', 13085.75, 'VIP'),
(66, 'Rajesh', 'Zulu', 'rajesh.zulu98@outlook.com', '041 993 2646', 57, '2024-06-07', 14675.07, 'VIP'),
(67, 'Ayanda', 'Chetty', 'ayanda.chetty6@yahoo.com', '051 157 5806', 46, '2023-09-06', 13551.36, 'VIP'),
(68, 'Musa', 'Rikhotso', 'musa.rikhotso53@outlook.com', '031 911 3950', 22, '2022-10-26', 3662.96, 'Regular'),
(69, 'Mandla', 'Zulu', 'mandla.zulu80@outlook.com', '013 609 3344', 30, '2025-06-02', 13062.59, 'VIP'),
(70, 'Onalenna', 'Naidoo', 'onalenna.naidoo86@gmail.com', '051 576 5712', 87, '2023-06-05', 6893.56, 'Loyal'),
(71, 'Neo', 'Buthelezi', 'neo.buthelezi45@outlook.com', '014 754 7951', 89, '2022-06-01', 6625.95, 'Loyal'),
(72, 'Refilwe', 'Tshabalala', 'refilwe.tshabalala50@yahoo.com', '011 342 7248', 74, '2023-09-11', 2988.25, 'Regular'),
(73, 'Nandi', 'Fourie', 'nandi.fourie38@gmail.com', '031 505 5497', 2, '2023-08-29', 14890.38, 'VIP'),
(74, 'Fatima', 'Abrahams', 'fatima.abrahams96@yahoo.com', '014 894 4770', 78, '2022-04-11', 13659.25, 'VIP'),
(75, 'Chloe', 'Selepe', 'chloe.selepe80@yahoo.com', '031 873 3240', 81, '2023-03-25', 9549.27, 'VIP'),
(76, 'Kagiso', 'Naidoo', 'kagiso.naidoo57@gmail.com', '021 473 3153', 12, '2025-08-16', 591.34, 'New'),
(77, 'David', 'Gumede', 'david.gumede23@gmail.com', '012 905 9837', 47, '2023-11-01', 11212.21, 'VIP'),
(78, 'Tsholofelo', 'Pretorius', 'tsholofelo.pretorius33@yahoo.com', '051 402 6549', 15, '2023-07-13', 12457.09, 'VIP'),
(79, 'Onalenna', 'Mthembu', 'onalenna.mthembu29@outlook.com', '041 790 7511', 72, '2022-10-16', 11312.27, 'VIP'),
(80, 'Musa', 'Zulu', 'musa.zulu69@gmail.com', '017 477 5295', 75, '2024-03-19', 208.78, 'New'),
(81, 'Boitumelo', 'Naidoo', 'boitumelo.naidoo30@yahoo.com', '010 734 6374', 79, '2024-01-31', 1625.19, 'Regular'),
(82, 'Nokuthula', 'Pillay', 'nokuthula.pillay60@outlook.com', '014 764 7689', 15, '2022-05-10', 9531.06, 'VIP'),
(83, 'Tshepo', 'Ndlovu', 'tshepo.ndlovu64@gmail.com', '011 340 9807', 18, '2022-03-18', 4565.47, 'Loyal'),
(84, 'Boitumelo', 'Tshabalala', 'boitumelo.tshabalala96@outlook.com', '018 529 3531', 54, '2024-01-30', 10057.29, 'VIP'),
(85, 'Michael', 'Maseko', 'michael.maseko36@gmail.com', '041 479 4559', 57, '2024-09-29', 9234.78, 'VIP'),
(86, 'Lebogang', 'Ngcobo', 'lebogang.ngcobo88@yahoo.com', '018 760 6876', 8, '2024-01-13', 1490.32, 'Regular'),
(87, 'Zanele', 'Sithole', 'zanele.sithole28@outlook.com', '031 711 1349', 7, '2024-07-20', 1375.1, 'Regular'),
(88, 'Oliver', 'Mashaba', 'oliver.mashaba73@gmail.com', '011 949 4394', 76, '2023-05-14', 14832.31, 'VIP'),
(89, 'Sibusiso', 'Shabalala', 'sibusiso.shabalala77@gmail.com', '014 979 3370', 17, '2023-11-04', 11615.53, 'VIP'),
(90, 'Neo', 'Zungu', 'neo.zungu4@gmail.com', '010 466 4898', 76, '2022-12-24', 1648.9, 'Regular'),
(91, 'Anelisa', 'Dlamini', 'anelisa.dlamini17@outlook.com', '016 638 2862', 96, '2022-12-23', 3980.51, 'Regular'),
(92, 'Bongani', 'van der Merwe', 'bongani.vandermerwe66@outlook.com', '011 562 9254', 29, '2024-07-07', 11670.26, 'VIP'),
(93, 'Wandile', 'Ndlovu', 'wandile.ndlovu59@outlook.com', '010 162 8847', 52, '2025-09-11', 7821.77, 'Loyal'),
(94, 'Amo', 'Reddy', 'amo.reddy57@gmail.com', '011 429 3430', 9, '2022-08-10', 7354.03, 'Loyal'),
(95, 'Tshepo', 'Mdluli', 'tshepo.mdluli71@outlook.com', '015 490 9692', 38, '2025-07-02', 9496.15, 'VIP'),
(96, 'Onalenna', 'Pretorius', 'onalenna.pretorius90@gmail.com', '031 766 4522', 56, '2025-05-24', 6452.99, 'Loyal'),
(97, 'Lebogang', 'Shabalala', 'lebogang.shabalala59@yahoo.com', '016 847 2557', 41, '2024-04-27', 5083.97, 'Loyal'),
(98, 'Amo', 'Mahlangu', 'amo.mahlangu20@outlook.com', '017 168 2494', 11, '2025-09-24', 3823.35, 'Regular'),
(99, 'Nomvula', 'Rikhotso', 'nomvula.rikhotso48@gmail.com', '018 161 6400', 86, '2022-07-17', 11168.83, 'VIP'),
(100, 'Palesa', 'Mabaso', 'palesa.mabaso97@yahoo.com', '041 152 5712', 77, '2023-12-26', 13104.11, 'VIP');

INSERT INTO products (product_id, product_name, category, sku, unit_price, cost_price, stock_quantity, supplier) VALUES
(1, 'Premium Grey Barista Apron', 'Barista Aprons', 'GSD-BAR-1001', 393.73, 217.14, 79, 'Karoo Leather Goods'),
(2, 'Premium Olive Welding Apron', 'Welding Aprons', 'GSD-WEL-1002', 618.18, 382.7, 188, 'Gavaza Sesinyani Workshop JHB'),
(3, 'Heritage Mustard Denim Apron', 'Denim Aprons', 'GSD-DEN-1003', 562.16, 347.99, 285, 'Gavaza Sesinyani Workshop JHB'),
(4, 'Signature Black Leather Apron', 'Leather Aprons', 'GSD-LEA-1004', 1148.1, 558.07, 158, 'Cape Canvas Co.'),
(5, 'Artisan Khaki Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1005', 287.76, 162.08, 205, 'Gavaza Sesinyani Workshop JHB'),
(6, 'Classic Navy Kids Apron', 'Kids Aprons', 'GSD-KID-1006', 171.28, 102.63, 110, 'Karoo Leather Goods'),
(7, 'Rustic Khaki Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1007', 263.97, 138.32, 166, 'Durban Denim Works'),
(8, 'Classic Khaki Braai Apron', 'Braai Aprons', 'GSD-BRA-1008', 375.02, 180.57, 25, 'Gavaza Sesinyani Workshop JHB'),
(9, 'Executive Teal Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1009', 472.45, 269.97, 212, 'Cape Canvas Co.'),
(10, 'Premium Olive Chef Apron', 'Chef Aprons', 'GSD-CHE-1010', 314.67, 168.66, 145, 'Durban Denim Works'),
(11, 'Signature Black Barista Apron', 'Barista Aprons', 'GSD-BAR-1011', 445.99, 220.37, 28, 'Gavaza Sesinyani Workshop JHB'),
(12, 'Heritage Khaki Welding Apron', 'Welding Aprons', 'GSD-WEL-1012', 603.32, 363.7, 148, 'Cape Canvas Co.'),
(13, 'Everyday Red Denim Apron', 'Denim Aprons', 'GSD-DEN-1013', 324.39, 173.92, 66, 'Karoo Leather Goods'),
(14, 'Heritage Brown Leather Apron', 'Leather Aprons', 'GSD-LEA-1014', 1079.32, 606.3, 181, 'Gavaza Sesinyani Workshop JHB'),
(15, 'Classic Mustard Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1015', 299.27, 135.79, 39, 'Cape Canvas Co.'),
(16, 'Executive Red Kids Apron', 'Kids Aprons', 'GSD-KID-1016', 236.36, 136.62, 148, 'Gavaza Sesinyani Workshop JHB'),
(17, 'Rustic Khaki Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1017', 261.01, 159.29, 235, 'Cape Canvas Co.'),
(18, 'Premium Charcoal Braai Apron', 'Braai Aprons', 'GSD-BRA-1018', 242.91, 130.48, 205, 'Durban Denim Works'),
(19, 'Signature Red Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1019', 385.39, 199.59, 170, 'Umzansi Textiles'),
(20, 'Premium Brown Chef Apron', 'Chef Aprons', 'GSD-CHE-1020', 272.91, 150.64, 178, 'Cape Canvas Co.'),
(21, 'Artisan Charcoal Barista Apron', 'Barista Aprons', 'GSD-BAR-1021', 518.21, 243.85, 131, 'Umzansi Textiles'),
(22, 'Artisan White Welding Apron', 'Welding Aprons', 'GSD-WEL-1022', 580.12, 269.8, 252, 'Karoo Leather Goods'),
(23, 'Everyday White Denim Apron', 'Denim Aprons', 'GSD-DEN-1023', 559.14, 354.96, 289, 'Durban Denim Works'),
(24, 'Rustic Khaki Leather Apron', 'Leather Aprons', 'GSD-LEA-1024', 890.89, 479.26, 240, 'Karoo Leather Goods'),
(25, 'Signature Grey Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1025', 357.85, 165.05, 259, 'Gavaza Sesinyani Workshop JHB'),
(26, 'Everyday Black Kids Apron', 'Kids Aprons', 'GSD-KID-1026', 196.56, 90.69, 146, 'Gavaza Sesinyani Workshop JHB'),
(27, 'Premium Grey Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1027', 308.93, 175.72, 196, 'Karoo Leather Goods'),
(28, 'Classic Teal Braai Apron', 'Braai Aprons', 'GSD-BRA-1028', 370.89, 234.33, 292, 'Umzansi Textiles'),
(29, 'Everyday Brown Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1029', 494.69, 237.54, 31, 'Karoo Leather Goods'),
(30, 'Rustic Red Chef Apron', 'Chef Aprons', 'GSD-CHE-1030', 281.05, 131.21, 88, 'Gavaza Sesinyani Workshop JHB'),
(31, 'Everyday Teal Barista Apron', 'Barista Aprons', 'GSD-BAR-1031', 374.32, 207.68, 81, 'Cape Canvas Co.'),
(32, 'Signature Mustard Welding Apron', 'Welding Aprons', 'GSD-WEL-1032', 729.64, 387.99, 173, 'Durban Denim Works'),
(33, 'Rustic Navy Denim Apron', 'Denim Aprons', 'GSD-DEN-1033', 299.38, 154.46, 285, 'Karoo Leather Goods'),
(34, 'Artisan Olive Leather Apron', 'Leather Aprons', 'GSD-LEA-1034', 855.73, 399.03, 72, 'Cape Canvas Co.'),
(35, 'Executive Khaki Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1035', 277.56, 157.93, 43, 'Cape Canvas Co.'),
(36, 'Rustic Khaki Kids Apron', 'Kids Aprons', 'GSD-KID-1036', 233.84, 136.57, 269, 'Gavaza Sesinyani Workshop JHB'),
(37, 'Executive Brown Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1037', 309.2, 161.52, 185, 'Cape Canvas Co.'),
(38, 'Heritage Olive Braai Apron', 'Braai Aprons', 'GSD-BRA-1038', 266.87, 170.67, 248, 'Umzansi Textiles'),
(39, 'Artisan Khaki Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1039', 451.94, 210.35, 51, 'Durban Denim Works'),
(40, 'Classic White Chef Apron', 'Chef Aprons', 'GSD-CHE-1040', 481.26, 248.98, 67, 'Durban Denim Works'),
(41, 'Artisan Khaki Barista Apron', 'Barista Aprons', 'GSD-BAR-1041', 413.02, 254.53, 84, 'Karoo Leather Goods'),
(42, 'Rustic White Welding Apron', 'Welding Aprons', 'GSD-WEL-1042', 482.77, 286.73, 227, 'Durban Denim Works'),
(43, 'Everyday Charcoal Denim Apron', 'Denim Aprons', 'GSD-DEN-1043', 385.42, 214.6, 158, 'Karoo Leather Goods'),
(44, 'Heritage Olive Leather Apron', 'Leather Aprons', 'GSD-LEA-1044', 1413.58, 827.88, 292, 'Karoo Leather Goods'),
(45, 'Signature Mustard Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1045', 315.42, 173.66, 214, 'Umzansi Textiles'),
(46, 'Artisan Burgundy Kids Apron', 'Kids Aprons', 'GSD-KID-1046', 272.53, 125.48, 246, 'Cape Canvas Co.'),
(47, 'Premium Red Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1047', 290.91, 180.13, 63, 'Cape Canvas Co.'),
(48, 'Artisan Burgundy Braai Apron', 'Braai Aprons', 'GSD-BRA-1048', 241.81, 130.54, 262, 'Umzansi Textiles'),
(49, 'Premium Charcoal Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1049', 723.97, 444.04, 178, 'Gavaza Sesinyani Workshop JHB'),
(50, 'Executive Brown Chef Apron', 'Chef Aprons', 'GSD-CHE-1050', 374.47, 196.52, 197, 'Gavaza Sesinyani Workshop JHB'),
(51, 'Classic Olive Barista Apron', 'Barista Aprons', 'GSD-BAR-1051', 412.47, 262.4, 171, 'Umzansi Textiles'),
(52, 'Signature Teal Welding Apron', 'Welding Aprons', 'GSD-WEL-1052', 553.2, 325.95, 71, 'Karoo Leather Goods'),
(53, 'Classic Navy Denim Apron', 'Denim Aprons', 'GSD-DEN-1053', 445.98, 202.39, 110, 'Umzansi Textiles'),
(54, 'Executive Navy Leather Apron', 'Leather Aprons', 'GSD-LEA-1054', 1093.92, 662.08, 121, 'Cape Canvas Co.'),
(55, 'Heritage Mustard Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1055', 230.46, 133.16, 234, 'Gavaza Sesinyani Workshop JHB'),
(56, 'Everyday Grey Kids Apron', 'Kids Aprons', 'GSD-KID-1056', 166.63, 92.85, 263, 'Durban Denim Works'),
(57, 'Artisan Burgundy Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1057', 228.39, 122.38, 180, 'Umzansi Textiles'),
(58, 'Artisan White Braai Apron', 'Braai Aprons', 'GSD-BRA-1058', 368.37, 215.0, 268, 'Cape Canvas Co.'),
(59, 'Classic Mustard Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1059', 380.46, 237.66, 22, 'Karoo Leather Goods'),
(60, 'Signature Red Chef Apron', 'Chef Aprons', 'GSD-CHE-1060', 544.31, 246.71, 34, 'Cape Canvas Co.'),
(61, 'Premium Grey Barista Apron', 'Barista Aprons', 'GSD-BAR-1061', 372.34, 222.3, 170, 'Umzansi Textiles'),
(62, 'Rustic White Welding Apron', 'Welding Aprons', 'GSD-WEL-1062', 483.25, 234.38, 237, 'Karoo Leather Goods'),
(63, 'Artisan Navy Denim Apron', 'Denim Aprons', 'GSD-DEN-1063', 513.74, 304.76, 234, 'Gavaza Sesinyani Workshop JHB'),
(64, 'Classic Charcoal Leather Apron', 'Leather Aprons', 'GSD-LEA-1064', 864.1, 541.93, 161, 'Cape Canvas Co.'),
(65, 'Everyday Burgundy Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1065', 328.85, 150.39, 97, 'Cape Canvas Co.'),
(66, 'Classic White Kids Apron', 'Kids Aprons', 'GSD-KID-1066', 203.55, 105.11, 63, 'Cape Canvas Co.'),
(67, 'Executive Red Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1067', 267.39, 143.84, 197, 'Cape Canvas Co.'),
(68, 'Everyday Red Braai Apron', 'Braai Aprons', 'GSD-BRA-1068', 473.17, 260.01, 265, 'Cape Canvas Co.'),
(69, 'Executive Navy Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1069', 710.52, 380.92, 92, 'Durban Denim Works'),
(70, 'Premium Navy Chef Apron', 'Chef Aprons', 'GSD-CHE-1070', 338.13, 174.33, 151, 'Cape Canvas Co.'),
(71, 'Executive Khaki Barista Apron', 'Barista Aprons', 'GSD-BAR-1071', 433.77, 255.04, 179, 'Karoo Leather Goods'),
(72, 'Rustic Grey Welding Apron', 'Welding Aprons', 'GSD-WEL-1072', 481.77, 312.97, 140, 'Gavaza Sesinyani Workshop JHB'),
(73, 'Executive Olive Denim Apron', 'Denim Aprons', 'GSD-DEN-1073', 307.77, 170.08, 81, 'Gavaza Sesinyani Workshop JHB'),
(74, 'Everyday Black Leather Apron', 'Leather Aprons', 'GSD-LEA-1074', 728.5, 346.22, 120, 'Cape Canvas Co.'),
(75, 'Classic Grey Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1075', 290.54, 139.66, 230, 'Cape Canvas Co.'),
(76, 'Premium Grey Kids Apron', 'Kids Aprons', 'GSD-KID-1076', 205.8, 98.28, 187, 'Karoo Leather Goods'),
(77, 'Signature Charcoal Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1077', 242.88, 155.95, 13, 'Umzansi Textiles'),
(78, 'Executive Brown Braai Apron', 'Braai Aprons', 'GSD-BRA-1078', 349.75, 165.62, 133, 'Karoo Leather Goods'),
(79, 'Signature Red Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1079', 446.56, 282.8, 251, 'Umzansi Textiles'),
(80, 'Premium Teal Chef Apron', 'Chef Aprons', 'GSD-CHE-1080', 286.79, 138.96, 227, 'Gavaza Sesinyani Workshop JHB'),
(81, 'Rustic White Barista Apron', 'Barista Aprons', 'GSD-BAR-1081', 543.15, 282.16, 33, 'Durban Denim Works'),
(82, 'Signature Khaki Welding Apron', 'Welding Aprons', 'GSD-WEL-1082', 856.63, 507.43, 89, 'Cape Canvas Co.'),
(83, 'Premium Charcoal Denim Apron', 'Denim Aprons', 'GSD-DEN-1083', 468.24, 284.88, 121, 'Karoo Leather Goods'),
(84, 'Rustic Teal Leather Apron', 'Leather Aprons', 'GSD-LEA-1084', 623.66, 380.89, 282, 'Umzansi Textiles'),
(85, 'Premium Navy Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1085', 352.99, 180.68, 245, 'Durban Denim Works'),
(86, 'Executive Grey Kids Apron', 'Kids Aprons', 'GSD-KID-1086', 211.62, 98.35, 162, 'Gavaza Sesinyani Workshop JHB'),
(87, 'Rustic Khaki Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1087', 269.99, 168.9, 282, 'Durban Denim Works'),
(88, 'Artisan Mustard Braai Apron', 'Braai Aprons', 'GSD-BRA-1088', 267.31, 147.17, 28, 'Gavaza Sesinyani Workshop JHB'),
(89, 'Signature Khaki Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1089', 583.15, 281.31, 115, 'Cape Canvas Co.'),
(90, 'Signature Navy Chef Apron', 'Chef Aprons', 'GSD-CHE-1090', 534.24, 267.18, 282, 'Cape Canvas Co.'),
(91, 'Signature Grey Barista Apron', 'Barista Aprons', 'GSD-BAR-1091', 337.55, 187.91, 257, 'Umzansi Textiles'),
(92, 'Artisan Khaki Welding Apron', 'Welding Aprons', 'GSD-WEL-1092', 893.86, 520.0, 172, 'Durban Denim Works'),
(93, 'Classic Navy Denim Apron', 'Denim Aprons', 'GSD-DEN-1093', 295.24, 135.54, 295, 'Cape Canvas Co.'),
(94, 'Executive Grey Leather Apron', 'Leather Aprons', 'GSD-LEA-1094', 1186.02, 685.28, 254, 'Durban Denim Works'),
(95, 'Signature Teal Canvas Apron', 'Canvas Aprons', 'GSD-CAN-1095', 272.42, 135.93, 207, 'Cape Canvas Co.'),
(96, 'Classic Khaki Kids Apron', 'Kids Aprons', 'GSD-KID-1096', 218.03, 117.28, 247, 'Karoo Leather Goods'),
(97, 'Artisan Olive Waitress Apron', 'Waitress Aprons', 'GSD-WAI-1097', 220.8, 137.4, 163, 'Cape Canvas Co.'),
(98, 'Artisan Olive Braai Apron', 'Braai Aprons', 'GSD-BRA-1098', 473.6, 261.9, 54, 'Cape Canvas Co.'),
(99, 'Premium Burgundy Custom Printed Apron', 'Custom Printed Aprons', 'GSD-CUS-1099', 458.78, 247.7, 72, 'Gavaza Sesinyani Workshop JHB'),
(100, 'Executive Grey Chef Apron', 'Chef Aprons', 'GSD-CHE-1100', 265.18, 141.51, 81, 'Cape Canvas Co.');

INSERT INTO orders (order_id, customer_id, location_id, order_date, status) VALUES
(1, 41, 10, '2025-01-08', 'Delivered'),
(2, 64, 81, '2023-06-13', 'Returned'),
(3, 64, 81, '2024-04-23', 'Processing'),
(4, 3, 23, '2024-05-24', 'Delivered'),
(5, 65, 30, '2024-02-07', 'Delivered'),
(6, 28, 12, '2023-09-04', 'Delivered'),
(7, 7, 31, '2023-02-19', 'Delivered'),
(8, 84, 54, '2024-09-03', 'Delivered'),
(9, 69, 30, '2023-10-20', 'Delivered'),
(10, 56, 96, '2023-04-21', 'Delivered'),
(11, 94, 9, '2023-09-28', 'Delivered'),
(12, 47, 36, '2024-02-17', 'Delivered'),
(13, 73, 2, '2023-02-22', 'Delivered'),
(14, 71, 89, '2024-01-07', 'Delivered'),
(15, 65, 30, '2024-01-31', 'Delivered'),
(16, 36, 20, '2024-07-17', 'Processing'),
(17, 88, 76, '2024-09-30', 'Delivered'),
(18, 13, 76, '2023-05-12', 'Delivered'),
(19, 44, 90, '2025-03-24', 'Delivered'),
(20, 97, 41, '2024-01-10', 'Delivered'),
(21, 66, 57, '2024-09-08', 'Delivered'),
(22, 6, 82, '2023-02-11', 'Delivered'),
(23, 43, 40, '2024-12-31', 'Shipped'),
(24, 59, 25, '2024-06-15', 'Delivered'),
(25, 66, 57, '2025-07-03', 'Delivered'),
(26, 79, 72, '2025-08-11', 'Delivered'),
(27, 79, 72, '2024-02-07', 'Shipped'),
(28, 76, 12, '2023-11-03', 'Delivered'),
(29, 66, 57, '2025-04-28', 'Delivered'),
(30, 73, 2, '2024-12-26', 'Delivered'),
(31, 3, 23, '2025-04-15', 'Delivered'),
(32, 15, 33, '2024-11-20', 'Returned'),
(33, 40, 58, '2024-08-20', 'Shipped'),
(34, 89, 17, '2025-01-12', 'Delivered'),
(35, 61, 65, '2024-09-03', 'Delivered'),
(36, 100, 77, '2024-11-02', 'Delivered'),
(37, 93, 52, '2023-08-22', 'Delivered'),
(38, 22, 63, '2024-05-06', 'Delivered'),
(39, 80, 75, '2025-01-08', 'Shipped'),
(40, 19, 40, '2024-01-25', 'Processing'),
(41, 5, 55, '2023-09-06', 'Delivered'),
(42, 15, 33, '2024-12-18', 'Delivered'),
(43, 41, 10, '2024-03-27', 'Delivered'),
(44, 89, 17, '2024-02-27', 'Delivered'),
(45, 100, 77, '2024-05-28', 'Delivered'),
(46, 95, 38, '2024-04-27', 'Shipped'),
(47, 18, 22, '2024-12-23', 'Delivered'),
(48, 42, 55, '2024-07-28', 'Returned'),
(49, 68, 22, '2024-05-04', 'Delivered'),
(50, 23, 94, '2025-09-06', 'Delivered'),
(51, 44, 90, '2024-06-29', 'Delivered'),
(52, 99, 86, '2024-11-23', 'Processing'),
(53, 83, 18, '2024-11-28', 'Shipped'),
(54, 79, 72, '2023-09-28', 'Delivered'),
(55, 32, 77, '2025-09-07', 'Delivered'),
(56, 29, 71, '2023-11-02', 'Cancelled'),
(57, 39, 34, '2025-10-02', 'Shipped'),
(58, 27, 63, '2024-12-22', 'Delivered'),
(59, 41, 10, '2024-05-15', 'Delivered'),
(60, 93, 52, '2024-07-27', 'Delivered'),
(61, 74, 78, '2023-05-05', 'Delivered'),
(62, 51, 67, '2024-01-24', 'Shipped'),
(63, 99, 86, '2025-09-04', 'Shipped'),
(64, 6, 82, '2023-10-25', 'Delivered'),
(65, 11, 78, '2025-01-01', 'Delivered'),
(66, 84, 54, '2024-03-28', 'Delivered'),
(67, 28, 12, '2024-05-05', 'Delivered'),
(68, 35, 33, '2024-07-05', 'Cancelled'),
(69, 35, 33, '2024-12-13', 'Delivered'),
(70, 95, 38, '2024-09-22', 'Delivered'),
(71, 7, 31, '2023-09-06', 'Delivered'),
(72, 29, 71, '2024-06-27', 'Delivered'),
(73, 13, 76, '2023-02-23', 'Delivered'),
(74, 61, 65, '2025-01-04', 'Delivered'),
(75, 18, 22, '2025-02-28', 'Delivered'),
(76, 21, 45, '2024-07-17', 'Delivered'),
(77, 61, 65, '2025-08-15', 'Delivered'),
(78, 97, 41, '2023-07-24', 'Cancelled'),
(79, 37, 78, '2023-11-25', 'Delivered'),
(80, 99, 86, '2025-07-18', 'Delivered'),
(81, 30, 35, '2024-08-10', 'Delivered'),
(82, 5, 55, '2025-01-10', 'Processing'),
(83, 54, 60, '2023-06-29', 'Processing'),
(84, 5, 55, '2023-06-30', 'Returned'),
(85, 64, 81, '2024-02-11', 'Delivered'),
(86, 38, 40, '2025-02-05', 'Processing'),
(87, 39, 34, '2023-01-10', 'Delivered'),
(88, 43, 40, '2023-04-20', 'Delivered'),
(89, 83, 18, '2025-10-09', 'Delivered'),
(90, 18, 22, '2024-05-20', 'Processing'),
(91, 35, 33, '2024-04-24', 'Delivered'),
(92, 43, 40, '2023-04-26', 'Delivered'),
(93, 83, 18, '2024-04-14', 'Delivered'),
(94, 2, 19, '2023-07-10', 'Shipped'),
(95, 38, 40, '2025-03-20', 'Delivered'),
(96, 25, 44, '2025-02-14', 'Delivered'),
(97, 82, 15, '2025-05-26', 'Processing'),
(98, 55, 54, '2025-04-26', 'Delivered'),
(99, 52, 17, '2023-03-30', 'Delivered'),
(100, 18, 22, '2023-07-09', 'Delivered');

INSERT INTO order_lines (line_id, order_id, product_id, quantity, unit_price, line_total) VALUES
(1, 1, 1, 3, 393.73, 1181.19),
(2, 2, 31, 4, 374.32, 1497.28),
(3, 2, 97, 3, 220.8, 662.4),
(4, 3, 39, 5, 451.94, 2259.7),
(5, 3, 93, 5, 295.24, 1476.2),
(6, 4, 34, 3, 855.73, 2567.19),
(7, 5, 31, 1, 374.32, 374.32),
(8, 5, 86, 1, 211.62, 211.62),
(9, 5, 60, 3, 544.31, 1632.93),
(10, 6, 52, 5, 553.2, 2766.0),
(11, 7, 99, 3, 458.78, 1376.34),
(12, 7, 89, 1, 583.15, 583.15),
(13, 7, 82, 3, 856.63, 2569.89),
(14, 8, 79, 2, 446.56, 893.12),
(15, 8, 29, 2, 494.69, 989.38),
(16, 9, 20, 4, 272.91, 1091.64),
(17, 9, 96, 5, 218.03, 1090.15),
(18, 10, 54, 5, 1093.92, 5469.6),
(19, 10, 61, 5, 372.34, 1861.7),
(20, 11, 28, 2, 370.89, 741.78),
(21, 11, 88, 5, 267.31, 1336.55),
(22, 11, 11, 5, 445.99, 2229.95),
(23, 12, 68, 3, 473.17, 1419.51),
(24, 12, 10, 5, 314.67, 1573.35),
(25, 13, 8, 5, 375.02, 1875.1),
(26, 14, 26, 5, 196.56, 982.8),
(27, 14, 69, 2, 710.52, 1421.04),
(28, 14, 22, 3, 580.12, 1740.36),
(29, 15, 57, 1, 228.39, 228.39),
(30, 15, 88, 2, 267.31, 534.62),
(31, 15, 92, 5, 893.86, 4469.3),
(32, 16, 12, 5, 603.32, 3016.6),
(33, 16, 58, 1, 368.37, 368.37),
(34, 17, 17, 5, 261.01, 1305.05),
(35, 17, 54, 4, 1093.92, 4375.68),
(36, 18, 8, 5, 375.02, 1875.1),
(37, 18, 60, 3, 544.31, 1632.93),
(38, 18, 93, 1, 295.24, 295.24),
(39, 19, 33, 1, 299.38, 299.38),
(40, 19, 96, 2, 218.03, 436.06),
(41, 20, 10, 1, 314.67, 314.67),
(42, 20, 55, 3, 230.46, 691.38),
(43, 20, 90, 1, 534.24, 534.24),
(44, 21, 8, 1, 375.02, 375.02),
(45, 21, 61, 1, 372.34, 372.34),
(46, 21, 37, 4, 309.2, 1236.8),
(47, 22, 99, 2, 458.78, 917.56),
(48, 23, 94, 4, 1186.02, 4744.08),
(49, 23, 48, 4, 241.81, 967.24),
(50, 23, 58, 4, 368.37, 1473.48),
(51, 24, 11, 5, 445.99, 2229.95),
(52, 24, 18, 3, 242.91, 728.73),
(53, 25, 23, 5, 559.14, 2795.7),
(54, 26, 68, 2, 473.17, 946.34),
(55, 26, 94, 2, 1186.02, 2372.04),
(56, 27, 97, 1, 220.8, 220.8),
(57, 28, 60, 5, 544.31, 2721.55),
(58, 28, 55, 5, 230.46, 1152.3),
(59, 29, 30, 2, 281.05, 562.1),
(60, 29, 59, 3, 380.46, 1141.38),
(61, 30, 36, 2, 233.84, 467.68),
(62, 31, 98, 1, 473.6, 473.6),
(63, 31, 5, 4, 287.76, 1151.04),
(64, 31, 79, 1, 446.56, 446.56),
(65, 32, 27, 1, 308.93, 308.93),
(66, 33, 77, 1, 242.88, 242.88),
(67, 34, 77, 1, 242.88, 242.88),
(68, 34, 32, 1, 729.64, 729.64),
(69, 35, 57, 2, 228.39, 456.78),
(70, 35, 70, 2, 338.13, 676.26),
(71, 36, 18, 5, 242.91, 1214.55),
(72, 37, 30, 5, 281.05, 1405.25),
(73, 37, 41, 5, 413.02, 2065.1),
(74, 38, 99, 3, 458.78, 1376.34),
(75, 38, 31, 3, 374.32, 1122.96),
(76, 38, 19, 5, 385.39, 1926.95),
(77, 39, 53, 3, 445.98, 1337.94),
(78, 40, 8, 5, 375.02, 1875.1),
(79, 40, 76, 2, 205.8, 411.6),
(80, 41, 87, 4, 269.99, 1079.96),
(81, 41, 72, 4, 481.77, 1927.08),
(82, 41, 7, 3, 263.97, 791.91),
(83, 42, 86, 4, 211.62, 846.48),
(84, 42, 68, 3, 473.17, 1419.51),
(85, 42, 90, 4, 534.24, 2136.96),
(86, 43, 20, 3, 272.91, 818.73),
(87, 43, 49, 2, 723.97, 1447.94),
(88, 44, 61, 2, 372.34, 744.68),
(89, 44, 29, 3, 494.69, 1484.07),
(90, 44, 91, 2, 337.55, 675.1),
(91, 45, 8, 5, 375.02, 1875.1),
(92, 45, 53, 4, 445.98, 1783.92),
(93, 46, 68, 2, 473.17, 946.34),
(94, 46, 50, 2, 374.47, 748.94),
(95, 46, 33, 2, 299.38, 598.76),
(96, 47, 83, 1, 468.24, 468.24),
(97, 47, 58, 3, 368.37, 1105.11),
(98, 48, 69, 2, 710.52, 1421.04),
(99, 49, 35, 4, 277.56, 1110.24),
(100, 50, 78, 5, 349.75, 1748.75),
(101, 50, 6, 1, 171.28, 171.28),
(102, 50, 25, 5, 357.85, 1789.25),
(103, 51, 86, 5, 211.62, 1058.1),
(104, 51, 28, 4, 370.89, 1483.56),
(105, 51, 27, 3, 308.93, 926.79),
(106, 52, 2, 2, 618.18, 1236.36),
(107, 52, 25, 1, 357.85, 357.85),
(108, 53, 97, 4, 220.8, 883.2),
(109, 53, 32, 5, 729.64, 3648.2),
(110, 53, 91, 2, 337.55, 675.1),
(111, 54, 31, 5, 374.32, 1871.6),
(112, 54, 42, 3, 482.77, 1448.31),
(113, 55, 60, 5, 544.31, 2721.55),
(114, 55, 84, 3, 623.66, 1870.98),
(115, 56, 34, 3, 855.73, 2567.19),
(116, 56, 66, 4, 203.55, 814.2),
(117, 57, 13, 4, 324.39, 1297.56),
(118, 57, 98, 3, 473.6, 1420.8),
(119, 58, 48, 3, 241.81, 725.43),
(120, 59, 6, 5, 171.28, 856.4),
(121, 59, 29, 2, 494.69, 989.38),
(122, 60, 34, 5, 855.73, 4278.65),
(123, 61, 75, 4, 290.54, 1162.16),
(124, 61, 38, 2, 266.87, 533.74),
(125, 61, 26, 3, 196.56, 589.68),
(126, 62, 49, 5, 723.97, 3619.85),
(127, 63, 64, 5, 864.1, 4320.5),
(128, 64, 88, 3, 267.31, 801.93),
(129, 64, 33, 4, 299.38, 1197.52),
(130, 64, 93, 4, 295.24, 1180.96),
(131, 65, 22, 3, 580.12, 1740.36),
(132, 65, 22, 2, 580.12, 1160.24),
(133, 66, 70, 4, 338.13, 1352.52),
(134, 66, 24, 5, 890.89, 4454.45),
(135, 66, 83, 1, 468.24, 468.24),
(136, 67, 5, 1, 287.76, 287.76),
(137, 67, 86, 1, 211.62, 211.62),
(138, 67, 98, 1, 473.6, 473.6),
(139, 68, 18, 2, 242.91, 485.82),
(140, 68, 9, 2, 472.45, 944.9),
(141, 69, 28, 5, 370.89, 1854.45),
(142, 70, 48, 1, 241.81, 241.81),
(143, 70, 80, 5, 286.79, 1433.95),
(144, 71, 85, 4, 352.99, 1411.96),
(145, 71, 3, 1, 562.16, 562.16),
(146, 72, 71, 4, 433.77, 1735.08),
(147, 72, 2, 1, 618.18, 618.18),
(148, 72, 68, 3, 473.17, 1419.51),
(149, 73, 37, 1, 309.2, 309.2),
(150, 73, 65, 4, 328.85, 1315.4),
(151, 73, 23, 1, 559.14, 559.14),
(152, 74, 68, 2, 473.17, 946.34),
(153, 75, 25, 5, 357.85, 1789.25),
(154, 76, 33, 3, 299.38, 898.14),
(155, 76, 35, 4, 277.56, 1110.24),
(156, 76, 11, 3, 445.99, 1337.97),
(157, 77, 59, 5, 380.46, 1902.3),
(158, 77, 32, 2, 729.64, 1459.28),
(159, 78, 88, 1, 267.31, 267.31),
(160, 78, 84, 1, 623.66, 623.66),
(161, 79, 52, 4, 553.2, 2212.8),
(162, 80, 71, 4, 433.77, 1735.08),
(163, 80, 8, 1, 375.02, 375.02),
(164, 81, 22, 1, 580.12, 580.12),
(165, 81, 64, 4, 864.1, 3456.4),
(166, 81, 83, 3, 468.24, 1404.72),
(167, 82, 13, 5, 324.39, 1621.95),
(168, 82, 6, 2, 171.28, 342.56),
(169, 82, 28, 5, 370.89, 1854.45),
(170, 83, 35, 1, 277.56, 277.56),
(171, 83, 10, 3, 314.67, 944.01),
(172, 84, 73, 1, 307.77, 307.77),
(173, 84, 23, 3, 559.14, 1677.42),
(174, 84, 3, 2, 562.16, 1124.32),
(175, 85, 19, 4, 385.39, 1541.56),
(176, 85, 10, 3, 314.67, 944.01),
(177, 85, 21, 5, 518.21, 2591.05),
(178, 86, 73, 4, 307.77, 1231.08),
(179, 87, 70, 3, 338.13, 1014.39),
(180, 87, 50, 2, 374.47, 748.94),
(181, 87, 89, 1, 583.15, 583.15),
(182, 88, 96, 3, 218.03, 654.09),
(183, 88, 7, 1, 263.97, 263.97),
(184, 88, 56, 2, 166.63, 333.26),
(185, 89, 44, 5, 1413.58, 7067.9),
(186, 90, 77, 4, 242.88, 971.52),
(187, 90, 100, 3, 265.18, 795.54),
(188, 90, 4, 3, 1148.1, 3444.3),
(189, 91, 63, 2, 513.74, 1027.48),
(190, 91, 46, 5, 272.53, 1362.65),
(191, 92, 56, 2, 166.63, 333.26),
(192, 92, 88, 5, 267.31, 1336.55),
(193, 93, 49, 1, 723.97, 723.97),
(194, 93, 99, 5, 458.78, 2293.9),
(195, 93, 38, 2, 266.87, 533.74),
(196, 94, 10, 1, 314.67, 314.67),
(197, 94, 35, 2, 277.56, 555.12),
(198, 94, 49, 2, 723.97, 1447.94),
(199, 95, 50, 3, 374.47, 1123.41),
(200, 95, 47, 1, 290.91, 290.91),
(201, 95, 12, 1, 603.32, 603.32),
(202, 96, 57, 3, 228.39, 685.17),
(203, 96, 98, 3, 473.6, 1420.8),
(204, 97, 17, 1, 261.01, 261.01),
(205, 98, 56, 4, 166.63, 666.52),
(206, 99, 72, 5, 481.77, 2408.85),
(207, 99, 53, 1, 445.98, 445.98),
(208, 99, 4, 1, 1148.1, 1148.1),
(209, 100, 71, 1, 433.77, 433.77),
(210, 100, 77, 5, 242.88, 1214.4);

INSERT INTO payments (payment_id, order_id, payment_date, payment_method, amount, status) VALUES
(1, 1, '2025-01-08', 'SnapScan', 1220.28, 'Completed'),
(2, 2, '2023-06-13', 'Debit Card', 2098.65, 'Pending'),
(3, 3, '2024-04-23', 'Debit Card', 3666.12, 'Completed'),
(4, 4, '2024-05-24', 'Debit Card', 2489.45, 'Completed'),
(5, 5, '2024-02-07', 'Credit Card', 2181.42, 'Completed'),
(6, 6, '2023-09-04', 'SnapScan', 2734.3, 'Completed'),
(7, 7, '2023-02-19', 'EFT', 4449.12, 'Completed'),
(8, 8, '2024-09-03', 'SnapScan', 1812.75, 'Completed'),
(9, 9, '2023-10-20', 'Cash on Delivery', 2180.19, 'Completed'),
(10, 10, '2023-04-21', 'EFT', 7305.68, 'Completed'),
(11, 11, '2023-09-28', 'EFT', 4218.78, 'Completed'),
(12, 12, '2024-02-17', 'PayFast', 2893.69, 'Completed'),
(13, 13, '2023-02-22', 'Debit Card', 1875.96, 'Completed'),
(14, 14, '2024-01-07', 'EFT', 4021.33, 'Completed'),
(15, 15, '2024-01-31', 'Zapper', 5034.32, 'Completed'),
(16, 16, '2024-07-17', 'PayFast', 3292.23, 'Completed'),
(17, 17, '2024-09-30', 'EFT', 5570.31, 'Completed'),
(18, 18, '2023-05-12', 'Cash on Delivery', 3775.34, 'Completed'),
(19, 19, '2025-03-24', 'Debit Card', 743.67, 'Completed'),
(20, 20, '2024-01-10', 'SnapScan', 1491.98, 'Completed'),
(21, 21, '2024-09-08', 'SnapScan', 1951.73, 'Completed'),
(22, 22, '2023-02-11', 'SnapScan', 951.61, 'Completed'),
(23, 23, '2024-12-31', 'Cash on Delivery', 7068.3, 'Completed'),
(24, 24, '2024-06-15', 'Cash on Delivery', 2928.46, 'Completed'),
(25, 25, '2025-07-03', 'Zapper', 2730.5, 'Completed'),
(26, 26, '2025-08-11', 'SnapScan', 3218.83, 'Completed'),
(27, 27, '2024-02-07', 'Credit Card', 240.33, 'Completed'),
(28, 28, '2023-11-03', 'Zapper', 3697.72, 'Completed'),
(29, 29, '2025-04-28', 'EFT', 1707.09, 'Completed'),
(30, 30, '2024-12-26', 'Zapper', 499.78, 'Completed'),
(31, 31, '2025-04-15', 'EFT', 2043.11, 'Completed'),
(32, 32, '2024-11-20', 'PayFast', 357.61, 'Completed'),
(33, 33, '2024-08-20', 'Debit Card', 251.17, 'Completed'),
(34, 34, '2025-01-12', 'PayFast', 970.13, 'Completed'),
(35, 35, '2024-09-03', 'Cash on Delivery', 1135.0, 'Completed'),
(36, 36, '2024-11-02', 'Credit Card', 1198.34, 'Completed'),
(37, 37, '2023-08-22', 'Debit Card', 3424.19, 'Pending'),
(38, 38, '2024-05-06', 'SnapScan', 4352.25, 'Completed'),
(39, 39, '2025-01-08', 'Debit Card', 1349.07, 'Completed'),
(40, 40, '2024-01-25', 'PayFast', 2233.11, 'Completed'),
(41, 41, '2023-09-06', 'SnapScan', 3737.49, 'Completed'),
(42, 42, '2024-12-18', 'PayFast', 4196.67, 'Completed'),
(43, 43, '2024-03-27', 'Cash on Delivery', 2248.75, 'Completed'),
(44, 44, '2024-02-27', 'Credit Card', 2858.56, 'Completed'),
(45, 45, '2024-05-28', 'PayFast', 3575.83, 'Completed'),
(46, 46, '2024-04-27', 'Credit Card', 2238.6, 'Completed'),
(47, 47, '2024-12-23', 'Cash on Delivery', 1572.78, 'Completed'),
(48, 48, '2024-07-28', 'Zapper', 1445.88, 'Pending'),
(49, 49, '2024-05-04', 'EFT', 1067.47, 'Completed'),
(50, 50, '2025-09-06', 'SnapScan', 3567.9, 'Completed'),
(51, 51, '2024-06-29', 'Debit Card', 3375.83, 'Completed'),
(52, 52, '2024-11-23', 'Debit Card', 1585.53, 'Pending'),
(53, 53, '2024-11-28', 'EFT', 5120.01, 'Completed'),
(54, 54, '2023-09-28', 'Credit Card', 3330.84, 'Completed'),
(55, 55, '2025-09-07', 'Zapper', 4485.89, 'Completed'),
(56, 56, '2023-11-02', 'SnapScan', 0.0, 'Failed'),
(57, 57, '2025-10-02', 'SnapScan', 2667.55, 'Completed'),
(58, 58, '2024-12-22', 'Cash on Delivery', 711.84, 'Completed'),
(59, 59, '2024-05-15', 'EFT', 1775.81, 'Completed'),
(60, 60, '2024-07-27', 'Cash on Delivery', 4128.14, 'Completed'),
(61, 61, '2023-05-05', 'EFT', 2258.55, 'Completed'),
(62, 62, '2024-01-24', 'Cash on Delivery', 3628.54, 'Completed'),
(63, 63, '2025-09-04', 'Debit Card', 4313.56, 'Completed'),
(64, 64, '2023-10-25', 'Cash on Delivery', 3184.93, 'Completed'),
(65, 65, '2025-01-01', 'EFT', 2843.96, 'Completed'),
(66, 66, '2024-03-28', 'Credit Card', 6119.82, 'Completed'),
(67, 67, '2024-05-05', 'Zapper', 976.28, 'Completed'),
(68, 68, '2024-07-05', 'Cash on Delivery', 0.0, 'Failed'),
(69, 69, '2024-12-13', 'Debit Card', 1865.6, 'Completed'),
(70, 70, '2024-09-22', 'Zapper', 1706.54, 'Completed'),
(71, 71, '2023-09-06', 'EFT', 1926.91, 'Completed'),
(72, 72, '2024-06-27', 'Cash on Delivery', 3786.37, 'Completed'),
(73, 73, '2023-02-23', 'Debit Card', 2184.73, 'Completed'),
(74, 74, '2025-01-04', 'EFT', 991.72, 'Pending'),
(75, 75, '2025-02-28', 'Debit Card', 1784.97, 'Completed'),
(76, 76, '2024-07-17', 'Cash on Delivery', 3222.83, 'Completed'),
(77, 77, '2025-08-15', 'EFT', 3336.53, 'Completed'),
(78, 78, '2023-07-24', 'SnapScan', 0.0, 'Failed'),
(79, 79, '2023-11-25', 'Credit Card', 2190.19, 'Completed'),
(80, 80, '2025-07-18', 'EFT', 2092.09, 'Completed'),
(81, 81, '2024-08-10', 'Cash on Delivery', 5322.17, 'Completed'),
(82, 82, '2025-01-10', 'SnapScan', 3819.8, 'Completed'),
(83, 83, '2023-06-29', 'Cash on Delivery', 1241.1, 'Completed'),
(84, 84, '2023-06-30', 'Debit Card', 3050.19, 'Completed'),
(85, 85, '2024-02-11', 'Zapper', 4967.73, 'Completed'),
(86, 86, '2025-02-05', 'EFT', 1239.07, 'Completed'),
(87, 87, '2023-01-10', 'PayFast', 2379.8, 'Completed'),
(88, 88, '2023-04-20', 'Cash on Delivery', 1265.37, 'Completed'),
(89, 89, '2025-10-09', 'SnapScan', 6797.73, 'Pending'),
(90, 90, '2024-05-20', 'PayFast', 5044.83, 'Completed'),
(91, 91, '2024-04-24', 'Credit Card', 2359.16, 'Completed'),
(92, 92, '2023-04-26', 'PayFast', 1655.99, 'Completed'),
(93, 93, '2024-04-14', 'PayFast', 3427.2, 'Completed'),
(94, 94, '2023-07-10', 'Credit Card', 2315.12, 'Completed'),
(95, 95, '2025-03-20', 'Debit Card', 1945.48, 'Completed'),
(96, 96, '2025-02-14', 'EFT', 2082.07, 'Completed'),
(97, 97, '2025-05-26', 'Debit Card', 317.91, 'Completed'),
(98, 98, '2025-04-26', 'Cash on Delivery', 662.85, 'Completed'),
(99, 99, '2023-03-30', 'Debit Card', 3842.09, 'Completed'),
(100, 100, '2023-07-09', 'PayFast', 1646.1, 'Completed');


-- 2. STAR SCHEMA (DATA WAREHOUSE LAYER)

CREATE TABLE dim_date (
    date_key     INT PRIMARY KEY,
    full_date    DATE UNIQUE,
    year         INT,
    quarter      INT,
    month_num    INT,
    month_name   VARCHAR(15),
    day_of_month INT,
    day_of_week  VARCHAR(12)
);

INSERT INTO dim_date (date_key, full_date, year, quarter, month_num, month_name, day_of_month, day_of_week)
SELECT
    CAST(DATE_FORMAT(d, '%Y%m%d') AS UNSIGNED),
    d,
    YEAR(d), QUARTER(d), MONTH(d), MONTHNAME(d), DAY(d), DAYNAME(d)
FROM (
    SELECT DATE_ADD('2023-01-01', INTERVAL t.n DAY) AS d
    FROM (SELECT a.N + b.N*10 + c.N*100 AS n
          FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
                UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
               (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
                UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
               (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) c) t
    WHERE DATE_ADD('2023-01-01', INTERVAL t.n DAY) <= '2025-12-31'
) dates;

CREATE TABLE dim_customer AS
SELECT customer_id, first_name, last_name, email, phone, registration_date, segment
FROM customers;

ALTER TABLE dim_customer ADD PRIMARY KEY (customer_id);

CREATE TABLE dim_product AS
SELECT product_id, product_name, category, sku, unit_price, cost_price, supplier
FROM products;

ALTER TABLE dim_product ADD PRIMARY KEY (product_id);

CREATE TABLE dim_location AS
SELECT location_id, city, province, postal_code, country
FROM locations;

ALTER TABLE dim_location ADD PRIMARY KEY (location_id);

CREATE TABLE fact_sales (
    sales_key     INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT,
    line_id       INT,
    date_key      INT,
    customer_key  INT,
    product_key   INT,
    location_key  INT,
    quantity      INT,
    unit_price    DECIMAL(10,2),
    line_total    DECIMAL(10,2),
    cost_total    DECIMAL(10,2),
    discount      DECIMAL(10,2),
    order_status  VARCHAR(20),
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    FOREIGN KEY (date_key)     REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_key)  REFERENCES dim_product(product_id),
    FOREIGN KEY (location_key) REFERENCES dim_location(location_id)
);

INSERT INTO fact_sales
    (order_id, line_id, date_key, customer_key, product_key, location_key,
     quantity, unit_price, line_total, cost_total, discount, order_status,
     payment_method, payment_status)
SELECT
    o.order_id,
    ol.line_id,
    CAST(DATE_FORMAT(o.order_date, '%Y%m%d') AS UNSIGNED) AS date_key,
    o.customer_id,
    ol.product_id,
    o.location_id,
    ol.quantity,
    ol.unit_price,
    ol.line_total,
    ROUND(ol.quantity * p.cost_price, 2),
    ROUND(COALESCE(pay.amount, ol.line_total) - ol.line_total, 2) AS discount,
    o.status,
    pay.payment_method,
    pay.status
FROM orders o
JOIN order_lines ol ON o.order_id = ol.order_id
JOIN products   p  ON ol.product_id = p.product_id
JOIN payments   pay ON o.order_id = pay.order_id
WHERE o.status <> 'Cancelled';

-- 3. ANALYTICAL VIEWS (FEED THE POWER BI DASHBOARD)

-- KPI: Total Revenue
CREATE VIEW v_total_revenue AS
SELECT ROUND(SUM(line_total), 2) AS total_revenue FROM fact_sales;

-- Monthly sales trend
CREATE VIEW v_monthly_sales AS
SELECT d.year, d.month_num, d.month_name,
       ROUND(SUM(f.line_total), 2) AS monthly_revenue,
       COUNT(DISTINCT f.order_id)  AS total_orders
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month_num, d.month_name
ORDER BY d.year, d.month_num;

-- Top products
CREATE VIEW v_top_products AS
SELECT p.product_name, p.category,
       SUM(f.quantity)            AS units_sold,
       ROUND(SUM(f.line_total),2) AS revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC;

-- Customer segments
CREATE VIEW v_customer_segments AS
SELECT c.segment,
       COUNT(DISTINCT f.customer_key) AS customers,
       ROUND(SUM(f.line_total),2)     AS segment_revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_id
GROUP BY c.segment;

-- Revenue by province
CREATE VIEW v_revenue_by_province AS
SELECT l.province,
       ROUND(SUM(f.line_total),2)     AS revenue,
       COUNT(DISTINCT f.order_id)     AS orders
FROM fact_sales f
JOIN dim_location l ON f.location_key = l.location_id
GROUP BY l.province
ORDER BY revenue DESC;

-- Average order value
CREATE VIEW v_avg_order_value AS
SELECT ROUND(SUM(line_total) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM fact_sales;

-- Repeat customers (2+ orders)
CREATE VIEW v_repeat_customers AS
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_key
    FROM fact_sales
    GROUP BY customer_key
    HAVING COUNT(DISTINCT order_id) >= 2
) r;

-- YoY & MoM growth
CREATE VIEW v_growth AS
SELECT
    d.year, d.month_num, d.month_name,
    ROUND(SUM(f.line_total),2) AS revenue,
    ROUND(SUM(f.line_total),2) - LAG(ROUND(SUM(f.line_total),2))
        OVER (ORDER BY d.year, d.month_num) AS mom_change,
    ROUND(100.0 * (SUM(f.line_total) - LAG(SUM(f.line_total)) OVER (ORDER BY d.year, d.month_num))
        / NULLIF(LAG(SUM(f.line_total)) OVER (ORDER BY d.year, d.month_num), 0), 2) AS mom_growth_pct,
    ROUND(100.0 * (SUM(f.line_total) - LAG(SUM(f.line_total), 12) OVER (ORDER BY d.year, d.month_num))
        / NULLIF(LAG(SUM(f.line_total), 12) OVER (ORDER BY d.year, d.month_num), 0), 2) AS yoy_growth_pct
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month_num, d.month_name;

-- 4. EXAMPLE CTE QUERIES

-- Top 5 customers by revenue 
WITH customer_revenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, c.segment,
           SUM(f.line_total) AS total_spent
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_key = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.segment
)
SELECT * FROM customer_revenue ORDER BY total_spent DESC LIMIT 5;

-- Best-selling category per province 
WITH prov_cat AS (
    SELECT l.province, p.category, SUM(f.line_total) AS revenue,
           RANK() OVER (PARTITION BY l.province ORDER BY SUM(f.line_total) DESC) AS rnk
    FROM fact_sales f
    JOIN dim_location l ON f.location_key = l.location_id
    JOIN dim_product  p ON f.product_key  = p.product_id
    GROUP BY l.province, p.category
)
SELECT province, category, ROUND(revenue,2) AS revenue
FROM prov_cat WHERE rnk = 1;

-- Profit analysis 
WITH profit AS (
    SELECT p.category,
           SUM(f.line_total) - SUM(f.cost_total) AS gross_profit
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_id
    GROUP BY p.category
)
SELECT category, ROUND(gross_profit,2) AS gross_profit
FROM profit ORDER BY gross_profit DESC;
