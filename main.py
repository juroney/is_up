from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from fastapi.responses import RedirectResponse

from httpx import AsyncClient, AsyncHTTPTransport, Response

app = FastAPI()

transport = AsyncHTTPTransport(verify=False)


@app.get("/")
async def root():
    return RedirectResponse("/docs")


@app.get("/gh")
async def check_user():
    url = f"https://www.githubstatus.com/api/v2/status.json"
    async with AsyncClient(transport=transport) as client:
        resp: Response = await client.get(url)

    return jsonable_encoder(resp.json())
