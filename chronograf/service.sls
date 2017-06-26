{% from "chronograf/map.jinja" import chronograf with context %}

chronograf-service:
  service.running:
    - name: chronograf
    - enable: {{ chronograf.enabled }}
    - watch:
      - sls: chronograf.install
      - sls: chronograf.config
    - require:
      - sls: chronograf.install
      - sls: chronograf.config
