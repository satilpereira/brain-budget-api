from pydantic import BaseModel

class Hello(BaseModel):
    name: str
    
external_data = {
    "name": "World"
}

hello =  Hello(**external_data)

print(hello)