---

# 🧱 Multi-Tier Application on Kubernetes

## Architecture Overview

* **Frontend**: NGINX (public-facing)
* **Backend**: Node.js API (internal)
* **Cache**: Redis (internal)
* **Traffic Flow**
  `Internet → Frontend (NGINX) → Backend (Node.js) → Redis`

---

## 📁 Directory Structure

```
k8s-manifests/
├── frontend.yaml
├── backend.yaml
├── redis.yaml
├── configmap.yaml
├── secrets.yaml
├── hpa.yaml
├── network-policy.yaml
└── README.md
```

---

## 🚀 Deployment Instructions (Minikube)

```bash
minikube start
kubectl apply -f .
minikube service frontend
```

---

* Pipeline stages
* GitHub Actions workflow (`.github/workflows/ci-cd.yaml`)
* Documentation explaining the flow, rollback strategy, and secret management

---

## **1. Pipeline Stages**

1. **Checkout & Build**

   * Checkout code from repository
   * Install dependencies
   * Run unit tests

2. **Static Analysis & Security Scan**

   * Linting with `flake8` or `pylint`
   * Dependency vulnerability scan (e.g., `safety` for Python)
   * Docker image vulnerability scan (e.g., `trivy`)

3. **Docker Build & Push**

   * Build Docker image for the application
   * Tag image with branch, commit SHA, or version
   * Push image to container registry (e.g., Docker Hub, AWS ECR, GCR)

4. **Deployment to Staging**

   * Apply Kubernetes manifests (`kubectl apply`)
   * Run integration tests in staging
   * Health checks and readiness checks

5. **Approval Gate for Production**

   * Require manual approval before deploying to production

6. **Deployment to Production**

   * Apply production manifests
   * Rollout strategy (e.g., Kubernetes rolling update)
   * Optional rollback if health checks fail


---

## **3. Pipeline Flow & Decision Points**

1. **PRs / Feature Branches**

   * Developers push changes to `feature/*` branches
   * Workflow runs **build, test, lint, and security scan**
   * Only after passing these checks can PR be merged into `develop`

2. **Develop Branch**

   * Trigger build, test, and docker build
   * Deploy automatically to **staging** for integration testing

3. **Production Deployment**

   * Requires **manual approval gate**
   * Deploys latest image from staging to production
   * **Rollback strategy:** Kubernetes **rolling update** allows rollback if health checks fail
   * Can trigger `kubectl rollout undo deployment/my-app -n production` if needed

---

## **4. Secret Management**

* All credentials are stored as **GitHub Actions Secrets**:

  * `DOCKER_USERNAME` / `DOCKER_PASSWORD` → Docker registry
  * `KUBECONFIG_STAGING` / `KUBECONFIG_PROD` → Kubernetes cluster access
* Secrets are never hardcoded in workflow files
* Access is limited to the jobs that need them

---


## 🔁 Scaling & Self-Healing Explained

### Scaling

* **HPA** scales backend pods automatically based on CPU usage
* Frontend can be manually scaled or HPA added later
* Redis runs single-replica by design (stateful)

### Self-Healing

* **Liveness probes** restart unhealthy containers
* **Readiness probes** remove unhealthy pods from traffic
* **ReplicaSets** ensure desired pod count is always maintained

---

## 📊 Observability Readiness

* Metrics available via `metrics-server` (HPA-ready)
* Logs accessible via `kubectl logs`
* Easily extensible to:

  * Prometheus + Grafana
  * EFK / Loki
  * OpenTelemetry tracing

---
