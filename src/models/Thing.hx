package models;

/**
 * A "thing" is a non-kitten entity. It also contains a description, so the
 * robot knows what he's touching
 */
class Thing extends Entity {

    private var description : String;

    /**
     * Creates a new "thing" with its own representation and description
     */
    public function new(representation : String, color : Array<Int>, description : String) {
        super(representation, color);
        this.description = description;
    }

    /**
     * Returns the thing's description
     */
    public function getDescription() {
        return this.description;
    }

}