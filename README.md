This README file contains information on the contents of the meta-iotedge-torizon layer. This layer is not official or supported by Toradex and was developed only as a proof of concept.

This layer is intended to be used alongside meta-iotedge and meta-toradex-torizon. In order to use this layer is necessary to change the DISTRO to *torizon-iotedge* or *torizon-iotedge-upstream*.

This layer became necessary because of the incompatibility between Rust toolchain backported on Torizon layer and the original iotedge layer from Microsoft, and it was required to move all IoT Edge user home directoies files from */var/lib* to */etc* since OSTree touches the */var/lib* directory. 

This layer makes the necessary changes to integrate Azure IoT Edge into Torizon OS 6 images.

Dependencies
============

  URI: https://github.com/toradex/meta-toradex-torizon
  branch: kirkstone-6.x.y

  URI: https://github.com/Azure/meta-iotedge.git
  branch: main

  URI: https://git.yoctoproject.org/git/meta-security
  branch: kirkstone

Patches
=======

Please submit any patches against the meta-iotedge-torizon layer in this github.

Maintainer: @danielsore
Maintainer: @griloHBG

Table of Contents
=================

  To be done

I. Adding the meta-iotedge-torizon layer to your build
=================================================

Run 'bitbake-layers add-layer meta-iotedge-torizon'