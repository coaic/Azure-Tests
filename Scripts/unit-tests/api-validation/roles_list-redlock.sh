. .authentication
uri=https://api.redlock.io
set -x
response=$(curl -s --request POST \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  --url ${uri}/login \
  --data "{\"username\":\"${username}\",\"password\":\"${password}\",\"customerName\":\"SomeCustomer\"}")
echo ${response}
token=$(echo $response|jq -r '.token')
#
#
curl --request GET \
  -H "x-redlock-auth: ${token}" \
  --url ${uri}/user/role  \
  -o roles_response.json
