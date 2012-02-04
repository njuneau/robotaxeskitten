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