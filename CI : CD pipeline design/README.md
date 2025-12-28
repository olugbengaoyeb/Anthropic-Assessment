1. Pipeline Stages

Checkout & Build

Checkout code from repository

Install dependencies

Run unit tests

Static Analysis & Security Scan

Linting with flake8 or pylint

Dependency vulnerability scan (e.g., safety for Python)

Docker image vulnerability scan (e.g., trivy)

Docker Build & Push

Build Docker image for the application

Tag image with branch, commit SHA, or version

Push image to container registry (e.g., Docker Hub, AWS ECR, GCR)

Deployment to Staging

Apply Kubernetes manifests (kubectl apply)

Run integration tests in staging

Health checks and readiness checks

Approval Gate for Production

Require manual approval before deploying to production

Deployment to Production

Apply production manifests

Rollout strategy (e.g., Kubernetes rolling update)

Optional rollback if health checks fail








Pipeline Flow & Decision Points

PRs / Feature Branches

Developers push changes to feature/* branches

Workflow runs build, test, lint, and security scan

Only after passing these checks can PR be merged into develop

Develop Branch

Trigger build, test, and docker build

Deploy automatically to staging for integration testing

Production Deployment

Requires manual approval gate

Deploys latest image from staging to production

Rollback strategy: Kubernetes rolling update allows rollback if health checks fail

Can trigger kubectl rollout undo deployment/my-app -n production if needed

4. Secret Management

All credentials are stored as GitHub Actions Secrets:

DOCKER_USERNAME / DOCKER_PASSWORD → Docker registry

KUBECONFIG_STAGING / KUBECONFIG_PROD → Kubernetes cluster access

Secrets are never hardcoded in workflow files

Access is limited to the jobs that need them