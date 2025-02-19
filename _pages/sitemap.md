---
layout: archive
title: "Sitemap"
permalink: /sitemap/
author_profile: true
---

{% include base_path %}

A list of all the posts and pages found on the site. For you robots out there, there is an XML version available for digesting as well.

<h2>Pages</h2>
{% for page in site.pages %}
  {% unless page.sitemap == false %}
    {% include archive-single.html %}
  {% endunless %}
{% endfor %}

<h2>Posts</h2>
{% for post in site.posts %}
  {% unless post.sitemap == false %}
    {% include archive-single.html %}
  {% endunless %}
{% endfor %}

{% capture written_label %}'None'{% endcapture %}

{% for collection in site.collections %}
  {% unless collection.output == false or collection.label == "posts" %}
    {% capture label %}{{ collection.label }}{% endcapture %}
    {% if label != written_label %}
      {% capture written_label %}{{ label }}{% endcapture %}
    {% endif %}
  {% endunless %}
  {% for doc in collection.docs %}
    {% unless doc.sitemap == false %}
      {% include archive-single.html %}
    {% endunless %}
  {% endfor %}
{% endfor %}