FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install () {
    # Binaries
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/build/target/${TARGET_SYS}-gnu/release/aziotd ${D}${bindir}/aziotd
    install -d ${D}${systemd_unitdir}/system

    # Create symbolic links
    ln -s ${bindir}/aziotd ${D}${bindir}/aziot-certd
    ln -s ${bindir}/aziotd ${D}${bindir}/aziot-identityd
    ln -s ${bindir}/aziotd ${D}${bindir}/aziot-keyd
    ln -s ${bindir}/aziotd ${D}${bindir}/aziot-tpmd

    # Install all folders
    install -d ${D}${sysconfdir}/aziot
    install -d -m 700 -o aziotcs -g aziotcs ${D}${sysconfdir}/aziot/certd/config.d
    install -d -m 700 -o aziotid -g aziotid ${D}${sysconfdir}/aziot/identityd/config.d
    install -d -m 700 -o aziotks -g aziotks ${D}${sysconfdir}/aziot/keyd/config.d
    install -d -m 700 -o aziottpm -g aziottpm ${D}${sysconfdir}/aziot/tpmd/config.d

    # Configuration files
    install -m 644 ${WORKDIR}/git/cert/aziot-certd/config/unix/default.toml ${D}${sysconfdir}/aziot/certd/config.toml.default
    install -m 644 ${WORKDIR}/git/identity/aziot-identityd/config/unix/default.toml ${D}${sysconfdir}/aziot/identityd/config.toml.default
    install -m 644 ${WORKDIR}/git/key/aziot-keyd/config/unix/default.toml ${D}${sysconfdir}/aziot/keyd/config.toml.default
    install -m 644 ${WORKDIR}/git/tpm/aziot-tpmd/config/unix/default.toml ${D}${sysconfdir}/aziot/tpmd/config.toml.default
    install -m 644 ${WORKDIR}/git/aziotctl/config/unix/template.toml ${D}${sysconfdir}/aziot/config.toml.template

    # Data dir
    install -d ${D}${sysconfdir}/
    install -d ${D}${sysconfdir}/aziot
    install -d -m 700 -o aziotks -g aziotks ${D}${sysconfdir}/aziot/keyd
    install -d -m 700 -o aziotcs -g aziotcs ${D}${sysconfdir}/aziot/certd
    install -d -m 700 -o aziotid -g aziotid ${D}${sysconfdir}/aziot/identityd
    install -d -m 700 -o aziottpm -g aziottpm ${D}${sysconfdir}/aziot/tpmd


    # Install all required services
    install -m 644 ${WORKDIR}/aziot-certd.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/cert/aziot-certd/aziot-certd.socket ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/aziot-identityd.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/identity/aziot-identityd/aziot-identityd.socket ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/aziot-keyd.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/key/aziot-keyd/aziot-keyd.socket ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/aziot-tpmd.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/git/tpm/aziot-tpmd/aziot-tpmd.socket ${D}${systemd_unitdir}/system
}

USERADD_PARAM:${PN} = "-r -g aziotcs -c 'aziot-certd user' -G aziotks -s /sbin/nologin -d ${sysconfdir}/aziot/certd aziotcs; "
USERADD_PARAM:${PN} += "-r -g aziotks -c 'aziot-keyd user' -s /sbin/nologin -d ${sysconfdir}/aziot/keyd aziotks; "
USERADD_PARAM:${PN} += "-r -g aziotid -c 'aziot-identityd user' -G aziotcs,aziotks,aziottpm -s /sbin/nologin -d ${sysconfdir}/aziot/identityd aziotid; "
USERADD_PARAM:${PN} += "-r -g aziottpm -c 'aziot-tpmd user' -s /sbin/nologin -d ${sysconfdir}/aziot/tpmd aziottpm; "

FILES:${PN} += " \
    ${sysconfdir}/ \
   "