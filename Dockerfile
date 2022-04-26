# specify the node base image with your desired version node:<version>
FROM node
# Define the Work Directory including all the node.js stuff we need
#
# WORKDIR $Home/work/
#
# we copy our current directory (from which the build command is executed) into the newly defined
# work Directory
COPY . ./
#
#
# This is the command which will be executed when the image is deployed in the container
RUN npm install
EXPOSE 4000
CMD ["node","mainapp.js"]
