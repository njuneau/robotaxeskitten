// robotaxeskitten - A reimplementation of the original robotfindskitten by Leonard Richardson
// Copyright (C) 2012  Nicolas Juneau
// Full copyright notice can be found in the project root's "COPYRIGHT" file
//
// This file is part of robotaxeskitten.
//
// robotaxeskitten is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// robotaxeskitten is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with robotaxeskitten.  If not, see <http://www.gnu.org/licenses/>.

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