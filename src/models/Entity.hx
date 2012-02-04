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
 * This is a generic entity - an object that can be contained in a board's tile.
 * Basically, there are non-cats, cats and a robot.
 */
class Entity {

    private var representation : String;
    private var color : Array<Int>;

    /**
     * Creates a new entity with a given representation and an RGB color
     */
    public function new(representation : String, color : Array<Int>) {
        this.representation = representation;
        this.color = color;
    }

    /**
     * Returns the representation of the entity. An ASCII character, in general.
     */
    public function getRepresentation() : String {
        return this.representation;
    }

    /**
     * Returns the entity's color
     */
    public function getColor() : Array<Int> {
        return this.color;
    }

}