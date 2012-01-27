package models;

/**
 * The Kitten must be found by the Robot. It's pretty much all there is to it.
 */
class Kitten extends Entity {

    /**
     * Creates the kitten with a given representation and RGB color
     */
    public function new(representation : String, color : Array<Int>) {
        super(representation, color);
    }
}