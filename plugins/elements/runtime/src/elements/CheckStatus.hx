package elements;

import ceramic.Flags;

abstract CheckStatus(Int) from Int to Int {

    inline public function new(value:Int) {
        this = value;
    }

    @:to inline function toBool():Bool {
        return changed;
    }

    public var checked(get,never):Bool;
    inline function get_checked():Bool {
        return Flags.fromInt(this).bool(0);
    }

    public var changed(get,never):Bool;
    inline function get_changed():Bool {
        return Flags.fromInt(this).bool(1);
    }

}