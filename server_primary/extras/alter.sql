ALTER TABLE users ADD COLUMN is_active TINYINT(4) NOT NULL DEFAULT 1;
ALTER TABLE requests MODIFY COLUMN keyword text NOT NULL;

INSERT INTO preference (_key,_value) VALUES ('is_direct_contact',1);
INSERT INTO preference (_key,_value) VALUES ('admin_email','theapache64@gmail.com');