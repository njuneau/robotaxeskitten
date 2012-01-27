package models;

/**
 * The robot is the player. He's an entity.
 */
class Robot extends Entity {

    public static var REPRESENTATION : String = "#";
    public static var COLOR : Array<Int> = [200, 200, 200];

    /**
     * Creates the mighty robot
     */
    public function new() {
        super("#", COLOR);
    }

}