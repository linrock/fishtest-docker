import gzip
from pathlib import Path

from fastapi import FastAPI, HTTPException, UploadFile

app = FastAPI()


@app.post("/upload_net/", status_code=201)
async def create_upload_net(upload: UploadFile) -> None:
    net_file = upload.filename
    net_file_gz = Path("/app/net-server/nn/") / (net_file + ".gz")
    try:
        with gzip.open(net_file_gz, "xb") as f:
            f.write(await upload.read())
    except FileExistsError as e:
        print(e)
        raise HTTPException(
            status_code=409,
            detail=f"File {net_file} already uploaded",
        )
    except Exception as e:
        print(e)
        raise HTTPException(
            status_code=500,
            detail=f"Failed to write file {net_file}",
        )
