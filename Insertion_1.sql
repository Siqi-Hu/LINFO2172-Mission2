-- INSERT : ARTIST
INSERT INTO Artist(artistId, artistName, birthDate, birthplace) VALUES (0010, 'Kel', '1996/11/30', 'London'); -- not allowed
INSERT INTO Artist(artistId, artistName, birthDate, birthplace) VALUES (0020, 'Moo', '1996-12-42', 'London'); -- not allowed

INSERT INTO Artist(artistId, artistName, birthDate, birthplace) VALUES (0001, 'King', '2000-01-01', 'Brussels');
INSERT INTO Artist(artistId, artistName, birthDate, birthplace) VALUES (0002, 'Maple', '1998-12-20', 'Luxembourg');
INSERT INTO Artist(artistId, artistName, birthDate, birthplace) VALUES (0011, 'Kevin', '1988-10-06', 'Tokyo');


-- INSERT : ArtPiece
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (01, 'P', 10.0, 18.0, NULL, '2005');
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (02, 'P', 13.0, 21.0, 24.0, '2001'); -- not allowed
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (03, 'S', 12.0, 24.0, 12.0, '2003');
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (04, 'S', 6.0, 8.0, NULL, '2019');   -- not allowed
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (05, 's', 7.0, 7.0, NULL, '2017');   -- not allowed
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (06, 'P', 9.0, 9.0, NULL, '2016');
INSERT INTO ArtPiece(pieceId, type, width, length, height, creationDate) VALUES (07, 'S', 100.0, 20.0, 40.0, '2020');



-- INSERT : CREATION
INSERT INTO Creation(artistId, pieceId) VALUES (100, 3); -- not allowed
INSERT INTO Creation(artistId, pieceId) VALUES (1, 1);
INSERT INTO Creation(artistId, pieceId) VALUES (2, 3);  -- co-author with artist 11 on piece 3
INSERT INTO Creation(artistId, pieceId) VALUES (11, 3); -- co-author with artist2 on piece 3
INSERT INTO Creation(artistId, pieceId) VALUES (11, 6);
INSERT INTO Creation(artistId, pieceId) VALUES (2, 7);


-- To test ON DELETE CASCADE
-- -- DELETE : CREATION
-- DELETE FROM Creation WHERE artistId = 11;

-- INSERT : Moves
INSERT INTO Moves(pieceId, dateId, locId) VALUES (1, 2, 1);
INSERT INTO Moves(pieceId, dateId, locId) VALUES (1, 2, 3); -- not allowed, on one day a piece of art can only move to one new location
INSERT INTO Moves(pieceId, dateId, locId) VALUES (1, 4, 3);
INSERT INTO Moves(pieceId, dateId, locId) VALUES (1, 5, 1); -- Allowed, same piece of art can be moved to the same location multiple times
INSERT INTO Moves(pieceId, dateId, locId) VALUES (1, 5, 1); -- not allowed, but on different days

-- To test ON DELETE CASCADE
-- -- DELETE : Moves
-- DELETE FROM Moves WHERE locId = 3;
-- DELETE FROM Moves WHERE dateId = 2;
-- DELETE FROM Moves WHERE pieceId = 1;

-- INSERT : Date
INSERT INTO Date(dateId, day, month, year) VALUES (1, 31, 01, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (2, 20, 10, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (3, 21, 10, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (4, 22, 10, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (5, 23, 10, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (6, 25, 10, 2022);
INSERT INTO Date(dateId, day, month, year) VALUES (7, 42, 10, 2022); -- not allowed

-- INSERT : Location
INSERT INTO Location(locId, type, mName, openingHours, size, city, streetName, streetNo) VALUES (1, 'M', 'Musée du Louvre', 8, NULL, 'Paris', 'Rue de Rivoli', 1);
INSERT INTO Location(locId, type, mName, openingHours, size, city, streetName, streetNo) VALUES (2, 'M', "Musée d'Orsay", 8, 30, 'Paris', "Rue de la Légion d'Honneur", 1); -- not allowed
INSERT INTO Location(locId, type, mName, openingHours, size, city, streetName, streetNo) VALUES (3, 'S', NULL, NULL, 30, 'Louvain-la-Neuve', "Place de l'Université", 1);
INSERT INTO Location(locId, type, mName, openingHours, size, city, streetName, streetNo) VALUES (4, 'S', 'Renaissance Gallery', 7, 100, 'Brussels', "Grand Place", 28);  -- not allowed

-- INSERT : Collection
INSERT INTO Collection(cId, cName, mName) VALUES (1, 'Collection 1', 'Musée du Louvre');
INSERT INTO Collection(cId, cName, mName) VALUES (2, 'Collection 2', NULL);
INSERT INTO Collection(cId, cName, mName) VALUES (3, 'Collection 3', 'Museum of London'); -- not allowed, there is no such museum in Location.


-- INSERT : Contains
INSERT INTO Contains(pieceId, cId) VALUES (1, 1);
INSERT INTO Contains(pieceId, cId) VALUES (3, 1); -- Multiple pieces can be collected in the same collection
INSERT INTO Contains(pieceId, cId) VALUES (3, 2); -- NOT ALLOWED, One piece of art can only belong to one collection
INSERT INTO Contains(pieceId, cId) VALUES (6, 2);
INSERT INTO Contains(pieceId, cId) VALUES (7, 2);

-- INSERT : Exhibition
INSERT INTO Exhibition(exhibitId, exhibitName, startDate, endDate, locId) VALUES (1, 'Exhibition 1', '2022-10-11', '2022-11-11', NULL);
INSERT INTO Exhibition(exhibitId, exhibitName, startDate, endDate, locId) VALUES (2, 'Exhibition 2', '2022-10-11', '2022-11-11', 1);
INSERT INTO Exhibition(exhibitId, exhibitName, startDate, endDate, locId) VALUES (3, 'Exhibition 3', '2021/10/11', '2022-11-11', 1); -- not allowed

-- INSERT : PartOf
INSERT INTO PartOf(exhibitId, pieceId) VALUES (1, 1);
INSERT INTO PartOf(exhibitId, pieceId) VALUES (1, 3);
INSERT INTO PartOf(exhibitId, pieceId) VALUES (2, 6);
INSERT INTO PartOf(exhibitId, pieceId) VALUES (2, 7);

