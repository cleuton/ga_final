from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host="db",
        database="postgres",
        user="postgres",
        password=os.getenv("DB_PSW", "password"))
    return conn

@app.route('/')
def hello_world():
    #return 'Hello, World!'
    return 'Hello, World V2!!!!'
    

@app.route('/exemplos')
def get_exemplos():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM exemplo;')
    exemplos = cursor.fetchall()
    cursor.close()
    conn.close()
    
    # Convertendo os dados para um formato JSON
    return jsonify([{'id': row[0], 'nome': row[1], 'valor': row[2]} for row in exemplos])

if __name__ == '__main__':
    app.run(host='0.0.0.0')
