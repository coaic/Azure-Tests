. .authentication
url="https://api.dome9.com/v2"
bundle_id=xxxxxxx
set -x
#
curl -s -X GET ${url}/CompliancePolicy/${bundle_id} \
  --basic -u "${api_key}:${api_secret}" \
  -H 'Accept: application/json' \
  -o bundle_response.json
