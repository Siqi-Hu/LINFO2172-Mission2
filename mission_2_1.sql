PRAGMA foreign_keys = ON;

-- CREATE : Artist
DROP TABLE IF EXISTS Artist;
CREATE TABLE Artist(
    artistId INT NOT NULL,
    artistName VARCHAR(30) NOT NULL,
    birthDate DATE,
    birthplace VARCHAR(30),
    PRIMARY KEY (artistId),
--     UNIQUE (artistName),
    -- check the format of the birthDate to be united as '%Y-%m-%d'
    CHECK (birthDate IS strftime('%Y-%m-%d',birthDate))
);

-- CREATE : CREATION
DROP TABLE IF EXISTS Creation;
CREATE TABLE Creation(
    artistId INT NOT NULL,
    pieceId INT NOT NULL,
    PRIMARY KEY (artistId, pieceId),  -- artist and pieceart N:M
    FOREIGN KEY (artistId) REFERENCES Artist(artistId) ON DELETE CASCADE,
    FOREIGN KEY (pieceId) REFERENCES ArtPiece(pieceId) ON DELETE CASCADE
);

-- CREATE : ArtPiece
DROP TABLE IF EXISTS ArtPiece;
CREATE TABLE ArtPiece(
    pieceId INT NOT NULL,
    type VARCHAR(1) NOT NULL, -- either Painting('P') or Sculpture('S')
    width FLOAT NOT NULL,
    length FLOAT NOT NULL,
    height FLOAT DEFAULT NULL,
    creationDate DATE,
    PRIMARY KEY (pieceId),
    -- When it is a painting, we cannot write anything in height
    -- When it is a sculpture, we should have height
    -- It will also check type is either 'S' or 'P'
    CHECK ((type = 'S' AND height IS NOT NULL) OR (type = 'P' AND height IS NULL))
);

-- CREATE : Moves
DROP TABLE IF EXISTS Moves;
CREATE TABLE Moves(
    pieceId INT NOT NULL,
    dateId INT NOT NULL,
    locId INT NOT NULL,
    PRIMARY KEY (pieceId, dateId, locId),
    FOREIGN KEY (pieceId) REFERENCES ArtPiece(pieceId),
    FOREIGN KEY (dateId) REFERENCES Date(dateId),
    FOREIGN KEY (locId) REFERENCES Location(locId),
    UNIQUE (pieceId, dateId)    -- one piece can only move at most once a day
);

-- CREATE : Date
DROP TABLE IF EXISTS Date;
CREATE TABLE Date(
    dateId INT NOT NULL,
    day VARCHAR(2) NOT NULL,
    month VARCHAR(2) NOT NULL,
    year VARCHAR(4) NOT NULL,
    PRIMARY KEY (dateId),
    CHECK (
        CASE
            WHEN month = 1 THEN day BETWEEN 01 AND 31
            WHEN month = 2 THEN day BETWEEN 01 AND 29
            WHEN month = 3 THEN day BETWEEN 01 AND 31
            WHEN month = 4 THEN day BETWEEN 01 AND 30
            WHEN month = 5 THEN day BETWEEN 01 AND 31
            WHEN month = 6 THEN day BETWEEN 01 AND 30
            WHEN month = 7 THEN day BETWEEN 01 AND 31
            WHEN month = 8 THEN day BETWEEN 01 AND 31
            WHEN month = 9 THEN day BETWEEN 01 AND 30
            WHEN month = 10 THEN day BETWEEN 01 AND 31
            WHEN month = 11 THEN day BETWEEN 01 AND 30
            WHEN month = 12 THEN day BETWEEN 01 AND 31
        END
        )
);

-- CREATE : Location
DROP TABLE IF EXISTS Location;
CREATE TABLE Location(
    locId INT NOT NULL,
    type VARCHAR(2) NOT NULL,   -- either Museum(M) or StorageSite(S)
    mName VARCHAR(30) DEFAULT NULL,          -- museum name: for museum; should be unique as a key
    openingHours INT DEFAULT NULL,           -- for museum: the number of hours the museum opens per day
    size INT DEFAULT NULL,                   -- for StorageSite
    city VARCHAR(30) NOT NULL,
    streetName VARCHAR(30) NOT NULL,
    streetNo INT NOT NULL,
    PRIMARY KEY (locId),
    UNIQUE (mName),
    CHECK ((type = 'M' AND size IS NULL AND openingHours IS NOT NULL AND mName IS NOT NULL) OR (type = 'S' AND size IS NOT NULL AND openingHours IS NULL AND mName IS NULL))
);

-- CREATE : Collection
DROP TABLE IF EXISTS Collection;
CREATE TABLE Collection(
    cId INT NOT NULL,           -- collection Id
    cName VARCHAR(30) NOT NULL, -- collection name
    mName INT,                  -- not mandatory
    PRIMARY KEY (cId),
    FOREIGN KEY (mName) REFERENCES Location(mName)
);

-- CREATE : Contains
DROP TABLE IF EXISTS Contains;
CREATE TABLE Contains(
    pieceId INT NOT NULL,
    cId INT NOT NULL,
    PRIMARY KEY (pieceId),      -- piece and collection N:1, if we know pieceId, we know cId
    FOREIGN KEY (pieceId) REFERENCES ArtPiece(pieceId),
    FOREIGN KEY (cId) REFERENCES Collection(cId)
);

-- CREATE : Exhibition
DROP TABLE IF EXISTS Exhibition;
CREATE TABLE Exhibition(
    exhibitId INT NOT NULL,
    exhibitName VARCHAR(30) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    locId INT,
    PRIMARY KEY (exhibitId),
    FOREIGN KEY (locId) REFERENCES Location(locId),
    CHECK (
        (startDate IS strftime('%Y-%m-%d',startDate))
        AND
        (endDate IS strftime('%Y-%m-%d',endDate))
        )
);

-- CREATE : PartOf
DROP TABLE IF EXISTS PartOf;
CREATE TABLE PartOf(
    exhibitId INT NOT NULL,
    pieceId INT NOT NULL,
    PRIMARY KEY (exhibitId, pieceId),  -- exhibition and piece N:M
    FOREIGN KEY (exhibitId) REFERENCES Exhibition(exhibitId),
    FOREIGN KEY (pieceId) REFERENCES ArtPiece(pieceId)
);