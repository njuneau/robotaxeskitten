package models;

/**
 * This is a board tile. It can contain an entity.
 */
class Tile {

    private var entity : Entity;

    /**
     * Creates a new, empty tile
     */
    public function new() {
        this.entity = null;
    }

    /**
     * Sets the tile's entity
     */
    public function setEntity(entity : Entity) : Void {
        this.entity = entity;
    }

    /**
     * Returns the tile's entity
     */
    public function getEntity() : Entity {
        return this.entity;
    }

    /**
     * Removes the entity from the tile
     */
    public function removeEntity() : Void {
        this.entity = null;
    }

    /**
     * Indicates if this tile is empty (no entity) or not
     */
    public function isEmpty() : Bool {
        return this.entity == null;
    }

}