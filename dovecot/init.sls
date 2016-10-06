{%- from "dovecot/map.jinja" import dovecot with context -%}

dovecot-packages:
  pkg.installed:
    - pkgs: {{ dovecot.packages }}

dovecot-service:
  service.running:
    - name: {{ dovecot.service }}
    - enable: True
    - require:
      - pkg: dovecot-packages

dovecot-reload:
  cmd.wait:
    - name: dovecot reload

dovecot-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ dovecot.service }}
