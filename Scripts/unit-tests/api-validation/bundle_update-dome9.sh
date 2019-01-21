. .authentication
url="https://api.dome9.com/v2"
bundle_id=xxxxxx
set -x
#
curl -vvvv -X PUT ${url}/CompliancePolicy \
  --basic -u "${api_key}:${api_secret}" \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d @bundle_request.json
