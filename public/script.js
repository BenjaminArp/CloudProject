let latestTranslation = ""
async function translateGivenText() {
    let text = document.getElementById("searchTxt").value;
    text = text.replace("?", "%3F")
    let url = "http://193.196.54.78:4000/translate/" + text
    let response = await fetch(url)
    response = await response.json()
    latestTranslation = response['translation']
    document.getElementById('result').innerHTML = response['translation'];
}

async function speakCustomText() {
    let text = latestTranslation.replace("?", "%3F")
    let url = "http://193.196.54.78:4000/speak/" + text
    let response = await fetch(url)
    response = await response.json()
    const snd = new Audio("data:audio/wav;base64," + response['audio']);
    snd.play();
}