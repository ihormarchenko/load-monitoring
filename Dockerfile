FROM fluent/fluentd:stable-debian
ADD ./conf /fluentd/etc
RUN ["gem", "install", "fluent-plugin-kinesis"]
RUN ["gem", "install", "fluent-plugin-rewrite"]
RUN ["gem", "install", "fluent-plugin-record-modifier"]

ENV JMETER_LOG_STREAM "jmeter-logs"
ENV GATLING_LOG_STREAM "gatling-logs"
ENV READ_LINES_LIMIT "5000"
ENV ROTATE_WAIT "1"
ENV TEST_ENV ""