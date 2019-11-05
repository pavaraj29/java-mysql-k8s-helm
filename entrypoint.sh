#!/bin/bash
java -classpath mysql-connector-java-5.1.48.jar:. helloworld
tail -f /dev/null
