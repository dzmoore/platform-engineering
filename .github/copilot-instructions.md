# Copilot Instructions for platform-engineering

## Project Overview
This repository manages platform engineering resources and automation, primarily for GCP infrastructure using Crossplane, KCL, and shell scripts. The architecture is modular, with build definitions, KCL compositions, and test automation.

## Key Components
- **build/**: Contains Crossplane resource definitions and compositions (YAML), organized by provider and function.
- **crossplane/**: Mirrors build/provider resources for Crossplane, used for reference or alternative workflows.
- **kcl/**: KCL scripts for resource composition and automation. Example: `gke-autopilot.k` generates GCP network and subnetwork resources with custom annotation logic.
- **tests/**: Shell scripts and YAML for automated validation of provider configs and resource chains.

## Developer Workflows
- **Environment Setup**: Run `devbox shell` to enter the dev environment.
- **Control Plane**: Use `just start-control-plane` to launch local Kubernetes (kind) and supporting services.
- **Cleanup**: Use `just clean` to stop services and remove build artifacts.
- **GCP Integration**: Follow the steps in the README to create a GCP project, service account, and credentials. Store secrets in GitHub Codespaces as `GCP_CREDS` and `GCP_PROJECT_ID`.

## Patterns & Conventions
- **Resource Naming**: KCL scripts use deterministic hashes and truncation for resource names (see `managedResourceName` in `gke-autopilot.k`).
- **Annotations**: KCL functions merge custom annotations with required keys (see `annotations` lambda pattern).
- **Provider Configs**: Default provider config names are used unless overridden in spec objects.
- **Test Structure**: Tests are organized by resource type and use assert YAMLs for validation.

## Integration Points
- **Crossplane**: Compositions and definitions in `build/` and `crossplane/` are designed for Crossplane controllers.
- **KCL**: KCL scripts automate resource generation and connection details, supporting Crossplane workflows.
- **GCP**: External GCP resources are managed via service accounts and API keys, with setup documented in the README.

## Examples
- See `kcl/gke-autopilot.k` for advanced resource composition and annotation merging.
- See `tests/` for shell-based validation and resource assertion patterns.

## Tips for AI Agents
- Always check for default values and merging logic in KCL scripts.
- Use `just` commands for starting/stopping local infrastructure.
- Reference the README for GCP setup and secret management.
- Follow naming and annotation conventions for new resources.

---
If any section is unclear or missing, please request clarification or provide feedback for improvement.
