package models;

/**
 * This interface is used to define the way of generating the different types
 * of entities found in the game.
 */
interface EntityFactory {

    /**
     * Creates a kitten
     */
    public function createKitten() : Kitten;

    /**
     * Creates a thing
     */
    public function createThing() : Thing;

    /**
     * Randomly create a thing - it may return a thing or not.
     */
    public function createRandomThing() : Thing;

}