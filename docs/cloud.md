# Cloud Implementation Overview

The deployment journey of `thenightclub` is currently mid-flight, and we are not piloting the old two-propeller I'm used to. This is a well-needed pivot from a lot of my professional dev work, where most everything was hosted in our own datacenters on physical servers. No cloud, no containerization, just down in the weeds.

## Current Setup

- **Containers:** Two Docker images:
    - The Django web app
    - A microservice for serving static content (currently coupled, soon to be a submodule)
- **Container Build & Run:** Managed by a custom `dev.ps1` script — local-first but easily extendable.
- **Cloud Platform:** Google Cloud Platform
- **Deployment Target:** Google Cloud Run (fully managed, container-based)

## Future Plans

- **CI/CD Integration:** GitHub Actions to automate build/test/deploy
- **Secrets Management:** Shift from `.env` to GCP Secret Manager or environment-based injection
- **Submodule Split:** Detach the static service into its own repo/submodule
- **Infrastructure-as-Code:** Define everything in Terraform or use Cloud Build YAML
- **Custom Domain + CDN:** Map a clean domain and slap on some Cloud CDN goodness

## Notes

We’re still early in the ascending part of this flight, but the winds are usually in my favor. The current infra is intentionally minimal — reliable enough to deploy and flexible enough to continuously evolve.
