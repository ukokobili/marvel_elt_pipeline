import os
import requests as rq
import pandas as pd
import hashlib
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Retrieve API credentials from environment variables
api_key = os.getenv('API_KEY')
private_key = os.getenv('PRIVATE_KEY')
ts = os.getenv('TS')

# encode the api keys
result = hashlib.md5((ts + private_key + api_key).encode())
hash_key = result.hexdigest()

# list of marvel characters for API call
ids = [1011334, 1017100, 1009144, 1010699, 1009146, 1016823, 1009148, 1009149, 1010903, 1011266, 1010354, 1010846,
       1017851, 1012717, 1011297, 1011031, 1009150, 1011198, 1011175, 1011136]

# base url for get request
baseurl = 'http://gateway.marvel.com'

# endpoints for the different schemas
endpoint = '/v1/public/characters'
stories_ = '/stories'
series_e = '/series'
comics_ = '/comics'
events_ = '/events'

# define get stories function
def stories():
    # list for all character IDs details
    main = []
    # loop through the IDs
    for a in ids:
        # get request from the API
        r = rq.get(f'{baseurl}{endpoint}/{a}{stories_}?ts={ts}&apikey={api_key}&hash={hash_key}')
        # return json string
        data = r.json()
        # append to main list
        main.append(data)
    # stories list
    stories = []
    # loop through get
    for response in main:
        results = response['data']['results']

        for details in results:
            story = {
                'id': details['id'],
                'title': details['title'],
                'description': details['description'],
                'modified_date': details['modified'],
                'type': details['type'],
                'character_id': details['characters']['items'][0]['resourceURI'].replace('/', ' ').split()[-1],
                'comics_id': details['comics']['items'][0]['resourceURI'].replace('/', ' ').split()[-1]
            }
            stories.append(story)
    data_ = pd.DataFrame(stories)
    return data_


def comics():
    main = []
    # loop through the IDs
    for a in ids:
        # get request from the API
        r = rq.get(f'{baseurl}{endpoint}/{a}{comics_}?ts={ts}&apikey={api_key}&hash={hash_key}')
        # return json string
        data = r.json()
        # append to main list
        main.append(data)
    comics = []
    for response in main:
        results = response['data']['results']
        for details in results:
            comic = {
                'id': details['id'],
                'title': details['title'],
                'description': details['description'],
                'modified_date': details['modified'],
                'number_of_pages': details['pageCount'],
                'print_price': details['prices'][0]['price'],
                'digital_purchase_price': details['prices'][-1]['price'],
                'character_id': details['characters']['items'][0]['resourceURI'].replace('/', ' ').split()[-1]
            }
            comics.append(comic)
    data_ = pd.DataFrame(comics)
    return data_


def events():
    main = []
    # loop through the IDs
    for a in ids:
        # get request from the API
        r = rq.get(f'{baseurl}{endpoint}/{a}{events_}?ts={ts}&apikey={api_key}&hash={hash_key}')
        # return json string
        data = r.json()
        # append to main list
        main.append(data)
    events = []
    for response in main:
        results = response['data']['results']

        for details in results:
            event = {
                'id': details['id'],
                'title': details['title'],
                'description': details['description'],
                'modified_date': details['modified'],
                'started': details['start'],
                'ended': details['end'],
                'character_id': details['characters']['items'][0]['resourceURI'].replace('/', ' ').split()[-1],
                'creators_id': details['creators']['items'][0]['resourceURI'].replace('/', ' ').split()[-1],
                'creators': details['creators']['items'][0]['name'],
                'creators_role': details['creators']['items'][0]['role'],
                'comics_id': details['comics']['items'][0]['resourceURI'].replace('/', ' ').split()[-1],
            }
            events.append(event)
    data_ = pd.DataFrame(events)
    return data_


def characters():
    main = []
    # loop through the IDs
    for a in ids:
        # get request from the API
        r = rq.get(f'{baseurl}{endpoint}/{a}?ts={ts}&apikey={api_key}&hash={hash_key}')
        # return json string
        data = r.json()
        # append to main list
        main.append(data)

    characters = []
    for response in main:
        results = response['data']['results']

        for details in results:
            xter = {
                'id': details['id'],
                'name': details['name'],
                'description': details['description'],
                'modified_date': details['modified']
            }
            characters.append(xter)
    data_ = pd.DataFrame(characters)
    return data_


def series():
    # list for all character IDs details
    main = []
    # loop through the IDs
    for a in ids:
        # get request from the API
        r = rq.get(f'{baseurl}{endpoint}/{a}{series_e}?ts={ts}&apikey={api_key}&hash={hash_key}')
        # return json string
        data = r.json()
        # append to main list
        main.append(data)
    series_list = []
    for response in main:
        results = response['data']['results']

        for details in results:
            series_ = {
                'id': details['id'],
                'title': details['title'],
                'description': details['description'],
                'modified_date': details['modified'],
                'start_year': details['startYear'],
                'end_year': details['endYear'],
                'rating': details['rating'],
                'type': details['type'],
                'character_id': details['characters']['items'][0]['resourceURI'].replace('/', ' ').split()[-1],
                'comics_id': details['comics']['items'][0]['resourceURI'].replace('/', ' ').split()[-1]
            }
            series_list.append(series_)
    data_ = pd.DataFrame(series_list)
    return data_