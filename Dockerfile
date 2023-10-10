#dockerfile
FROM pytorch/torchserve            
USER root
RUN chmod 777 -R .
COPY requirements.txt .            
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
#copy the .mar file created in previous step
COPY semantic_search.mar model-store/
#replace the existing config.properties with custom one
COPY config.properties config.properties

#start the server with model named search
CMD ["torchserve", "--start" ,"--model-store", "model-store" ,"--models" ,"search=semantic_search.mar"]

# RUN ./create-mar.sh