FROM java:8  
COPY . /
WORKDIR /  
RUN javac helloworld.java  
CMD ["java", "-classpath", "mysql-connector-java-5.1.6.jar:.", "helloworld"]  
