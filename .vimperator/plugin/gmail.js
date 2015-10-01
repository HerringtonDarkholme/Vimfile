// Vimperator plugin: gmail-biff
// Author: mattn <mattn.jp@gmail.com> - http://mattn.kaoriya.net
// Maintainer: Herrington Darkholme
(function(){
    const ICON = 'data:image/png;base64,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';

  var gmailBiffIntervals = 30 * 1000;

  var gmailBiffIcon = document.createElement('statusbarpanel');
  gmailBiffIcon.setAttribute('id','gmail-biff-icon');
  gmailBiffIcon.setAttribute('class','statusbarpanel-iconic');
  gmailBiffIcon.setAttribute('src', ICON);
  gmailBiffIcon.setAttribute('style', 'filter: grayscale(100%);');
  gmailBiffIcon.setAttribute('tooltip', 'gmail-biff-tip');
  gmailBiffIcon.addEventListener('click',function(){
    liberator.open('https://mail.google.com/', liberator.NEW_TAB);
  },false);

  var gmailBiffTip = document.createElement('tooltip');
  gmailBiffTip.setAttribute('id','gmail-biff-tip');
  var gmailBiffText = document.createElement('description');
  gmailBiffText.setAttribute('id','gmail-biff-text');
  gmailBiffTip.appendChild(gmailBiffText);

  var statusBar = document.getElementById('liberator-statusline');
  statusBar.insertBefore(gmailBiffIcon, statusBar.firstChild);
  statusBar.insertBefore(gmailBiffTip, statusBar.firstChild);

  var styleSheets = document.styleSheets[0];
  styleSheets.insertRule(`#gmail-biff-icon {
    position: relative;
    transform-origin: 30% 50%;
    padding: 0;
    margin: 0 .5em;
    transition: transform 1s ease;
  }`, styleSheets.cssRules.length);
  styleSheets.insertRule(`#gmail-biff-icon.unread {
      transform: rotate(720deg);
      margin: 0;
  }`, styleSheets.cssRules.length);
  styleSheets.insertRule(`#gmail-biff-icon::after {
    content: attr(count);
    background: linear-gradient(#B30000, #E80000);
    border-radius: 3px;
    color: white;
    position: absolute;
    margin-bottom: -1em;
    margin-left: -1em;
    transition: all 1s ease;
    transition-delay: 1s;
    font-size: .75em;
    text-align: center;
    font-weight: bold;
    text-shadow: 0 1px rgba(255, 255, 255, 0.2);
    line-height: 1.4em;
    width: 0;
    height: 0;
    visibility: hidden;
  }`, styleSheets.cssRules.length);
  styleSheets.insertRule(`#gmail-biff-icon.unread::after {
    visibility: visible;
    width: 1.4em;
    height: 1.4em;
  }
  `, styleSheets.cssRules.length);

  function handleResp(xhr) {
    try {
      var count = parseInt(
        xhr.responseXML.getElementsByTagName('fullcount')[0]
        .childNodes[0].nodeValue);
      gmailBiffIcon.setAttribute('style', '');
      gmailBiffIcon.setAttribute('count', count);
      gmailBiffIcon.className = count > 0 ?
        'unread statusbarpanel-iconic' : 'statusbarpanel-iconic';
      gmailBiffText.setAttribute('value',
        count > 0 ? 'You have new mail (' + count + ')' : 'No new mail');
    } catch(e) {
      gmailBiffIcon.setAttribute('style', 'filter: grayscale(100%)');
      gmailBiffText.setAttribute('value',
        'GmailBiff Error! Change source code and see log');
      // liberator.log(e);
      liberator.echoerr('Gmail Biff: Error');
    }
  }

  function check() {
      const FEED_URL = 'https://mail.google.com/mail/feed/atom';
      var xhr = new XMLHttpRequest();
      xhr.timeout = 10000;
      xhr.open('GET', FEED_URL);
      xhr.send(null);
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) handleResp(xhr);
          setTimeout(check, gmailBiffIntervals);
        }
      };
      xhr.ontimeout = function() {
        xhr.abort();
        gmailBiffIcon.setAttribute('style', 'filter: grayscale(100%)');
        gmailBiffText.setAttribute('value', 'Cannot connect to Gmail');
      };
  }
  setTimeout(check, 1000);
})();
// vim:sw=2 ts=2 et:
