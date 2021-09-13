from flask import Flask
from flask_restful import Resource, Api

app = Flask(_name_)
api = Api(app)

class ImageSearch(Resource):
    def get(self, tag):
        if tag == "yoga":
            return {'images': ['/data/yoga/yoga1.jpeg', '/data/yoga/yoga2.jpeg', '/data/yoga/yoga3.jpeg'],
                    'comments': ['Half Moon', 'Connecting with nature!', 'Yoga with sunset']}
        elif tag == "travel":
            return {'images': ['/data/travel/travel1.jpeg', '/data/travel/travel2.jpeg', '/data/travel/travel3.jpeg']}
        elif tag == "dogs":
            return{'images': []}
        else:
            return {'images': []}

api.add_resource(ImageSearch, '/search/<string:tag>')

if _name_ == '_main_':
    app.run(host="0.0.0.0", port=5000, debug=True)