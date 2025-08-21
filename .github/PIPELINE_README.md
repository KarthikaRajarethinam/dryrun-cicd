#  Build & Deploy Microservices v2

This workflow automates the CI/CD pipeline for a microservices architecture. It builds and deploys only the microservices affected by code changes pushed to the `main` branch.

---

🔐 Setting Up GitHub Secrets

To enable authentication with Google Cloud, you must configure repository secrets in GitHub.

 Steps:

1. Go to your repository on GitHub
2. Navigate to:  
   **Settings → Secrets and variables → Actions → Repository secrets**
3. Click **"New repository secret"**
4. Add the following secrets:

| Secret Name     | Description                            |
|-----------------|----------------------------------------|
| `WIF_PROVIDER`  | Workload Identity Federation Provider |
| `GCP_SA_EMAIL`  | GCP Service Account Email             |

##  Workflow Summary

- **Trigger:** Push to `main` with changes in specific paths
- **Build System:** Docker Compose v2
- **Registry:** Google Cloud Artifact Registry
- **Deployment Scope:** Only changed microservices
- **Workflow Status:** Automatic build

---

## ⚙ Trigger Conditions

This GitHub Actions workflow runs when code is pushed to the `main` branch, and any of the following paths have changed:

- `backend/**`
- `frontend/**`
- `.github/workflows/**`
- `cloud-dry-run/docker-compose.yml`

---

##  Workflow Steps

### 1. **Checkout Code**
Uses `actions/checkout@v3` to clone the repository.

### 2. **Set Up Docker Compose v2**
Downloads and installs Docker Compose CLI plugin.

### 3. **Authenticate to Google Cloud**
Uses Workload Identity Federation to securely authenticate without long-lived credentials.

### 4. **Configure Docker to Push to Artifact Registry**
Enables Docker to push images to GCP's Artifact Registry.

### 5. **Ensure Artifact Registry Exists**
Checks for and creates the Docker Artifact Registry repo if it does not exist.

### 6. **Detect Changed Microservices**
Analyzes commit differences to detect which services have changed:
- `microservice-a`
- `microservice-b`
- `frontend`

### 7. **Build and Push Changed Services**
Only affected services are:
- Built via Docker Compose
- Pushed to Artifact Registry

### 8. **List Recently Pushed Images**
Displays the 5 latest images for each service in the registry.

### 9. **Comment on Pull Requests**
If triggered by a pull request, it comments with a build report on the PR using `peter-evans/create-or-update-comment`.

---

##  Services and Registry Structure

| Service         | Docker Compose Target | Artifact Registry Path |
|----------------|------------------------|-------------------------|
| `microservice-a` | `microservice-a`     | `australia-southeast1-docker.pkg.dev/das-terraform-dry-run/das-docker-repo/microservice-a` |
| `microservice-b` | `microservice-b`     | `australia-southeast1-docker.pkg.dev/das-terraform-dry-run/das-docker-repo/microservice-b` |
| `frontend`       | `frontend`           | `australia-southeast1-docker.pkg.dev/das-terraform-dry-run/das-docker-repo/frontend`       |

---

## ✅ Checking Workflow Status

You can view and debug workflow runs in GitHub:

1. Go to the **Actions** tab in your GitHub repo
2. Look for the workflow titled:  
   **"Build & Deploy Microservices v2"**
3. Click the most recent run (triggered by your push)
4. Inside the run, you can:
   - View each step of the workflow
   - See logs, errors, and outputs
   - Confirm whether the workflow completed successfully

---

##  Notes

- Region: `australia-southeast1`
- Artifact Registry repo: `das-docker-repo`
- GCP Project ID: `das-terraform-dry-run`
- Workflow is environment-aware (uses `production` environment block)
- Full logs available via GitHub Actions run history


