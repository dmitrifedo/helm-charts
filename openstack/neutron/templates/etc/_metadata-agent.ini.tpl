# metadata_agent.ini
[DEFAULT]
debug = {{.Values.debug}}

#endpoint_type = internalURL

{{ if .Values.metadata_use_api_endpoint -}}
nova_metadata_ip = {{include "nova_api_endpoint_host_internal" .}}
nova_metadata_host = {{include "nova_api_endpoint_host_internal" .}}
{{ else -}}
nova_metadata_ip = {{include "nova_api_metadata_endpoint_host_internal" .}}
nova_metadata_host = {{include "nova_api_metadata_endpoint_host_internal" .}}
{{ end -}}
nova_metadata_protocol = {{.Values.global.nova_api_endpoint_protocol_internal | default "http"}}
nova_metadata_port = {{ .Values.global.nova_metadata_port_internal | default 8775 }}

metadata_proxy_shared_secret = {{required "A valid .Values.global.nova_metadata_secret required!" .Values.global.nova_metadata_secret}}
metadata_proxy_socket=/run/metadata_proxy
cache_url = {{ .Values.agent.cache_url | default .Values.global.cache_url | default "memory://?default_ttl=5" }}

rpc_response_timeout = {{ .Values.metadata_rpc_response_timeout | default .Values.global.rpc_response_timeout | default 50 }}
rpc_workers = {{ .Values.rpc_workers | default .Values.global.rpc_workers | default 5 }}
metadata_workers = {{ .Values.agent.metadata_workers | default .Values.global.metadata_workers | default 1 }}
