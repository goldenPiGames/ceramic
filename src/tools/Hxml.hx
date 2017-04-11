package tools;

using StringTools;

class Hxml {

    /** Parse raw HXML content and return an array of strings. */
    public static function parse(rawHxml:String):Array<String> {

        var args = [];
        var i = 0;
        var len = rawHxml.length;
        var currentArg = '';
        var prevArg = null;
        var numberOfParens = 0;
        var c, m0;

        while (i < len) {
            c = rawHxml.charAt(i);

            if (c == '(') {
                if (prevArg == '--macro') {
                    numberOfParens++;
                }
                currentArg += c;
                i++;
            }
            else if (numberOfParens > 0 && c == ')') {
                numberOfParens--;
                currentArg += c;
                i++;
            }
            else if (c == '"' || c == '\'') {
                if (RE_BEGINS_WITH_STRING.match(rawHxml.substr(i))) {
                    m0 = RE_BEGINS_WITH_STRING.matched(0);
                    currentArg += m0;
                    i += m0.length;
                }
                else {
                    // This should not happen, but if it happens, just add the character
                    currentArg += c;
                    i++;
                }
            }
            else if (c.trim() == '') {
                if (numberOfParens == 0) {
                    if (currentArg.length > 0) {
                        prevArg = currentArg;
                        currentArg = '';
                        args.push(prevArg);
                    }
                }
                else {
                    currentArg += c;
                }
                i++;
            }
            else {
                currentArg += c;
                i++;
            }

        }

        if (currentArg.length > 0) {
            args.push(currentArg);
        }

        return args;
    }


    /** Match any single/double quoted string */
    static var RE_BEGINS_WITH_STRING:EReg = ~/^(?:"(?:[^"\\]*(?:\\.[^"\\]*)*)"|'(?:[^'\\]*(?:\\.[^'\\]*)*)')/;

} //Hxml
