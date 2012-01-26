package models;

/**
 * The robot is the player. He's an entity.
 */
class Robot extends Entity {

    public static var REPRESENTATION = "#";

    /**
     * Creates the mighty robot
     */
    public function new() {
        super("#");
    }

}