. .authentication
set -x
response=$(curl -s --request POST \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  --url https://api.redlock.io/login \
  --data "{\"username\":\"${username}\",\"password\":\"${password}\",\"customerName\":\"SomeCustomer\"}")
echo ${response}
token=$(echo $response|jq -r '.token')
#
#
curl --request GET \
  -H "x-redlock-auth: ${token}" \
  --url https://api.redlock.io/policy \
  -o response.json
