//	Javascript to tag file downloads and external links in Google Analytics
//	To use, place reference to this file should be placed at the bottom of all pages, 
//	just above the Google Analytics tracking code.
//	All outbound links and links to non-html files should now be automatically tracked.
//
//  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//	Created by: 	Colm McBarron, colm.mcbarron@iqcontent.com
//	Last updated: 	12-Feb-2006
//	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//

var hrefs = document.getElementsByTagName("a");
var link_path = "";
for (var l = 0; l < hrefs.length; l++) {
		try {
			var link_path = hrefs[l].pathname;
			if (location.host == hrefs[l].hostname) {
				if (link_path.match(/\.(doc|pdf|xls|ppt|zip|txt|vsd|vxd|js|css|rar|exe|wma|mov|avi|wmv|mp3)$/)) {
					addtrackerlistener(hrefs[l]);
				}
			} else {
				addtrackerlistener(hrefs[l]);
			}
		}
		catch(err) { }
}


function addtrackerlistener(obj) {
	if (obj.addEventListener) {
		obj.addEventListener('click', trackfiles, true);
	} else if (obj.attachEvent) {
		obj.attachEvent("on" + 'click', trackfiles);
	}
}

function trackfiles(array_element) {
	file_path = "";
	if (location.host != this.hostname) {
		file_path = "/exlinks/" + ((array_element.srcElement) ? "/" + array_element.srcElement.hostname : this.hostname);
	}
	file_path = file_path + ((array_element.srcElement) ? "/" + array_element.srcElement.pathname : this.pathname);
	urchinTracker(file_path);
}