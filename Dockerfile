FROM amazon/aws-lambda-python:3.8

# Install required system dependencies
RUN yum install -y mesa-libGLw
RUN export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Create a virtual environment and set it as the working directory

# RUN python3 -m venv venv
# ENV PATH="/app/venv/bin:$PATH"

# Copy the requirements file and install dependencies
COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN --mount=type=cache,target=/root/.cache pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Copy the Python script files
COPY application.py ${LAMBDA_TASK_ROOT}
COPY init_models.py ${LAMBDA_TASK_ROOT}
COPY MicrosoftTeams-image.png ${LAMBDA_TASK_ROOT}

# Comment out the model download step
RUN python3 init_models.py

# Manually copy the model file to the expected location
# COPY pose_landmark_heavy.tflite /app/venv/lib/python3.8/site-packages/mediapipe/modules/pose_landmark/

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["application.handler"]

# FROM amazon/aws-lambda-python:3.8

# RUN yum install -y mesa-libGLw

# COPY requirements.txt ./
# RUN pip3 install -r requirements.txt --target "/var/task"

# # Copy function code`
# COPY application.py ./

# # Copy init_models.py
# COPY init_models.py ./

# # Download models
# RUN python init_models.py

# # Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
# CMD ["application.handler"]
