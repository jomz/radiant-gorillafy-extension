var GillSansStd = { src: '/sifr/GillSansStd.swf' };
var GillSansBoldStd = { src: '/sifr/GillSansBoldStd.swf'};

sIFR.activate(GillSansStd, GillSansBoldStd);

/*sIFR.debug.ratios({ src: '/sifr/GillSansStdBold.swf', selector: '#content h2' });*/

sIFR.replace(GillSansStd, {
 selector: '#content h1',
 css: '.sIFR-root{color:#000000}',
 wmode:'transparent',
 ratios: [9,1.16,16,1.09,24,1.06,37,1.04,74,1.02,1.01]
});

sIFR.replace(GillSansBoldStd, {
 selector: '#content h2, #content h3, #content h2 a',
 css: '.sIFR-root{color:#000000; text-transform:uppercase;}',
 wmode:'transparent',
 ratios: [9,1.16,16,1.09,24,1.06,37,1.04,74,1.02,1.01],
 tuneHeight: -2,
 offsetTop: 2
});