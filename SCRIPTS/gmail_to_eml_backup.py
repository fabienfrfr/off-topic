import os
import base64
import sqlite3
from pathlib import Path

from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.discovery import build


SCOPES = ["https://www.googleapis.com/auth/gmail.readonly"]

ARCHIVE = Path("gmail_archive")
DB = "archive.db"

# Use google TakeOut, it's easier !
def auth():

    creds = None

    if Path("token.json").exists():
        creds = Credentials.from_authorized_user_file("token.json", SCOPES)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())

        else:
            flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)

            creds = flow.run_local_server(port=0)

        Path("token.json").write_text(creds.to_json())

    return creds


def init_db():

    conn = sqlite3.connect(DB)

    conn.execute("""
        CREATE TABLE IF NOT EXISTS mails (
            id TEXT PRIMARY KEY,
            saved INTEGER
        )
    """)

    conn.commit()

    return conn


def already_saved(conn, msg_id):

    cur = conn.execute("SELECT id FROM mails WHERE id=?", (msg_id,))

    return cur.fetchone() is not None


def save_db(conn, msg_id):

    conn.execute("INSERT OR IGNORE INTO mails VALUES (?,1)", (msg_id,))

    conn.commit()


def list_all(service):

    result = []

    token = None

    while True:
        response = service.users().messages().list(userId="me", maxResults=500, pageToken=token).execute()

        result.extend(response.get("messages", []))

        token = response.get("nextPageToken")

        if not token:
            break

    return result


def download_eml(service, msg_id):

    msg = service.users().messages().get(userId="me", id=msg_id, format="raw").execute()

    raw = msg["raw"]

    return base64.urlsafe_b64decode(raw + "=" * (-len(raw) % 4))


def main():

    ARCHIVE.mkdir(exist_ok=True)

    creds = auth()

    gmail = build("gmail", "v1", credentials=creds)

    conn = init_db()

    mails = list_all(gmail)

    print(f"{len(mails)} mails trouvés")

    for i, mail in enumerate(mails, 1):
        msg_id = mail["id"]

        if already_saved(conn, msg_id):
            continue

        print(f"{i}/{len(mails)} {msg_id}")

        data = download_eml(gmail, msg_id)

        filename = ARCHIVE / f"{msg_id}.eml"

        filename.write_bytes(data)

        save_db(conn, msg_id)

    print("Archive terminée")


if __name__ == "__main__":
    main()
