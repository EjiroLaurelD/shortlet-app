from flask import Flask, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the Time API! Visit /time to get the current time."

@app.route('/time', methods=['GET'])
def get_time():
    now = datetime.utcnow()
    return jsonify({'current_time': now.strftime('%Y-%m-%d %H:%M:%S')})

@app.route('/favicon.ico')
def favicon():
    return "", 204

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
