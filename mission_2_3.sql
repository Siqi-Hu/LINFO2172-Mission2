DROP TABLE IF EXISTS VehicleClass;
CREATE TABLE VehicleClass (
    vcid INT NOT NULL,
    vcname VARCHAR(30) NOT NULL,
    length INT,
    width INT,
    height INT,
    PRIMARY KEY (vcid),
    UNIQUE (vcname)
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    cid INT NOT NULL,
    cfirst_name VARCHAR(30) NOT NULL,
    clast_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (cid),
    UNIQUE (cfirst_name, clast_name)
);

DROP TABLE IF EXISTS Station;
CREATE TABLE Station (
    name VARCHAR(30) NOT NULL,
    street VARCHAR(30) NOT NULL,
    postcode INT NOT NULL,
    PRIMARY KEY (name),
    UNIQUE (street, postcode),
    FOREIGN KEY (postcode) REFERENCES ZipCity(postcode) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Vehicle;
CREATE TABLE Vehicle (
    num INT NOT NULL,
    vcid INT NOT NULL,   -- to enforce the weak entity relationship to VehicleClass
    last_check_date Date,
    type VARCHAR(2) NOT NULL, -- C or B; NOT NULL forces to be either Car or Bicycle
    plate_num VARCHAR(10),   -- for cars only
    sname VARCHAR(30) NOT NULL,   -- to enforce mandatory 1:N relationship to Station
    PRIMARY KEY (num, vcid),
    FOREIGN KEY (vcid) REFERENCES VehicleClass(vcid) ON DELETE CASCADE,
    FOREIGN KEY (sname) REFERENCES Station(name) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Car;
DROP TABLE IF EXISTS Bicycle;


DROP TABLE IF EXISTS Reservation;
CREATE TABLE Reservation (
    startDateTime Date NOT NULL,
    endDateTime Date,
    cid INT NOT NULL,   -- to enforce mandatory relationship to Customer
    vnum INT NOT NULL,
    vcid INT NOT NULL,

    distance INT,
    cost INT,

    PRIMARY KEY(startDateTime, cid, vcid, vnum),
    FOREIGN KEY (cid) REFERENCES Customer(cid) ON DELETE CASCADE,
    FOREIGN KEY (vnum, vcid) REFERENCES Vehicle(num, vcid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Preference;
CREATE TABLE Preference (
    vcid INT NOT NULL,
    cid INT NOT NULL,
    PRIMARY KEY (cid),   -- because N:1 => if we know cid, we know vcid
    FOREIGN KEY (vcid) REFERENCES VehicleClass(vcid) ON DELETE CASCADE,
    FOREIGN KEY (cid) REFERENCES Customer(cid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ZipCity;
CREATE TABLE Zipcity (
    postcode INT NOT NULL,
    city VARCHAR(30) NOT NULL,
    PRIMARY KEY (postcode)   -- if you know the postcode you know the city but not necessarily vice versa
);