package models;

/**
 * Represents an X,Y position
 */
class Position {

    private var x : Int;
    private var y : Int;

    /**
     * Creates a new position, defined by its x and y coordinates
     */
    public function new(x : Int, y : Int) {
        this.x = x;
        this.y = y;
    }

    /**
     * Sets the position's X
     */
    public function setX(x : Int) : Void {
        this.x = x;
    }

    /**
     * Sets the position's Y
     */
    public function setY(y : Int) : Void {
        this.y = y;
    }

    /**
     * Returns the position's X
     */
    public function getX() : Int {
        return this.x;
    }

    /**
     * Returns the position's Y
     */
    public function getY() : Int {
        return this.y;
    }

    /**
     * Indicates if two positions are equal (if they are at the same spot)
     */
    public function equals(position : Position) : Bool {
        return this.x == position.getX() && this.y == position.getY();
    }
}