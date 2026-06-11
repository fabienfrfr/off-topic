// ==UserScript==
// @name         Anti-Visibility-Override
// @namespace    http://tampermonkey.net/
// @version      1.2.0
// @description  Forces page visibility. Excludes Teams v2.
// @author       Collaboration
// @match        *://*/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Exclusion for Teams V2
    if (window.location.href.includes('teams.microsoft.com/v2/')) {
        return;
    }

    // TODO: Add support for document.onvisibilitychange property overrides
    // TODO: Add detection/bypass for setInterval-based visibility checks
    // TODO: Implement passive proxy for performance.now() to mitigate timing analysis

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
            return;
        }
        return originalAddEventListener.apply(this, arguments);
    };

    // 3. Fake focus state
    document.hasFocus = () => true;

    // 4. Normalize animation frames
    const originalRAF = window.requestAnimationFrame;
    window.requestAnimationFrame = (callback) => {
        return originalRAF(() => {
            callback(performance.now());
        });
    };
})();