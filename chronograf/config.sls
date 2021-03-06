{% from "chronograf/map.jinja" import chronograf with context %}


chronograf-init:
  file.managed:
    - name: /etc/init.d/chronograf
    - source: salt://chronograf/files/chronograf_init.sh
    - mode: 555
    - context:
        chronograf: {{ chronograf|json }}
    - template: jinja
    - require:
      - sls: chronograf.install

chronograf-boltdb:
  file.managed:
    - name: {{ chronograf.environment.bolt_path }}
    - mode: 640
    - user: chronograf
    - group: chronograf
    - makedirs: True
    - replace: False

chronograf-cannedpath:
  file.directory:
    - name: {{ chronograf.environment.canned_path }}
    - mode: 755
    - user: chronograf
    - group: chronograf
    - makedirs: True
    - recurse:
      - user
      - group

chronograf-config:
  file.managed:
    - name: /etc/default/chronograf
    - source: salt://chronograf/files/chronograf_env.sh
    - mode: 644
    - context:
        chronograf: {{ chronograf|json }}
    - template: jinja
    - require:
      - sls: chronograf.install
