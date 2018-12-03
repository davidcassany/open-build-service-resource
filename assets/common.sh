parse_source_config() {
  OSC_API=$(jq -r '.source.api // "https://api.opensuse.org"' $payload)
  OSC_USERNAME=$(jq -r '.source.username // "guest"' $payload)
  OSC_PASSWORD=$(jq -r '.source.password // ""' $payload)
  OSC_PROJECT=$(jq -r '.source.project // ""' $payload)
  OSC_PACKAGE=$(jq -r '.source.package // ""' $payload)
  VERSION=$(jq -r '.version.ref // ""' $payload)
}

create_oscrc() {
  mkdir -p ${HOME}/.config/osc
  tee ${HOME}/.config/osc/oscrc > /dev/null << OSCCONFIG
[general]
apiurl = ${OSC_API}

[${OSC_API}]
OSCCONFIG

  if [ ! -z "$OSC_USERNAME" ]; then
      cat >> ${HOME}/.config/osc/oscrc << OSCCONFIG
user = ${OSC_USERNAME}
pass = ${OSC_PASSWORD}
OSCCONFIG
  fi
}
