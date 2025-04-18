const container = document.getElementById('jukebox-container');
const img = document.getElementById('jukebox-img');
const audio = document.getElementById('jukebox-audio');

const turnOn = container.dataset.start;
const loop = container.dataset.loop;
const turnOff = container.dataset.stop;
const frame1 = container.dataset.frame1;

[turnOn, loop, turnOff, frame1].forEach(src => {
    const preload = new Image();
    preload.src = src;
});

const gifDuration = 5200;

let hovering = false;
let playingIntro = false;
let playingOutro = false;
let audioUnlocked = false;
let audioFading = false;
let doorSealed = false;
let doorOpened = false;

window.addEventListener('DOMContentLoaded', async () => {
    const res = await fetch('http://localhost:4040/random-track');
    const data = await res.json();

    if (data.preview_url) {
        audio.src = data.preview_url;
    }
});

document.body.addEventListener(
    'click',
    () => {
        audioUnlocked = true;
    },
    { once: true }
);

const waitFor = (cond, cb, checkInterval = 50) => {
    const interval = setInterval(() => {
        if (!audioFading) {
            clearInterval(interval);
            cb();
        }
    }, checkInterval);
};

function fadeAudioIn(duration) {
    if (!audioUnlocked) return;

    audioFading = true;

    audio.volume = 0;
    audio.play();

    const step = 0.05;
    let t = 0;

    const fadeIn = setInterval(() => {
        if (t < 1) {
            t = Math.min(1, t + step);
            // Power4 function scaling to emulate the door opening
            const volume = t === 1 ? 1 : Math.pow(t, 3);
            audio.volume = volume;
        } else {
            clearInterval(fadeIn);
            audioFading = false;
        }
    }, duration * step);
}

function fadeAudioOut(duration) {
    const step = 0.05;
    let t = 1;
    const interval = duration * step;

    const fadeOut = setInterval(() => {
        if (t > 0) {
            t = Math.max(0, t - step);
            // Power4 function scaling to emulate the door closing
            const volume = t === 0 ? 0 : Math.pow(t, 3);
            audio.volume = volume;
        } else {
            clearInterval(fadeOut);
            audioFading = false;
            audio.pause();
        }
    }, interval);
}

container.addEventListener('mouseenter', () => {
    if (playingIntro || hovering || doorSealed) return;

    waitFor(
        () => audioFading,
        () => {
            audioFading = true;
            fadeAudioIn(gifDuration - 1000);
            img.src = turnOn;

            hovering = true;
            playingIntro = true;

            audio.currentTime = 0;
            setTimeout(() => {
                if (hovering) {
                    img.src = loop;
                }
                playingIntro = false;
                doorOpened = true;
            }, gifDuration);
        }
    );
});

container.addEventListener('mouseleave', () => {
    if (playingOutro || !hovering || doorSealed) return;

    waitFor(
        () => audioFading,
        () => {
            hovering = false;
            playingOutro = true;
            audioFading = true;
            fadeAudioOut(gifDuration);
            img.src = turnOff;
            setTimeout(() => {
                img.src = frame1;
                playingOutro = false;
                doorSealed = true;
                doorOpened = false;
            }, gifDuration - 500);
        }
    );
});
