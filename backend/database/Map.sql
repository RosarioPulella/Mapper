/* Map
NOTE: Width and Height might not be needed?
*/
CREATE TABLE Map (
    id INT,
    image DATA NOT NULL,
    width REAL NOT NULL,
    height REAL NOT NULL,
    PRIMARY KEY (id),
)

/* Region
Can be on a map.
NOTE: Think on how we want to store the vector graphical representation of a Region,
like do we have the location separately? or do we pull out other info from the path?
*/
CREATE TABLE Region (
    on_map INT,
    id INT,
    x REAL NOT NULL,
    y REAL NOT NULL,
    svg_path TEXT NOT NULL,
    PRIMARY KEY (on_map, id),
    FOREIGN KEY (on_map) REFERENCES Map (id),
);