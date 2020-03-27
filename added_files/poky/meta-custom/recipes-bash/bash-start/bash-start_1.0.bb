DESCRIPTION = "Simple Python setuptools hello world application"
SECTION = "examples"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://bash-start.sh"

S = "${WORKDIR}"

inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME = "bash-start"

do_install_append () {
    install -d ${D}${INIT_D_DIR}
    install -m 0755 bash-start.sh ${D}${INIT_D_DIR}/bash-start
}
