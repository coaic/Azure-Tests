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
curl -vvvv --request POST \
  -H "x-redlock-auth: ${token}" \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  --url ${uri}/user  \
  -d @user_create_request.json
