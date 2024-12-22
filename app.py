from flask import Flask, jsonify
from urllib.parse import quote as url_quote

app = Flask(__name__)
#route responds to GET requests at the /student endpoint
@app.route('/student', methods=['GET'])
def get_student_status():
    return jsonify({"student_status": "hired"})

#route for GET requests to /    to avoid 404 error
@app.route('/', methods=['GET'])
def home():
    return jsonify({"message": "Welcome to the Student API! To check the student status, please add : '/student' to the  current URL "})

if __name__ == '__main__':
    app.run(host='localhost', port=5000)


#http://127.0.0.1:5000/student