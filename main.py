import random
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from googletrans import Translator
from flask import Flask, jsonify, request

app = Flask(__name__)

def translate_to_french(word):
    translator = Translator()
    translation = translator.translate(word, src='en', dest='fr')
    return translation.text

data_doc = pd.read_csv("dataset.csv")
data_matrix = np.array(data_doc)

dic = {
    "Problèmes digestifs": ["GERD", "Chronic cholestasis", "Peptic ulcer disease", "Gastroenteritis"],
    "Problèmes cardiovasculaires": ["Hypertension ", "Heart attack"],
    "Problèmes neurologiques et psychiques": ["Migraine", "Paralysis (brain hemorrhage)", "Malaria", "Dengue"],
    "Troubles sexuels et Infections sexuellement transmissibles (IST)": ["Hepatitis A", "Hepatitis B",
                                                                         "Hepatitis C", "Hepatitis D",
                                                                         "Hepatitis E", "AIDS",
                                                                         "Urinary tract infection",
                                                                         "Dimorphic hemorrhoids(piles)"],
    "Problèmes pulmonaires": ["Tuberculosis", "Pneumonia"],
    "Infection & Troubles du système immunitaire": ["Fungal infection", "Drug Reaction", "Malaria", "Dengue",
                                                    "Typhoid", "Hepatitis A", "Hepatitis B", "Hepatitis C",
                                                    "Hepatitis D", "Hepatitis E", "Alcoholic hepatitis",
                                                    "Urinary tract infection", "Allergy", "Common Cold"],
    "Trouble du système hormonal et métaboliques": ["Hypothyroidism", "Hyperthyroidism", "Hypoglycemia", "Diabetes",
                                                    "Hypoglycemia"],
    "Problèmes articulaires et musculaires": ["Cervical spondylosis", "Arthritis", "Osteoarthritis"],
    "Problèmes cutanés": ["Allergy", "Jaundice", "Chicken pox", "Acne", "Psoriasis", "Impetigo"]
}

output_data = {}

for i in range(len(data_matrix)):
    val = data_matrix[i][0]

    for key, value_list in dic.items():
        if val in value_list:
            if key not in output_data:
                output_data[key] = []
            output_data[key].append(data_matrix[i])

for key, data_list in output_data.items():
    df = pd.DataFrame(data_list, columns=data_doc.columns)
    df.to_csv(f"{key}.csv", index=False)

dic2 = dict()
i = 0

for val in dic.keys():
    dic2[i] = f"{val}.csv"
    i += 1


stored_data = int()

@app.route("/receive_values", methods=["POST"])
def set_data():

    global stored_data
    data = request.json
    stored_data = data["values"]

    return "Waiting for server response"


@app.route("/get_dic", methods=["POST"])
def get_dic_matrix(k):


    global stored_data

    data_doc2 = pd.read_csv(f"{dic2[stored_data]}")
    data_matrix_2 = np.array(data_doc2)
    symptom_matrix = []

    for i in range(len(data_matrix_2)):
        for j in range(1, len(data_matrix_2[i])):
            if isinstance(data_matrix_2[i][j], str) and data_matrix_2[i][j] not in symptom_matrix:
                symptom_matrix.append(data_matrix_2[i][j])

    label_encoder = LabelEncoder()
    value_encoded = label_encoder.fit_transform(symptom_matrix)

    dic_encoded_value = dict()

    for i in range(len(symptom_matrix)):
        dic_encoded_value[symptom_matrix[i]] = value_encoded[i] + 1

    for i in range(len(data_matrix_2)):
        for j in range(1, len(data_matrix_2[i])):
            if data_matrix_2[i][j] in dic_encoded_value.keys():
                value = dic_encoded_value[data_matrix_2[i][j]]
                data_matrix_2[i][j] = value
            else:
                data_matrix_2[i][j] = 0

    if k == 0:
        return data_matrix_2
    elif k == 1:
        return symptom_matrix
    elif k == 2:
        return dic_encoded_value




@app.route("/question", methods = ["POST"])
def get_question():

    symptom_list = get_dic_matrix(1)
    questions = []
    Question = [
        "Avez-vous ce symptôme : ",
        "Estimez-vous ressentir ce symptôme : ",
        "Avez-vous eu récemment ce symptôme : ",
        "Pensez-vous être touché par ce symptôme : "
    ]

    for symptom in symptom_list:
        symptom = symptom.replace("_", " ")
        translated_word = translate_to_french(symptom)
        translated_word = translated_word.lower()
        phrase = random.sample(Question, 1)
        question = f"{phrase[0]}{translated_word}"
        questions.append(question)

    return jsonify(questions)

@app.route("/prediction", methods=["POST"])
def prediction():

    request_data = request.json
    user_responses = request_data.get("responses")

    data_matrix_2 = get_dic_matrix(0)
    data_frame = pd.DataFrame(data_matrix_2)

    x = data_frame.drop(columns=[0])
    y = data_frame[0]

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)

    model = RandomForestClassifier()
    model.fit(x_train, y_train)

    user_symptom_matrix = []

    for response in user_responses:
        if response == 1:
            user_symptom_matrix.append(1)
        else:
            user_symptom_matrix.append(0)



    if len(user_symptom_matrix) > 17:

        return jsonify("Isys n'a pas pu trouver la maladie associée, "
                       "essayez d'echanger avec votre practicien afin d'en savoir"
                       " plus.")
    elif len(user_symptom_matrix) < 17:

        while len(user_symptom_matrix) != 17:
            user_symptom_matrix.append(0)

    symptom_prediction = model.predict([user_symptom_matrix])
    translated_symptom_prediction = translate_to_french(symptom_prediction[0])



    return jsonify({"prediction": translated_symptom_prediction})


if __name__ == "__main__":
    app.run(debug=True)
