let latestTranslation = ""
async function translate() {
    let text = document.getElementById("searchTxt").value;
    console.log(text)
    text = text.replace("?", "%3F")
    let url = "http://193.196.54.78:4000/translate/" + text
    let response = await fetch(url)
    response = await response.json()
    latestTranslation = response['translation']
    document.getElementById('result').innerHTML = response['translation'];
}
async function speak() {
    // Initialize new SpeechSynthesisUtterance object
    let speech = new SpeechSynthesisUtterance();

    // Set Speech Language
    speech.lang = "en";

    speech.text = latestTranslation;

    window.speechSynthesis.speak(speech);
}