#!/bin/bash
# Usage: ./run_debug.sh <number>
# Example: ./run_debug.sh 10

if [ -z "$1" ]; then
  echo "Usage: $0 <number>"
  exit 1
fi

num="$1"

llm -m o1-mini <<EOF
Below is the actual output produced by running the SQL query from sql/${num}.sql:

$(docker compose exec -T pg psql -U postgres -f sql/${num}.sql)

Below is the expected output as provided in expected/${num}.out:

$(cat expected/${num}.out)

Please compare the actual output with the expected output. Identify and list all differences between them and suggest possible reasons for these differences.
EOF

