// Format challenge boxes
(function() {
  var codes = document.querySelectorAll('.challenge');
  var code, i, p, h, b;
  for (i = 0; i < codes.length; i++) {
    code = codes[i];
    p = code.parentNode;
    b = document.createElement('blockquote');
    h = document.createElement('strong');
    h.innerText = 'Try this:';
    // <blockquote><em>Try this:</em><p></p></blockquote>
    p.replaceChild(b, code);
    b.appendChild(h);
    b.appendChild(code);
  }
})();

// Format solution boxes
(function() {
  var codes = document.querySelectorAll('.solution');
  var code, i, d, s, p, h, b;
  for (i = 0; i < codes.length; i++) {
    code = codes[i];
    p = code.parentNode;
    b = document.createElement('blockquote');
    d = document.createElement('details');
    s = document.createElement('summary');
    h = document.createElement('strong');
    h.innerText = 'Solution:';
    // <details><summary><em>Solution:</em></summary><p>code</p></details>
    s.appendChild(h);
    d.appendChild(s);
    b.appendChild(d);
    // move the code into <details>
    p.replaceChild(b, code);
    d.appendChild(code);
  }
})();

// Format helpful tricks boxes
(function() {
  var codes = document.querySelectorAll('.callout-trick');
  var code, i, p, h, b;
  for (i = 0; i < codes.length; i++) {
    code = codes[i];
    p = code.parentNode;
    b = document.createElement('blockquote');
    h = document.createElement('strong');
    h.innerText = 'HELPFUL TRICK:';
    // <blockquote><em>HELPFUL TRICK:</em><p></p></blockquote>
    b.appendChild(h);
    b.appendChild(code);
    p.appendChild(b);
  }
})();

// Format helpful tip boxes
(function() {
  var codes = document.querySelectorAll('.callout-trick');
  var code, i, p, h, b;
  for (i = 0; i < codes.length; i++) {
    code = codes[i];
    p = code.parentNode;
    b = document.createElement('blockquote');
    h = document.createElement('strong');
    h.innerText = 'TIP:';
    // <blockquote><em>TIP:</em><p></p></blockquote>
    b.appendChild(h);
    b.appendChild(code);
    p.appendChild(b);
  }
})();
