CREATE TABLE SALES_REPS (
rep_id NUMBER PRIMARY KEY,
name VARCHAR2(255) NOT NULL,
address VARCHAR2(255) NOT NULL,
phone_number VARCHAR2(50) NOT NULL,
email_address VARCHAR2(255) NOT NULL,
commission_rate NUMBER NOT NULL,
total_commission NUMBER NOT NULL,
CONSTRAINT rep_email_un UNIQUE (email_address)
);

CREATE TABLE CUSTOMERS (
customer_id NUMBER PRIMARY KEY,
full_name VARCHAR2(255) NOT NULL,
address VARCHAR2(255) NOT NULL,
phone_number VARCHAR2(50) NOT NULL,
email_address VARCHAR2(255) NOT NULL,
current_balance NUMBER NOT NULL,
customer_type VARCHAR2(50) NOT NULL,
assigned_rep_id NUMBER,
CONSTRAINT cust_email_un UNIQUE (email_address),
CONSTRAINT fk_cust_rep FOREIGN KEY (assigned_rep_id) REFERENCES SALES_REPS(rep_id)
);

CREATE TABLE TEAMS (
team_id NUMBER PRIMARY KEY,
team_name VARCHAR2(255) NOT NULL,
player_count NUMBER NOT NULL,
discount_percentage NUMBER,
registered_customer_id NUMBER NOT NULL,
CONSTRAINT team_name_un UNIQUE (team_name),
CONSTRAINT fk_team_cust FOREIGN KEY (registered_customer_id) REFERENCES CUSTOMERS(customer_id)
);

CREATE TABLE ORDERS (
order_id NUMBER PRIMARY KEY,
order_date DATE NOT NULL,
total_order_cost NUMBER,
customer_id NUMBER NOT NULL,
CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);

CREATE TABLE ITEMS (
item_id NUMBER PRIMARY KEY,
item_description VARCHAR2(255) NOT NULL,
list_price NUMBER NOT NULL,
category VARCHAR2(50) NOT NULL,
color VARCHAR2(50),
size VARCHAR2(50),
CONSTRAINT item_desc_un UNIQUE (item_description)
);

CREATE TABLE ORDER_ITEMS (
order_item_id NUMBER PRIMARY KEY,
order_id NUMBER NOT NULL,
item_id NUMBER NOT NULL,
quantity NUMBER NOT NULL,
unit_price NUMBER NOT NULL,
color VARCHAR2(50),
size VARCHAR2(50),
CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
CONSTRAINT fk_oi_item FOREIGN KEY (item_id) REFERENCES ITEMS(item_id)
);

CREATE TABLE INVENTORY (
inventory_id NUMBER PRIMARY KEY,
wholesale_unit_cost NUMBER NOT NULL,
units_on_hand NUMBER NOT NULL,
item_id NUMBER NOT NULL,
CONSTRAINT inv_item_un UNIQUE (item_id),
CONSTRAINT fk_inv_item FOREIGN KEY (item_id) REFERENCES ITEMS(item_id)
);