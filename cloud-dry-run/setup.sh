#!/bin/bash
 
set -e
 
BASE_FLUX_DIR="flux-gitops/clusters/production"
BASE_CHARTS_DIR="charts"
 
declare -A services=(
  ["microservice-a"]="backend/microservice-a"
  ["microservice-b"]="backend/microservice-b"
  ["frontend"]="frontend"
)
 
echo "📁 Creating FluxCD YAMLs and Helm Charts..."
 
for svc in "${!services[@]}"; do
  FLUX_DIR="$BASE_FLUX_DIR/$svc"
  CHART_DIR="$BASE_CHARTS_DIR/$svc"
  mkdir -p "$FLUX_DIR" "$CHART_DIR/templates"
 
  echo "🧩 Creating Flux YAMLs for $svc..."
 
  # HelmRelease.yaml
  cat > "$FLUX_DIR/helmrelease.yaml" <<EOF
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: $svc
  namespace: production
spec:
  interval: 5m
  releaseName: $svc
  chart:
    spec:
      chart: ./charts/$svc
      sourceRef:
        kind: GitRepository
        name: flux-system
        namespace: flux-system
  values:
    image:
      repository: australia-southeast1-docker.pkg.dev/das-terraform-dry-run/das-docker-repo/$svc
      tag: latest
    service:
      port: 3000
EOF
 
  # ImageRepository.yaml
  cat > "$FLUX_DIR/imagerepository.yaml" <<EOF
apiVersion: image.toolkit.fluxcd.io/v1beta2
kind: ImageRepository
metadata:
  name: $svc
  namespace: flux-system
spec:
  image: australia-southeast1-docker.pkg.dev/das-terraform-dry-run/das-docker-repo/$svc/$svc
  interval: 5m
EOF
 
  # ImagePolicy.yaml
  cat > "$FLUX_DIR/imagepolicy.yaml" <<EOF
apiVersion: image.toolkit.fluxcd.io/v1beta2
kind: ImagePolicy
metadata:
  name: $svc
  namespace: flux-system
spec:
  imageRepositoryRef:
    name: $svc
  policy:
    semver:
      range: ">=0.0.0"
EOF
 
  echo "📦 Creating Helm chart for $svc..."
 
  # Chart.yaml
  cat > "$CHART_DIR/Chart.yaml" <<EOF
apiVersion: v2
name: $svc
description: A Helm chart for deploying $svc
type: application
version: 0.1.0
appVersion: "1.0"
EOF
 
  # values.yaml
  cat > "$CHART_DIR/values.yaml" <<EOF
replicaCount: 1
 
image:
  repository: ""
  tag: ""
  pullPolicy: IfNotPresent
 
service:
  type: ClusterIP
  port: 3000
 
resources: {}
 
EOF
 
  # templates/deployment.yaml
  cat > "$CHART_DIR/templates/deployment.yaml" <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
  labels:
    app: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.service.port }}
EOF
 
  # templates/service.yaml
  cat > "$CHART_DIR/templates/service.yaml" <<EOF
apiVersion: v1
kind: Service
metadata:
  name: {{ .Chart.Name }}
  labels:
    app: {{ .Chart.Name }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.port }}
  selector:
    app: {{ .Chart.Name }}
EOF
 
done
 
echo "✅ All Flux and Helm YAMLs created successfully."
