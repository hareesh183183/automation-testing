# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && \
    apt install -y openjdk-11-jdk maven wget gnupg ca-certificates curl xvfb unzip libegl1-mesa libgl1-mesa-glx libpci3

# Install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Create dconf cache directory with correct permissions 
RUN mkdir -p /.cache/dconf && \ 
chmod 2777 /.cache/dconf

# Install Firefox
ARG FIREFOX_VERSION=105.0
ARG GECKODRIVER_VERSION=v0.31.0

RUN apt-get update -qqy && apt-get -qqy install bzip2 libgtk-3-0 libx11-xcb1 libdbus-glib-1-2 libxt6 libasound2 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* && wget -q -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 && tar xjf /tmp/firefox.tar.bz2 -C /opt && rm /tmp/firefox.tar.bz2 && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION && ln -s /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox
RUN wget -q -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && tar xzf /tmp/geckodriver.tar.gz -C /opt && rm /tmp/geckodriver.tar.gz && mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION && ln -s /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver # buildkit

# Set Chrome as the default browser
RUN update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/google-chrome-stable 200 && \
    update-alternatives --set x-www-browser /usr/bin/google-chrome-stable && \
    update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/google-chrome-stable 200 && \
    update-alternatives --set gnome-www-browser /usr/bin/google-chrome-stable

# Set Firefox as the default browser for user applications
RUN mkdir -p /usr/lib/firefox-defaults/ && \
    echo "/usr/bin/firefox" > /usr/lib/firefox-defaults/recommended
    #ln -s /usr/lib/firefox-defaults/recommended /etc/firefox/

# Download Microsoft Edge package 
RUN wget -O /tmp/msedge.deb https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_114.0.1823.51-1_amd64.deb
# Install Microsoft Edge 
RUN dpkg -i /tmp/msedge.deb && \ 
    apt install -f -y 
# Download Microsoft Edge Driver 
RUN wget -O /tmp/msedgedriver.zip https://msedgewebdriverstorage.blob.core.windows.net/edgewebdriver/114.0.1823.51/edgedriver_linux64.zip
# Install Microsoft Edge Driver 
RUN unzip /tmp/msedgedriver.zip -d /usr/bin
RUN chmod +x /usr/bin/msedgedriver 
# Clean up temporary files 
RUN rm -f /tmp/msedge.deb /tmp/msedgedriver.zip

# Create the /.pki/nssdb directory 
RUN mkdir -p /.pki/nssdb # Set the permissions for the directory RUN chmod 777 /.pki/nssdb

# Set the DISPLAY environment variable (required for GUI applications to work)
ENV DISPLAY=:99
RUN Xvfb :99 -screen 0 1280x1024x24 &

# Set the DISPLAY environment variable 
ENV DISPLAY=:99

# Set the default command to run the application
# Entry point
CMD ["mvn", "install", "test"]
