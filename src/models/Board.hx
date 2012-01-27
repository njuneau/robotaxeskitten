package models;

/**
 * This is a virtual representation of the playing board - it's only a MxN grid
 * which can holds entities (a kitten, for example) and the player.
 * Board coordinates ranges from 0 to given dimensions - 1.
 */
class Board {

    private var tiles : Array<Array<Tile>>;
    private var robotPosition : Position;
    private var kittenPosition : Position;

    /**
     * Creates a new game board. Specify the board width's and height
     * (there will be width*height tiles). The robot an kitten will both be
     * placed on a board at random positions.
     */
    public function new(width : Int, height : Int) {

        // Determine the robot and the kitten's position
        this.robotPosition = new Position(Std.random(width - 1), Std.random(height - 1));
        this.kittenPosition = new Position(Std.random(width - 1), Std.random(height - 1));
        while(this.kittenPosition.equals(this.robotPosition)) {
            this.kittenPosition = new Position(Std.random(width - 1), Std.random(height - 1));
        }

        // Create the tiles
        this.tiles = new Array<Array<Tile>>();

        var i : Int = 0;
        while(i < height) {
            var j : Int = 0;
            var row : Array<Tile> = new Array<Tile>();
            while(j < width) {
                var tile : Tile = new Tile();

                // Place the robot
                if(j == this.robotPosition.getX() && i == this.robotPosition.getY()) {
                    tile.setEntity(new Robot());
                }

                // Place the kitten
                if(j == this.kittenPosition.getX() && i == this.kittenPosition.getY()) {
                    tile.setEntity(new Kitten("+"));
                }

                // Place an entity randomly (TBD)
                if(!tile.isEmpty()) {
                }

                // Add the tile
                row.push(tile);
                j++;
            }

            // Add the row
            this.tiles.push(row);
            i++;
        }
    }

    /**
     * Returns the board's tiles
     */
    public function getTiles() : Array<Array<Tile>> {
        return this.tiles;
    }

    /**
     * Return a tile at a specific position. Returns null if element doesn't
     * exist.
     */
    public function getTileAt(position : Position) : Tile {
        var x : Int = position.getX();
        var y : Int = position.getY();
        var returnedTile : Tile = null;

        // Make sure we refer to valid indexes by checking the bounds
        if(x >= 0 && x < this.tiles[0].length && y >= 0 && y < this.tiles.length) {
            returnedTile = this.tiles[position.getY()][position.getX()];
        }

        return returnedTile;
    }

    /**
     * Moves the robot in a certain direction by a certain X and Y increment.
     * If the robot hits an obstacle (like an edge or entity), the robot's
     * position will not be changed.
     */
    public function moveRobot(xIncrement : Int, yIncrement : Int) : Void {
        var newPosition = new Position(this.robotPosition.getX() + xIncrement, this.robotPosition.getY() + yIncrement);
        if(newPosition.getX() >= 0 &&
                newPosition.getX() < this.tiles[0].length &&
                newPosition.getY() >= 0 &&
                newPosition.getY() < this.tiles.length &&
                this.getTileAt(newPosition).isEmpty()) {

            // Get robot out of the tile
            var oldTile : Tile = this.getTileAt(this.robotPosition);
            var robot : Entity = oldTile.getEntity();
            oldTile.removeEntity();

            // Put robot in the new tile
            this.robotPosition = newPosition;
            this.getTileAt(this.robotPosition).setEntity(robot);
        }
    }

    /**
     * Returns a copy of the position of the robot.
     */
    public function getRobotPosition() : Position {
        return new Position(this.robotPosition.getX(), this.robotPosition.getY());
    }

}