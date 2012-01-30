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
     * Creates a NKI
     */
    public function createNKI() : NKI;

    /**
     * Randomly create a NKI - it may return a NKI or not.
     */
    public function createRandomNKI() : NKI;

}