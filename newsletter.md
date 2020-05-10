---
layout: page
title: Newsletter
---


<div class="related">
  <h2>Past newsletters</h2>
  <ul class="related-posts">
    {% assign posts = site.categories["newsletter"] %}
    {% for post in posts %}
      <li>
        <h3>
          <a href="{{ post.url }}">
            {{ post.title }}
            <small>{{ post.date | date_to_string }}</small>
          </a>
        </h3>
      </li>
    {% endfor %}
  </ul>
</div>




<div class="related">
    <form style="border:1px solid #ccc;padding:3px;text-align:center;" action="https://tinyletter.com/vivekjuneja" method="post" target="popupwindow" onsubmit="window.open('https://tinyletter.com/vivekjuneja', 'popupwindow', 'scrollbars=yes,width=800,height=600');return true"><p>
    If you like this, subscribe to my Weekly Newsletter
    <h2> "In Your Shoes"</h2>
    <i>A weekly curated newsletter around books, productivity, leadership, decision making to thrive in the world of unlimited information</i><br /><br />
    <label for="tlemail">Enter your email address</label></p><p><input type="text" style="width:140px" name="email" id="tlemail" /></p><input type="hidden" value="1" name="embed"/><input type="submit" value="Subscribe" /><p><a href="https://tinyletter.com" target="_blank">powered by TinyLetter</a></p><p><h6>No SPAM and Selling of Email address. Guaranteed ! </h6></p></form>
</div>
<br />

<h3>What is the purpose of Newsletter</h3>
In the world of endless information sources, what remains hard for me is to find the right source of knowledge that I could use to shape my thinking and influence the decisions I make on a daily basis in personal life and at work. With this newsletter, it is my attempt to curate the information that shapes my thinking on a weekly basis. I hope this becomes useful for others - and thus helps create a learning environment for all of us. 

Happy Reading !

 <img src='../images/newsletter.JPG' alt=''>


