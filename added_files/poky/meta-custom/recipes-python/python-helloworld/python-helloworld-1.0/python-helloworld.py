#!/usr/bin/env python3
#!/usr/bin/env python3

from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def hello():
    if request.method == 'POST':
        tree = request.form.get('tree')

        f = open("/tree.txt", "w")
        for l in tree.split("\r\n"):
          f.write(l.replace("\r", "").replace("\n", ""))
          f.write("\n")
        f.write("\n")
        f.close()
    
    return '''
        <html>
          <head>
            <style>
              div {
                background-color: #e6e6e6;
                width: 70%;
                border: 15px solid #006600;
                padding: 50px;
                position: absolute;
                top: 10%;
                left: 10%;
              }

              .button {
                display: inline-block;
                padding: 6px 10px;
                font-size: 12px;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                outline: none;
                color: #663300;
                background-color: #cce5ff;
                border: none;
                border-radius: 15px;
                box-shadow: 0 9px #999;
                font-family:courier;
              }

              .button:hover {background-color: #80bdff}

              .button:active {
                background-color: #4da3ff;
                box-shadow: 0 5px #666;
                transform: translateY(4px);
              }
            </style>
          </head>
          <body>

            <div align="center">
              <h2 align="center">Insert X-Mas Tree</h2>
              <form action="" method="POST">
                <textarea name="tree" id="tree" rows="40" cols="50" required="required" style="font-family:courier;"></textarea><br><br>
                <input class="button" id="submit" name="submit" type="submit"
                       value="Submit">
              </form>

            </div>
          </body>
        </html>'''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
