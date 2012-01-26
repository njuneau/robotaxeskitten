package models;

/**
 * This is a generic entity - an object that can be contained in a board's tile.
 * Basically, there are non-cats, cats and a robot.
 */
class Entity {

    private var representation : String;

    /**
     * Creates a new entity with a given representation
     */
    public function new(representation : String) {
        this.representation = representation;
    }

    /**
     * Returns the representation of the entity. An ASCII character, in general.
     */
    public function getRepresentation() : String {
        return this.representation;
    }

}