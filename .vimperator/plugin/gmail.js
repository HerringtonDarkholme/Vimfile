// Vimperator plugin: gmail-biff
// Author: mattn <mattn.jp@gmail.com> - http://mattn.kaoriya.net
// Maintainer: Herrington Darkholme
(function(){
  const ICON = 'data:image/png;base64,'+
    'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQEAIAAADAAbR1AAAACXBIWXMAAABIAAAASABGyWs+AAAA'+
    'CXZwQWcAAAAQAAAAEABcxq3DAAAEXklEQVQ4y7WUXUxTdxyG33/bU6gIY5VSa8WkXSUu6hyDKMkM'+
    'S1TAuSUQl10sMtAsGnQKs64Vq5KAGWNxas1E/GJ1YHQJjMT4FdEZIqgJBkRnZA7mV0uFCuLgcNpz'+
    '2vP/7UKz7GLJrnwu3svn5k0eRkREhNeGDiFswzYMUiVVIpmtYqtgww7sANCABgAxxP7XUoxiPMU5'+
    'nMNT8pAHZraVbYUVdajD+OKzj84+Cma7FrsWD3+8q3dXr/zjXcNdA5EUlsJEk/ZJO5EYESNEoiIq'+
    'RKIsykSTwqRAJMmSHCt/Yntie/bcO9M7M5jmvOO889TQpDapkhSZEpmikz99kPAgQWxt97f70Udl'+
    'VCa3DNQM1KR8Uq6UKwY1oyKjAm/iEA4BaEQjgIVYCECBokgPpYfSyOa6kbqRydYOZ4cTnbEDsQMT'+
    'C+ROuZMXLr239J6GbdHe1N5Ei/a09rTwTVp5Wnl0dLBosGjYVS1Xy+JvV+ZdmQcPP8qPAuhGN0Jg'+
    'YOFbt/pv9Q9bqpZULQlf6antqY0T0y+kX2AufbO+WW1CGcq4jVu4RQOOcYyjlfIob8rPWY4sh+mU'+
    '64TrBH7iZ/iZ0PHaYG3wxWcty1qWUYK0V9o7IbTVtNUML68qqiqK1g5Zh6ym0k0FmwoSVy83Ljfy'+
    'jZRO6dSOgzgIO5vFZule3TRBbdSGY7q1urWJ/tyruVd126cFpvmfzffO8FpGN9Qfrj8s2a55r3kj'+
    'G/vQB21icl5ynrnDOcc5J0HOCeeEXxxpvt58nc+nVErlH1AlVWIAbrg1pAIAogAACY/xGBbmYz7D'+
    'zsy3Mh3TS9we9w/xMftD+4PJ32/subFHaJxunm42n3Sfd59P8OXk5+TjLzjgoFJ+jB+LvsO7ebfq'+
    'IpVUGKGFVof9YGCUDwaGD2GHHRrexbtgfJ7zPFe/Oik1yZQaqFhfsV5Uu/xdgYS6rJ6sHv1dw5hh'+
    'DL+EskPZEExTTVPVNdRIjfI4ZVBGtJpyKRdvQICgQy9kKBhjK9gKOidnypkkBD4PFMMsfCdUQzMj'+
    'd8ZSHQlFwpZkcXbD7AaMwAormWO9sV5kj64cXYn2gBSQ1AGpTCpTWvgavkZ10n26j07EIU5HfdiN'+
    'L/hMWknFfFDeKX/L25JKk0phStyY+CXAClgBhlRFjWEME5gAwz7sg8yy2SK0pmSkvEenpFFpNJoS'+
    'bgo3Rf/k6/g6/jaVUAmmIh/5uuju2OVYn+yJxkWNkQXCImGu5GZO9jUziZfEywBKUAKG27gNBgaG'+
    'l1nRwI8A3cR93Ma7zMYskSf6An2hauMn+UmaSyqpCGIIQzql2njReP3ZR2l/pPWPlIxL42OBLW3u'+
    'i+XYDgfLBv5R4lUy7gEA+gEwvA8NJOrB99imbAh6gnVhv3WzdbP2K6PH6NHEs3pWz6T9ok/0DXmD'+
    'jqBDzlGuKh2YYD7mA6AB+4/uRP+1HACDAD3ikEe/0iVYUIjCuOPxarxq6bGGrCH2umuqeX3ql/wN'+
    'QBozxfxKbAIAAAAASUVORK5CYII=';

  var gmailBiffIntervals = 30 * 1000;

  var gmailBiffIcon = document.createElement('statusbarpanel');
  gmailBiffIcon.setAttribute('id','gmail-biff-icon');
  gmailBiffIcon.setAttribute('class','statusbarpanel-iconic');
  gmailBiffIcon.setAttribute('src', ICON);
  gmailBiffIcon.setAttribute('style', 'filter: grayscale(100%)');
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
  styleSheets.insertRule(`#gmail-biff-icon::after {
    content: attr(count);
    background: linear-gradient(#E80000, #B30000);
    border-radius: 3px;
    color: white;
    position: absolute;
    top: 0;
    left: -.5em;
    transition: all 1s ease;
    font-size: .5em;
    text-align: center;
    font-weight: bold;
    text-shadow: 0 1px rgba(255, 255, 255, 0.2);
    line-height: 1.5em;
    width: 0;
    height: 0;
    visibility: hidden;
    transform: rotateZ(720deg);
  }`, styleSheets.cssRules.length);
  styleSheets.insertRule(`#gmail-biff-icon.unread::after {
    visibility: visible;
    width: 1.5em;
    height: 1.5em;
    transform: rotateZ(0deg);
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
        setTimeout(check, gmailBiffIntervals);
      };
  }
  setTimeout(check, 1000);
})();
// vim:sw=2 ts=2 et:
