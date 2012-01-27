package models;

/**
 * This is a generic entity - an object that can be contained in a board's tile.
 * Basically, there are non-cats, cats and a robot.
 */
class Entity {

    private var representation : String;
    private var color : Array<Int>;

    /**
     * Creates a new entity with a given representation and an RGB color
     */
    public function new(representation : String, color : Array<Int>) {
        this.representation = representation;
        this.color = color;
    }

    /**
     * Returns the representation of the entity. An ASCII character, in general.
     */
    public function getRepresentation() : String {
        return this.representation;
    }

    /**
     * Returns the entity's color
     */
    public function getColor() : Array<Int> {
        return this.color;
    }

}