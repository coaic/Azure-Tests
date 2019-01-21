. .authentication
set -e
uri="https://api.redlock.io"
let sleep_time=60*5
call_count=6
response=$(curl -s --request POST \
  -H 'Accept: application/json' -H 'Content-Type: application/json' \
  --url ${uri}/login \
  --data "{\"username\":\"${username}\",\"password\":\"${password}\",\"customerName\":\"SomeCustomer\"}")
token=$(echo $response|jq -r '.token')
printf '%s\n\n' ${token}
#
#
refresh_session() {
  echo "Refreshing JWT..."
  local tempfile="$(mktemp)"
  local http_code=$(curl -s --request GET \
    -H "x-redlock-auth: ${token}" \
    -w '%{http_code}' \
    -o ${tempfile} \
    --url ${uri}/auth_token/extend)
  printf 'HTTP Code: %s\n' ${http_code}
  if [ "${http_code}" != "200" ]
  then
    echo "Unable to refresh JWT token..."
    exit 1
  fi
  token=$(cat ${tempfile} | jq -r '.token')
  printf 'Refreshed Token: %s' ${token}
  rm ${tempfile}
  printf '\n%.0s' {1..3}
}
#
#
api_poll_user_profile() {
  date
  local tempfile="$(mktemp)"
  local http_code=$(curl -s --request GET \
    -H "x-redlock-auth: ${token}" \
    -w '%{http_code}' \
    -o ${tempfile} \
    --url ${uri}/user/me)
  printf 'HTTP Code: %s\n' ${http_code}
  if [ "${http_code}" != "200" ]
  then
     refresh_session
  else
    cat ${tempfile}
    rm ${tempfile}
    refresh_session
    printf '\n%.0s' {1..3}
  fi
}
#
#
for i in $(seq 1 ${call_count})
do
  api_poll_user_profile
  sleep ${sleep_time}
done
api_poll_user_profile -vvvv
