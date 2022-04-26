# specify the node base image with your desired version node:<version>
FROM node:12.18.1
# Define the Work Directory including all the node.js stuff we need
ENV NODE_ENV=production

#
WORKDIR $Home/work/cloud-project
#
# we copy our current directory (from which the build command is executed) into the newly defined
# work Directory
COPY ["package.json", "package-lock.json*", "./"]
#
#
# This is the command which will be executed when the image is deployed in the container
RUN npm install --production

COPY . .
EXPOSE 4000
CMD ["node","mainapp.js"]

