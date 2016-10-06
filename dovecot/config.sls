{%- from "dovecot/map.jinja" import dovecot with context -%}

include:
  - dovecot

{% for file, file_config in salt['pillar.get']('dovecot:confd', {})|dictsort %}
{%- if file_config is string %}
dovecot-confd-{{ file }}:
  file.managed:
    - name: {{ dovecot.config_confd_dir }}/{{ file }}.conf
    - contents: |
        {{ file_config|indent(8) }}
    - watch_in:
      - cmd: dovecot-reload
{%- else %}
{%- for line in file_config.get('comment', []) %}
dovecot-confd-{{ file }}-comment-{{ loop.index }}:
  file.comment:
    - name: {{ dovecot.config_confd_dir }}/{{ file }}.conf
    - regex: {{ line }}
{%- endfor %}
{%- endif %}
{% endfor %}

{% for file, file_config in salt['pillar.get']('dovecot:confd-ext', {})|dictsort %}
dovecot-confd-ext-{{ file }}:
  file.managed:
    - name: {{ dovecot.config_confd_dir }}/{{ file }}.conf.ext
    - contents: |
        {{ file_config|indent(8) }}
    - watch_in:
      - cmd: dovecot-reload
{% endfor %}

{% for file, file_config in salt['pillar.get']('dovecot:conf-ext', {})|dictsort %}
dovecot-conf-ext-{{ file }}:
  file.managed:
    - name: {{ dovecot.config_conf_dir }}/{{ file }}.conf.ext
    - contents: |
        {{ file_config|indent(8) }}
    - watch_in:
      - cmd: dovecot-reload
{% endfor %}
