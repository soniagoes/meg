# 1. Use an official Python runtime as a parent image
# Using -slim can reduce the image size significantly.
FROM python:3.11-slim

# 2. Set the working directory in the container
WORKDIR /app

# 3. Copy the dependencies file first to leverage Docker's layer caching.
# This step will only be re-run if requirements.txt changes.
COPY requirements.txt ./

# 4. Install any needed packages specified in requirements.txt.
# --no-cache-dir reduces the image size by not storing the pip cache.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application's code into the container.
COPY . .

# 6. Make port 8000 available to the world outside this container.
EXPOSE 8000

# 7. Run app.py when the container launches.
# Use 0.0.0.0 to make it accessible from outside the container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", --reload]
