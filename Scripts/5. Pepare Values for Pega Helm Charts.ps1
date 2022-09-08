#1. Add the Pega repository to your Helm installation.
helm repo add pega https://pegasystems.github.io/pega-helm-charts
helm search repo pega

#2. Get values-minimal.yaml
helm inspect values pega/pega > values-minimal.yaml

#3. edit the file values-minimal.yaml