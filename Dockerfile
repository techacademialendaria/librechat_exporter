FROM python:3.14-slim

# Set the working directory
WORKDIR /app

# Install dependencies first so code changes reuse the cached layer.
# Plain COPY instead of RUN --mount=type=bind: Railway's builder only
# supports cache mounts.
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt

COPY LICENSE metrics.py /app/

# Expose the Prometheus port
EXPOSE 8000

# Command to run the script
CMD ["python", "metrics.py"]
