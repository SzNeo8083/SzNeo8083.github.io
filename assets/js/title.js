// Array containing different titles to cycle through
var titles = [
  "$ fentanyl.win", 
  "$ entanyl.win", 
  "$ ntanyl.win", 
  "$ tanyl.win", 
  "$ anyl.win", 
  "$ nyl.win", 
  "$ yl.win", 
  "$ l.win", 
  "$ .win", 
  "$ win", 
  "$ in", 
  "$ n", 
  "$ in", 
  "$ win", 
  "$ .win", 
  "$ l.win", 
  "$ yl.win", 
  "$ nyl.win", 
  "$ anyl.win", 
  "$ tanyl.win", 
  "$ ntanyl.win", 
  "$ entanyl.win", 
];

function changeTitle() {
  var index = 0; 
  setInterval(function() {
      document.title = titles[index];
      index = (index + 1) % titles.length;
  },
  200); 
}

changeTitle();
