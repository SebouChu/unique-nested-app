window.sortableManager = {
    init: function () {
        'use strict';
        var i;
        this.containers = document.querySelectorAll('[data-sortable]');
        this.instances = Array.from(this.containers).map(function (container) {
            return this.createInstance(container);
        }.bind(this));
    },

    createInstance: function (container) {
        'use strict';
        return new Sortable(container, {
            handle: '.handle',
            group: 'nested',
            animation: 150,
            fallbackOnBody: true,
            swapThreshold: 0.65,
            onEnd: this.onSortEnd
        });
    },

    onSortEnd: function (event) {
        'use strict';
        var url = event.to.dataset.sortUrl;

        if (!url) {
            return;
        }

        $.post(url, {
            ids: Array.from(event.to.children).map(function (child) {
                return child.dataset.id;
            })
        });
    },

    invoke: function () {
        'use strict';
        return {
            init: this.init.bind(this)
        };
    }
}.invoke();

window.addEventListener('DOMContentLoaded', function () {
    window.sortableManager.init();
});
