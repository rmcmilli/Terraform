FROM sflow/sflow-rt:latest
USER root
# RUN chown -R sflowrt:sflowrt /home/sflowrt/store
RUN /sflow-rt/get-app.sh sflow-rt prometheus
RUN /sflow-rt/get-app.sh sflow-rt vizceral
RUN /sflow-rt/get-app.sh sflow-rt topology
RUN /sflow-rt/get-app.sh sflow-rt svg-weather
RUN /sflow-rt/get-app.sh sflow-rt particle
RUN /sflow-rt/get-app.sh sflow-rt mininet-dashboard
RUN /sflow-rt/get-app.sh sflow-rt fabric-metrics
RUN /sflow-rt/get-app.sh sflow-rt fabric-view
RUN /sflow-rt/get-app.sh sflow-rt browse-flows
RUN /sflow-rt/get-app.sh sflow-rt sflow-test
ENTRYPOINT ./start.sh