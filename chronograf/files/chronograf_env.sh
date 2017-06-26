{%- from "chronograf/map.jinja" import chronograf with context -%}

{%- for k, v in chronograph.environment.iteritems() %}
export {{ k|upper }}="{{ v }}"
{%- endfor %}
