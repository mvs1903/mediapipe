# FROM public.ecr.aws/lambda/python:3.8

# RUN yum install -y mesa-libGLw

# COPY requirements.txt  .
# RUN  pip3 install -r requirements.txt --target "application.py"

# # # https://github.com/mitchellharper12/lambda-pthread-nameshim
# # COPY --from=Makefile /lambda-pthread-nameshim/pthread_shim.c

# # Copy function code
# COPY application.py ./

# # Download models
# RUN python init_models.py

# # Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
# CMD [ "application.handler" ] 

FROM public.ecr.aws/lambda/python:3.8

RUN yum install -y mesa-libGLw

COPY requirements.txt ./
RUN pip3 install -r requirements.txt --target "/var/task"

# Copy function code
COPY application.py ./

# Copy init_models.py
COPY init_models.py ./

# Download models
RUN python init_models.py

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["application.handler"]
