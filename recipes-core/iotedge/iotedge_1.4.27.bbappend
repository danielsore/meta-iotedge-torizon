CARGO_BUILD_FLAGS = "-v --target ${RUST_HOST_SYS} ${BUILD_MODE} --manifest-path=${MANIFEST_PATH}"

do_install () {
    # Binaries
    install -d  "${D}${bindir}"
    install -m 755 "${WORKDIR}/build/target/${TARGET_SYS}-gnu/release/iotedge" ${D}${bindir}/iotedge
}