const express = require('express');

const app = express();

const server = app.listen(4000);

const bodyParser = require("body-parser");

const translate = require("translate");

translate.engine = "google";

const LanguageDetect = require('languagedetect');
const lngDetector = new LanguageDetect();


app.use(express.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static('public'))

app.options('/*', function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Content-Type");
    next();
});

app.post('/*', async (request, response, next) => {
    response.header("Access-Control-Allow-Origin","*");
    response.header("Access-Control-Allow-Headers","Content-Type");
    next();
});


app.get(`/api`, function (request, response) {
    response.send('This is version 1.0 of Cloud Project');
});



app.get(`/translate/:text`, async (request, response) => {
    //const text = request.body.text
    const text = request.params.text

    const posLanguages = lngDetector.detect(text)

    const params = detectLanguage(posLanguages);


    const translatedText = await translate(text, params)
    response.send({"translation" : translatedText});
});
app.post(`/translate`, async (request, response) => {
    const text = request.body.text

    const posLanguages = lngDetector.detect(text)

    const params = detectLanguage(posLanguages);


    const translatedText = await translate(text, params)
    response.send({"translation" : translatedText});
});


function detectLanguage(languageList){
    for (const posLanguagesKey of languageList) {
        if (posLanguagesKey[0] == 'german'){
            return  { to: "en", from: "de"};
        }
        else if (posLanguagesKey[0] == 'english'){
            return { to: "en", from: "en"};
        }
        else if (posLanguagesKey[0] == 'french'){
            return { to: "en", from: "fr"};
        }
        else if (posLanguagesKey[0] == 'spanish'){
            return { to: "en", from: "es"};
        }
    }
    return { to: "en", from: "en"};
}