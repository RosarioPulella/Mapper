# Migrations
Currently everything is very hands off, maybe too much. I am starting to think that the autoMigrate option is too automatic.

This is currently still in pre-release so for right now it more to prepare for migrations in the future.

We are going to need to store the current schema version in the db so that we don't have to preform any evaluated migrations.

With the schema version stored in the database we can have explicit migrations from one CheckedDatabase to another.

The general idea is to take some principles from
[this article](https://enterprisecraftsmanship.com/posts/database-versioning-best-practices/) and others like it and make the most use of beam to employ keep to these principles in a maintainable way.

## Principles

### Explicit Migrations
Currently the `autoMigrate` solution is the much the opposite of explicit migrations. 

State generated migrations - We have db `a` with a set schema and we want to it to have a schema `b`, tool figure it out. 

Explicit Migrations - The db has a current schema version in it, with that version we can know the state of the schema and all the migrations previously ran, we create a migration to get to the next schema.

Having explicit migrations it might not be as "easy tm" but it is simpler and more consistent and therefor more reliable and flexible. With explicit migrations we can always know what what the schema looks like and how the data was migrated at each step. Making writing future migrations easier to write and easier to know exactly what migrations step ran on a given instance.

### Growth
We should be able to keep all the types of the previous schemas. We can keep a current folder of the schema and every time the database is migrated the types that no longer exist can move into a folder numbered by the schema version. Not actually sure how useful this could be if we already have the migration.