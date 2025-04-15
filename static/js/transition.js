document.addEventListener('DCOMContentLoaded', function () {
    const links = document.querySelectorAll('a');

    links.forEach(link => {
        link.addEventListener('click', function (e) {
            const target = link.getAttribute('href');

            if (
                href &&
                !href.startsWith('http') &&
                !href.startsWith('#') &&
                link.target !== '_blank'
            ) {
                event.preventDefault();

                const content = document.getElementById('page-transition');
                if (content) {
                    content.classList.add('fade-out');
                }

                setTimeout(() => {
                    window.location.href = href;
                }, 300);
            }
        });
    });
});
