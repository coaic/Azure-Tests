. .authentication
url="https://api.dome9.com/v2"
set -x
#
curl -vvvv -X GET ${url}/CompliancePolicy \
  --basic -u "${api_key}:${api_secret}" \
  -H 'Accept: application/json' \
  -o policy_response.json
