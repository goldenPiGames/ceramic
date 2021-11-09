package elements;

import ceramic.Shortcuts.*;
import ceramic.System;
import ceramic.TouchInfo;
import ceramic.View;
import ceramic.Visual;

class ImSystem extends System {

    @lazy public static var shared = new ImSystem();

    public function new() {

        super();

        earlyUpdateOrder = 100;
        lateUpdateOrder = 6000;

    }

    @:allow(elements.Im)
    function createView():Void {

        var view = new View();
        view.transparent = true;
        view.bindToNativeScreenSize();
        view.depth = 1000;
        view.onLayout(this, _layoutWindows);
        Context.context.view = view;
        screen.onFocusedVisualChange(this, handleFocusedVisualChange);

    }

    function handleFocusedVisualChange(focusedVisual:Visual, prevFocusedVisual:Visual) {

        var focusedWindow:Window = null;
        if (focusedVisual != null) {
            if (focusedVisual is Window) {
                focusedWindow = cast focusedVisual;
            }
            else {
                var parentWindow = focusedVisual.firstParentWithClass(Window);
                if (parentWindow != null) {
                    focusedWindow = parentWindow;
                }
                else {
                    // Handle color picker popover case
                    var parentPickerView:ColorPickerView = null;
                    if (focusedVisual is ColorPickerView) {
                        parentPickerView = cast focusedVisual;
                    }
                    else {
                        parentPickerView = focusedVisual.firstParentWithClass(ColorPickerView);
                    }
                    if (parentPickerView != null && parentPickerView.colorFieldView != null) {
                        parentWindow = parentPickerView.colorFieldView.firstParentWithClass(Window);
                        if (parentWindow != null) {
                            focusedWindow = parentWindow;
                        }
                    }
                }
            }
        }
        Context.context.focusedWindow = focusedWindow;

    }

    override function earlyUpdate(delta:Float):Void {

        Im.beginFrame();

    }

    override function lateUpdate(delta:Float):Void {

        Im.endFrame();

    }

/// Internal

    function _layoutWindows():Void {

        var subviews = Context.context.view.subviews;
        if (subviews != null) {
            for (i in 0...subviews.length) {
                var view = subviews[i];
                if (view is Window) {
                    view.autoComputeSizeIfNeeded(true);
                }
            }
        }

    }

}