do_install () {
    # Binaries
    install -d  "${D}${bindir}"
    install -m 755 "${WORKDIR}/build/target/${TARGET_SYS}-gnu/release/aziotctl" ${D}${bindir}/aziotctl
}