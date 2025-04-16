# The Nightclub

This is my own site – a subdued online space for my projects, writing, and miscellaneous experiments with design and code. It's constructed in Django, Docker'd for container-y goodness, and (coming soon) hosted on Google Cloud.

## Technology Stack

- **Backend:** Django with own `blog` and `portfolio` apps  
- **Front End:** Django Templates with plain HTML/CSS  
- **Database:** PostgreSQL (but can switch to SQLite for local test spins)  
- **DevOps:** Docker, Google Cloud Run (in progress), GitHub Actions for CI/CD  
- **Secrets Management:** .env based currently  

## Why I am Here

Honestly, I just missed the exhilaration of creating something from scratch. Part sandbox, part calling card. I wanted to push my abilities again — from backend craftsmanship to infrastructure challenges. This endeavor is about renewal, reignition, and writing with heart.

## Local Setup

\`\`\`bash
# Clone and spin up
git clone https://github.com
cd thenightclub
./dev.sh # builds & runs both containers

# Load environment variables
cp .env.example .env
# (insert secrets such as database URL, Django key, etc.)
\`\`\`

## Deploying to Cloud

This site is being migrated to Google Cloud Run. See `docs/cloud.md` for more information.

## Dev Notes

This repository is lovingly formatted with:
- `black`, `isort` for Python
- `shfmt` for scripting in the shell
- `dockfmt` for Dockerfiles

Refer to `docs/formatting.md` for more

## License

This MIT License

---

Less grind, more vibes.
