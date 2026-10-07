# base Docker image that we will build on
FROM python:3.13.11-slim

# set up our image by installing prerequisites; pandas in this case
# RUN pip install pandas pyarrow

# Copy uv binary from official uv image (multi-stage build pattern)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

# set up the working directory inside the container
WORKDIR /code

# Add virtual environment to PATH so we can use installed packages
ENV PATH="/code/.venv/bin:$PATH"

# Copy dependency files first (better layer caching)
COPY pyproject.toml uv.lock .python-version ./

# copy the script to the container. 1st name is source file, 2nd is destination
# COPY pipeline.py pipeline.py

# Install dependencies first so application changes do not invalidate this layer.
RUN uv sync --locked --no-install-project

# define what to do first when the container runs
# in this example, we will just run the script
# ENTRYPOINT ["python", "pipeline.py"]

# Copy application code
COPY ingest_data.py .
COPY README.md .
COPY src/ ./src/

# Install the project after its source is available.
RUN uv sync --locked

# Set entry point
ENTRYPOINT ["uv", "run", "python", "ingest_data.py"]