// ==UserScript==
// @name         Anti-Visibility-Override
// @namespace    http://tampermonkey.net/
// @version      1.1.0
// @description  Forces the page to always appear visible to the browser and scripts.
// @author       Collaboration
// @match        *://*/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // 1. Lock document visibility properties to 'visible'
    const defineReadOnly = (obj, prop, value) => {
        Object.defineProperty(obj, prop, {
            value: value,
            writable: false,
            configurable: false
        });
    };

    defineReadOnly(document, 'hidden', false);
    defineReadOnly(document, 'visibilityState', 'visible');
    defineReadOnly(document, 'webkitHidden', false);
    defineReadOnly(document, 'webkitVisibilityState', 'visible');

    // 2. Prevent site from listening to visibility/focus changes
    const originalAddEventListener = EventTarget.prototype.addEventListener;
    EventTarget.prototype.addEventListener = function(type, listener, options) {
        const blockList = ['visibilitychange', 'blur', 'focus', 'webkitvisibilitychange'];
        if (blockList.includes(type)) {
            return; // Silently drop tracking listeners
        }
        return originalAddEventListener.apply(this, arguments);
    };

    // 3. Fake focus state
    document.hasFocus = () => true;

    // 4. Normalize animation frames to run at 60fps regardless of tab state
    const originalRAF = window.requestAnimationFrame;
    window.requestAnimationFrame = (callback) => {
        return originalRAF(() => {
            callback(performance.now());
        });
    };
})();