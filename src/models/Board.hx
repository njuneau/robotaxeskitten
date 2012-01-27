package models;

/**
 * This is a virtual representation of the playing board - it's only a MxN grid
 * which can holds entities (a kitten, for example) and the player.
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
            while(j < height) {
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
     * Return a tile at a specific position
     */
    public function getTileAt(x : Int, y : Int) : Tile {
        return this.tiles[x][y];
    }

}