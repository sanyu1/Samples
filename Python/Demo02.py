
#encoding=utf-8
import requests
import  os
import sys
import  urllib
import  urllib2
import time

def Download(url,filename):
    path="F:\\DownloadPics"
    if(os.path.exists(path) ==False):
        os.mkdir(path)
    filepath=os.path.join(path,"%s" % filename)
    data=urllib2.urlopen(url).read()
    with open(filepath,"wb") as f:
        f.write(data)

    return



def Request(param):
    searchurl="http://image.baidu.com/search/avatarjson"
    response=requests.get(searchurl,params=param)
    print response.url
    print  "----------------------------"
    json=response.json()["imgs"]
    print len(json)
    for i in range(0,len(json)):
        filename=os.path.split(json[i]["objURL"])[1]
        print  "Downloading from %s" % json[i]["objURL"]
        try:
            Download(json[i]["objURL"],filename)
        except:
            print json[i]["objURL"] +"downlod fail"



def Search():
    params = {
        'tn': 'resultjsonavatarnew',
        'ie': 'utf-8',
        'cg': '',
        'itg': '',
        'z': '0',
        'fr': '',
        'width': '',
        'height': '',
        'lm': '-1',
        'ic': '0',
        's': '0',
        'word': "张国荣",
        'st': '-1',
        'gsm': '',
        'rn': '30'
    };

    count=0

    while (count < 360):
        params["pn"] = "%d" % count
        Request(params)
        count +=30

    return


if __name__=="__main__":
    Search()
