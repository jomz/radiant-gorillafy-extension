Object.extend(String.prototype, {
	oldToSlug: String.prototype.toSlug,
	toTransliteratedSlug: function() {
	  var diacritics = [
      [/[\300-\306]/g, 'A'],
	    [/[\340-\346]/g, 'a'],
	    [/[\310-\313]/g, 'E'],
	    [/[\350-\353]/g, 'e'],
	    [/[\314-\317]/g, 'I'],
	    [/[\354-\357]/g, 'i'],
      [/[\322-\330]/g, 'O'],
      [/[\362-\370]/g, 'o'],
      [/[\331-\334]/g, 'U'],
      [/[\371-\374]/g, 'u'],
      [/[\321]/g, 'N'],
      [/[\361]/g, 'n'],
      [/[\307]/g, 'C'],
      [/[\347]/g, 'c'],
		];
	  var s = this;
	  for (var i = 0; i < diacritics.length; i++) {
	  	s = s.replace(diacritics[i][0], diacritics[i][1]);
		}
		return s.oldToSlug();
	},
});
String.prototype.toSlug = String.prototype.toTransliteratedSlug;