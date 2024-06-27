CARGO_BUILD_FLAGS = "-v --target ${RUST_HOST_SYS} ${BUILD_MODE} --manifest-path=${MANIFEST_PATH}"

do_install () {
    # Binaries
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/build/target/${TARGET_SYS}-gnu/release/aziot-edged ${D}${bindir}/aziot-edged

    # Create symbolic links
    install -d ${D}${libexecdir}/aziot
    ln -s ${bindir}/aziot-edged ${D}${libexecdir}/aziot/aziot-edged

    # Config file
    install -d ${D}${sysconfdir}/aziot
    install -d ${D}${sysconfdir}/aziot/edged
    install -d -m 700 -o iotedge -g iotedge ${D}${sysconfdir}/aziot/edged/config.d

    # Data dir
    install -d ${D}${sysconfdir}/
    install -d ${D}${sysconfdir}/aziot
    install -d -m 755 -o iotedge -g iotedge ${D}${sysconfdir}/aziot/edged

    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/aziot-edged.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/edgelet/contrib/systemd/debian/aziot-edged.workload.socket ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/edgelet/contrib/systemd/debian/aziot-edged.mgmt.socket ${D}${systemd_unitdir}/system

    #Creates /var/run/iotedge as 755, iotedge:iotedge via systemd-tmpfiles.setup.service
    install -d ${D}${sysconfdir}/tmpfiles.d
    install -m 644 ${WORKDIR}/iotedge.conf ${D}${sysconfdir}/tmpfiles.d/iotedge.conf
}

USERADD_PARAM:${PN} = "-r -g iotedge -c 'iotedge user' -G docker,systemd-journal,aziotcs,aziotks,aziottpm,aziotid -s /sbin/nologin -d ${sysconfdir}/lib/aziot/edged iotedge; "
USERADD_PARAM:${PN} += "-r -g iotedge -c 'edgeAgent user' -s /bin/sh -u 356 edgeagentuser; "
USERADD_PARAM:${PN} += "-r -g iotedge -c 'edgeHub user' -s /bin/sh -u 357 edgehubuser; "

FILES:${PN} += " \
    ${sysconfdir}/ \
    ${sysconfdir}/aziot/ \
    "