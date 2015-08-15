// Vimperator plugin: tab-buf-solarized
// Maintainer: Herrington Darkholme
//
// {{{ Information
let INFO = xml`
<plugin name="buftabs" version="1.2"
    href=""
    summary="Buftabs: show the tabbar in the statusline"
    xmlns="http://vimperator.org/namespaces/liberator">
<author email="s2marine0@gmail.com">s2marine</author>
<license href="">GPLv3</license>
<p>
  This is a fork from Lucas de Vries's buftabs (https://github.com/GGLucas/vimperator-buftabs).
  I fixed it.
</p>
<item>
<tags>'buftabs'</tags>
<spec>'buftabs'</spec>
<type>boolean</type>
<default>true</default>
<description>
Toggle the buftabs on or off.
</description>
</item>
<item>
<tags>'buftabs_maxlength'</tags>
<spec>'buftabs_maxlength'</spec>
<type>number</type>
<default>25</default>
<description>
The maximum length in characters of a single entry in the buftabs line.
Set to 0 for unlimited.
</description>
</item>
</plugin>
`;
// }}}

(function () {

  const TAB_NUMS = 12;
  Buftabs = {
    createBar() {
      var statusline = document.getElementById("liberator-statusline");
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      var insertIndex = document.getElementById("liberator-status");
      if (!buftabsBar) {
        var buftabsBar = document.createElement("ul");
        window.buftabs = buftabsBar
        buftabsBar.setAttribute("id", "liberator-statusline-buftabs");
        buftabsBar.setAttribute("style", `
            background: transparent;
            width: 600px;
            display: flex;
            margin-left: -10px;`);
        statusline.insertBefore(buftabsBar, insertIndex);
      }
    },
    clearBar() {
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      while (buftabsBar.hasChildNodes()) {
        buftabsBar.removeChild(buftabsBar.lastChild);
      }
    },
    visibleTabRange(browsers) {
      let current = gBrowser.tabContainer.selectedIndex;
      let half = Math.floor(TAB_NUMS/2);
      let start = Math.max(current - half, 0);
      let end = Math.min(start + TAB_NUMS, browsers.length);
      return [start, end];
    },
    fillBar() {
      var buftabsBar = document.getElementById("liberator-statusline-buftabs");
      var browsers = window.getBrowser().browsers;
      let [start, end] = Buftabs.visibleTabRange(browsers);
      for (let i = start; i < end; i++) {
        var selected = i === gBrowser.tabContainer.selectedIndex;
        var buftab = document.createElement("li");
        var title = (i+1)+"."+browsers[i].contentTitle.substr(0, selected ? 12 : 6);
        // buftab.setAttribute("value", title);
        buftab.textContent = title;
        (function(i) {
          buftab.onmousedown = function(e) {
            if(e.button==0) {
              gBrowser.selectTabAtIndex(i);
            }
            else if(e.button==1) {
              gBrowser.removeTab(gBrowser.tabs[i])
            }
          };
        })(i);

        if (selected) {
          buftab.setAttribute("style", `
              background:#b58900;
              border-radius:1px;
              color:#EEE8D5;
              flex: 0 1 auto;
              white-space: nowrap;
              font-weight:bold;`);
        }
        else {
          buftab.setAttribute("style", `
              background:#EEE8D5;
              border-radius:1px;
              flex: 0 1 auto;
              margin: 0 3px;
              white-space: nowrap;
              color:#268bd2;`);
        }
        buftabsBar.appendChild(buftab);
      }
    },
    updateUrl: function() {
      this.clearBar();
      this.fillBar();
    },
  };


  Buftabs.createBar();

  var tabContainer = window.getBrowser().mTabContainer;



  /*
  window.getBrowser().addEventListener("load", function (event) {
    Buftabs.updateUrl();
  }, false);
  */

  tabContainer.addEventListener("TabOpen", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabSelect", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabMove", function (event) {
    Buftabs.updateUrl();
  }, false);
  tabContainer.addEventListener("TabClose", function (event) {
    setTimeout("Buftabs.updateUrl()", 200);
  }, false);
  window.getBrowser().addEventListener("DOMTitleChanged", function (event) {
    Buftabs.updateUrl();
  }, false);

})();

// vim:sw=2 ts=2 et si fdm=marker:
