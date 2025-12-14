# ============================================
# Dockerfile para Java EE WAR + Tomcat + Java 21
# ============================================

# Imagen base con Tomcat + Java 21
FROM tomcat:10.1-jdk21-temurin

# Eliminar apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el WAR generado por Maven
COPY target/LPl_T2_FloresAedoMery-1.0-SNAPSHOT.war \
     /usr/local/tomcat/webapps/ROOT.war

# Exponer puerto
EXPOSE 8080

# Variables de entorno (opcional)
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
