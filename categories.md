---
layout: default
title: Categories
---
<h1>Categories</h1>
{% for tags in site.tags %}
  <li><a name="{{ tags | first }}">{{ tags | first }}</a>
    <ul>
    {% for posts in tags %}
      {% for post in posts %}
      {% if post.url %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
      {% endif %}
      {% endfor %}
    {% endfor %}
    </ul>
  </li>
{% endfor %}

