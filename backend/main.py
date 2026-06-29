from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from groq import Groq
import os
from pathlib import Path
from dotenv import load_dotenv


load_dotenv(dotenv_path=Path(__file__).with_name(".env"))


class chatRequest(BaseModel):
    message: str    
    

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True
)

def get_groq_client() -> Groq:
    api_key = os.environ.get("GROQ_API_KEY")
    if not api_key:
        raise HTTPException(
            status_code=500,
            detail="Missing GROQ_API_KEY. Set it in your environment before calling /chat.",
        )
    return Groq(api_key=api_key)


def get_bot_response(user_message):
    message = user_message.lower()
    client = get_groq_client()

    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "user",
                "content": message,
            }
        ],
        model="llama-3.3-70b-versatile",
        stream=False,
    )

    return chat_completion.choices[0].message.content
    

@app.post("/chat")
async def chat(req: chatRequest):
    response = get_bot_response(req.message)
    return {"response": response}
    