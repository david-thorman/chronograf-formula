{%- from "chronograf/map.jinja" import chronograf with context -%}

{%- for k, v in chronograf.environment.iteritems() %}
export {{ k|upper }}="{{ v }}"
{%- endfor %}
