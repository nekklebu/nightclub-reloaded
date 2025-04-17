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
let doorLocked = false;

document.body.addEventListener(
    'click',
    () => {
        audioUnlocked = true;
    },
    { once: true }
);

function fadeAudioIn(duration) {
    if (!audioUnlocked) return;
    audio.volume = 0;
    audio.play();
    const step = 0.05;
    const interval = duration * step;
    const fadeIn = setInterval(() => {
        if (audio.volume < 1) {
            audio.volume = Math.min(1, audio.volume + step);
        } else {
            clearInterval(fadeIn);
        }
    }, interval);
}

function fadeAudioOut(duration) {
    const step = 0.05;
    const interval = duration * step;
    const fadeOut = setInterval(() => {
        if (audio.volume > 0) {
            audio.volume = Math.max(0, audio.volume - step);
        } else {
            clearInterval(fadeOut);
            audio.pause();
        }
    }, interval);
}

container.addEventListener('mouseenter', () => {
    if (playingIntro || hovering || doorLocked) return;

    hovering = true;
    playingIntro = true;

    img.src = turnOn;
    audio.currentTime = 0;
    fadeAudioIn(gifDuration - 1000);

    setTimeout(() => {
        if (hovering) {
            img.src = loop;
        }
        playingIntro = false;
    }, gifDuration);
});

container.addEventListener('mouseleave', () => {
    if (playingOutro || !hovering || doorLocked) return;

    hovering = false;
    playingOutro = true;

    img.src = turnOff;
    fadeAudioOut(gifDuration);

    setTimeout(() => {
        img.src = frame1;
        playingOutro = false;
        doorLocked = true;
    }, gifDuration - 500);
});
