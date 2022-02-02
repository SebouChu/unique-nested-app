/*global $, Sortable */
// Add [data-sortable] to container. Its direct children can be sortable.
// You can pass a value to data-sortable. It can be "xhr" or "inputs". Defaults to "xhr".
// With "xhr", you need to set [data-id="<id>"] on the children and [data-sort-url="<post url to call>"] on the container.
// With "inputs", you need to set [data-sortable-input] on the input field of each child.
window.sortableManager = {
    init: function () {
        'use strict';
        this.containers = document.querySelectorAll('[data-sortable]');
        this.instances = Array.from(this.containers).map(function (container) {
            return this.createInstance(container);
        }.bind(this));
    },

    createInstance: function (container) {
        'use strict';
        var sortableType = container.dataset.sortable;
        if (sortableType === 'input') {
            $(container).on('cocoon:after-add cocoon:after-remove', this.updateViaInputs);
        }

        return new Sortable(container, {
            handle: '.handle',
            group: 'nested',
            animation: 150,
            fallbackOnBody: true,
            swapThreshold: 0.65,
            onEnd: sortableType === 'inputs' ? this.updateViaInputs : this.updateViaXhr
        });
    },

    updateViaXhr: function (event) {
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

    updateViaInputs: function (event) {
        'use strict';
        Array.from(event.to.children)
            .filter(function (child) {
                var destroyInput = child.querySelector('input[name$="[_destroy]"]');
                return destroyInput === null || destroyInput.value !== '1';
            })
            .forEach(function (child, index) {
                var targetInput = child.querySelector('[data-sortable-input]');
                if (targetInput !== null) {
                    targetInput.value = index + 1;
                }
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
    'use strict';
    window.sortableManager.init();
});
