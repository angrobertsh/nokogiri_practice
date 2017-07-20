function scrape(url){
  var page = fetch(url).then((resp) => resp.text().then((resp) => {return resp}))

  var links = document.getElementsByTagName("a");
  var i = 0;
  var c = [];
  var promises = [];
  var answers = [];

  while(i < links.length){
    c.push(links[i].href);
    i += 1
  }

  c.forEach((link) => {
    fetch(link).then((resp) => {
      console.log(link + " " + resp.ok)
    })
  })

}

scrape('https://scottduane.github.io/TopSecretClue/')
