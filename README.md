# The Nightclub

[Why The Nightclub?](docs/philosophy.md##why-the-nightclub)

Welcome! To my little digital venue for any projects, writing, and general experiments with code/design I have to share.
<br>

[💥💥get in on the fun now!!!💥💥](https://nightclub-site-255993342952.us-central1.run.app/)

## Tech Stack

<br>**Backend:** Django (with custom `blog` and `portfolio` apps)
<br>**Frontend:** Django Templates + vanilla HTML/CSS
<br>**Database:** PostgreSQL (but flexible enough to go SQLite for local spins)
<br>**DevOps:** Docker, Google Cloud Run (in progress), GitHub Actions for CI/CD
<br>**[Formatting:](docs/formatting.md)** `black` for python, `shfmt` for shell, `dockfmt` for Dockerfiles, `prettier` for most else.
<br>**Secrets Management:** `.env` based for now

## Local Setup

```ps1
# Clone and spin up
>git clone https://github.com/nekklebu/thenightclub.git
>git submodule update --init
>cd thenightclub
>.\venv\Scripts\Activate
(venv)>pip install -r requirements.txt
(venv)>.\docker\dev.ps1 # builds and runs both containers
```

## Future Plans

Clearly, this project is at the inception of her own divine journey. I've tried to outline some details and future plans for [the cloud](docs/cloud.md), [testing](docs/testing.md), and [any other future dev goals/inspirations.](docs/future.md)
