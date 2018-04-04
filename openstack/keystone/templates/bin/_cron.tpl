#!/usr/bin/env bash

set -ex

export STDOUT=${STDOUT:-/proc/1/fd/1}
export STDERR=${STDERR:-/proc/1/fd/2}

cat <(crontab -l) <(echo "{{ default "0 * * * *"  .Values.cron.cronSchedule }} PATH=${PATH}; {{- if .Values.sentry.enabled }} export SENTRY_DSN=${SENTRY_DSN}; {{- end }} {{- if .Values.postgresql.useOperator }} export PGUSER=${PGUSER}; export PGPASSWORD=${PGPASSWORD}; {{- end }} . /scripts/repair_assignments > ${STDOUT} 2> ${STDERR}") | crontab -

exec cron -f
