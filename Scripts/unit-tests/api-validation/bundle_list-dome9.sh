. .authentication
url="https://api.dome9.com/v2"
bundle_id=40469
set -x
#
curl -s -X GET ${url}/CompliancePolicy/${bundle_id} \
  --basic -u "${api_key}:${api_secret}" \
  -H 'Accept: application/json' \
  -o bundle_response.json
