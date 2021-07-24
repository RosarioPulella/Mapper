/*
The app gets driven off of the Campus.
So this will probably be the start of some important queries like,

When we load a list of campuses or the default campus,
we look here first and find the Map for it and display it.
*/


/* Campus
Can have a map to show for it.
Can have a region on its map.
Note: This allows a map with multiple campuses on it.
*/
CREATE TABLE Campus (
    id INT,
    name TEXT NOT NULL,
    on_map INT,
    region INT,
    PRIMARY KEY (id),
    FOREIGN KEY (on_map) REFERENCES Map (id),
    FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
);

/* Building
Can be on a campus.
Can have a region on a map.
*/
CREATE TABLE Building (
    id INT,
    name TEXT NOT NULL,
    on_campus INT,
    on_map INT,
    region INT,
    PRIMARY KEY (id),
    FOREIGN KEY (on_campus) REFERENCES Campus (id),
    FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
);

/* Floor
Is in a building.
Can have a map to show for it.
*/
CREATE TABLE Floor (
    in_building INT,
    number INT,
    map INT,
    PRIMARY KEY (in_building, number),
    FOREIGN KEY (in_building) REFERENCES Building (id),
    FOREIGN KEY (map) REFERENCES Map (id)
)

/* Room
Is in a building.
Can be on a floor.
Can have a region on a map.
*/
CREATE TABLE Room (
    in_building INT,
	number INT,
    on_floor INT,
    on_map INT,
    region INT,
    PRIMARY KEY (in_building, number),
    FOREIGN KEY (in_building) REFERENCES Building (id),
    FOREIGN KEY (in_building, on_floor) REFERENCES Floor (in_building, floor),
    FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
);