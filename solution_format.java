(function() {
  var codes = document.querySelectorAll('.solution');
  var code, i, d, s, p, h;
  for (i = 0; i < codes.length; i++) {
    code = codes[i];
    p = code.parentNode;
    d = document.createElement('details');
    s = document.createElement('summary');
    h = document.createElement('strong');
    h.innerText = 'Solution:';
    // <details><summary><em>Solution:</em></summary></details>
    s.appendChild(h);
    d.appendChild(s);
    // move the code into <details>
    p.replaceChild(d, code);
    d.appendChild(code);
  }
})();