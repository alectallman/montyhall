  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-60156695-1', 'auto');
  ga('send', 'pageview');

   $(document).on('change', 'select', function(e) {
    ga('send', 'event', 'select-strategy', 'select', $(e.currentTarget).val());
  });

     $(document).on('change', ':checkbox', function(e) {
    ga('send', 'event', 'print-results', 'select', $(e.currentTarget).val());
	 });
	 
  $(document).on('click', '#linkedin', function() {
    ga('send', 'event', 'link-click', 'linkedin');
  });

	$(document).on('click', '#twitter', function() {
    ga('send', 'event', 'link-click', 'twitter');
  });