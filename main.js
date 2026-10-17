(function () {
  'use strict';

  // 图片缺失时保留占位块；有图时自动填充（无需改代码）
  function bindImage(imgEl) {
    var frame = imgEl.closest('.portrait, .slot');
    function filled() {
      if (frame) frame.classList.add('filled');
      imgEl.style.display = '';
    }
    function empty() {
      if (frame) frame.classList.remove('filled');
      imgEl.style.display = 'none';
    }
    imgEl.addEventListener('load', function () {
      if (imgEl.naturalWidth > 0) filled(); else empty();
    });
    imgEl.addEventListener('error', empty);
    if (imgEl.complete) {
      if (imgEl.naturalWidth > 0) filled(); else empty();
    }
  }

  document.querySelectorAll('img[data-dynamic]').forEach(bindImage);

  // 滚动淡入
  var targets = document.querySelectorAll('.reveal');
  var reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  if (reduce || !('IntersectionObserver' in window)) {
    targets.forEach(function (el) { el.classList.add('in'); });
    return;
  }

  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('in');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -8% 0px' });

  targets.forEach(function (el) { io.observe(el); });
})();
