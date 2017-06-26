{% from "chronograf/map.jinja" import chronograf with context %}

chronograf-pkg:
  file.managed:
    - name: /tmp/chronograf_{{ chronograf.version }}{{ chronograf.pkgsuffix }}
    - source: {{ chronograf.source_url }}{{ chronograf.version }}{{ chronograf.pkgsuffix }}
    - source_hash: sha256={{ chronograf.source_hash }}
    - unless: test -f /tmp/chronograf_{{ chronograf.version }}{{ chronograf.pkgsuffix }}

chronograf-install:
  pkg.installed:
    - sources:
      - chronograf: /tmp/chronograf_{{ chronograf.version }}{{ chronograf.pkgsuffix }}
    - require:
      - file: chronograf-pkg
    - watch:
      - file: chronograf-pkg
