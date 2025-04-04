# Cloud Companion – Your Friendly Guide to the Cloud

## Development setup

### Backend setup

1. Clone the repo into a public GitHub repository

   ```sh
   git clone https://github.com/dm669230/cloud-companion.git
   ```

2. Go to the project folder

   ```sh
   cd cloud-companion
   ```

3. Create virtual environment

   ```sh
   python -m venv venv
   ```

4. Activate the virtual environment

   Windows:

   ```sh
   venv\Scripts\activate
   ```

   Linux:

   ```sh
   source venv/bin/activate
   ```

5. Install requiremnts

   ```sh
   pip install -r requirements.txt
   ```

6. Set up your `.env` file

   ```sh
   cp .env.example .env
   ```

7. Create required directories and file

   ```sh
   mkdir logs
   mkdir logs/application.log
   mkdir logs/application-error.log
   ```

### Start the development server

    uvicorn app.main:app --host localhost --port 8000 --reload
