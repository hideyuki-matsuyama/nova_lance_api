#!/bin/bash -e

if [ ! -f /rails_api/insomnia/environment.yml ]; then
  mkdir -p /rails_api/insomnia
  cat <<'EOF' > /rails_api/insomnia/environment.yml
type: environment.insomnia.rest/5.0
name: dev
meta:
  id: wrk_cd43351a9f8649f8add4b613544151ac
  created: 1750239190122
  description: ""
environments:
  name: Base Environment
  meta:
    id: env_a18f2f1f43e35cf2a6ebbb4b1a1c3362dd38581a
    created: 1750239190123
    modified: 1750253378061
    isPrivate: false
  data:
    base_url: http://localhost:3001
    email: dev@example.com
    password: password
    jwt: ""
  subEnvironments:
    - name: global
      meta:
        id: env_54a8e22513a640c5bc960be50217c6c2
        created: 1750239254323
        modified: 1750253378058
        isPrivate: false
        sortKey: 1750239254323
      data:
        base_url: http://localhost:3001
        email: dev@example.com
        password: password
        jwt: ~
EOF
fi