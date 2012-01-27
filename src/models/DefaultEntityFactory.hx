package models;

/**
 * This factory is used to build entities of different kind
 */
class DefaultEntityFactory implements EntityFactory {
    private static var REPRESENTATIONS : Array<String> = [
        "A", "B", "C", "D", "E"
    ];

    private static var DESCRIPTIONS : Array<String> = [
        "Not a kitten",
        "A pack of gum"
    ];

    /**
     * Creates the default factory
     */
    public function new() {}

    /**
     * Creates a new kitten
     */
    public function createKitten() : Kitten {
        var representation : String = REPRESENTATIONS[Std.random(REPRESENTATIONS.length - 1)];
        var color : Array<Int> = this.toRGB(Std.random(360),1 , 1);
        return new Kitten(representation, color);
    }

    /**
     * Creates a new thing
     */
    public function createThing() : Thing {
        var representation : String = REPRESENTATIONS[Std.random(REPRESENTATIONS.length - 1)];
        var color : Array<Int> = this.toRGB(Std.random(360),1 , 1);
        var description : String = DESCRIPTIONS[Std.random(DESCRIPTIONS.length - 1)];
        return new Thing(representation, color, description);
    }

    /**
     * Returns the RGB components from HSV components
     * Hue is between 0 and 360.
     * Saturation and value between 0 an 1.
     */
    private function toRGB(h : Float, s : Float, v : Float) : Array<Int> {
        return [128, 128, 128];
    }

}