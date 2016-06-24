pkg_name=znc
pkg_description="A Habitat package of the ZNC IRC bouncer"
pkg_origin=j
pkg_version=1.6.3
pkg_maintainer="Jonathan Hartman <j@hartman.io>"
pkg_license=(Apache-2.0)
pkg_upstream_url=https://github.com/RoboticCheese/znc-habitat

pkg_source=http://znc.in/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=631c46de76fe601a41ef7676bc974958e9a302b72b25fc92b4a603a25d89b827

pkg_deps=(core/glibc
          core/gcc-libs
          core/openssl
          core/zlib
          core/tcl
          core/perl
          core/python)
pkg_build_deps=(core/gcc core/make core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(80)
pkg_svc_run="bin/znc -f -d ${pkg_svc_data_path}"

do_prepare() {
  export CPPFLAGS="$CPPFLAGS $CFLAGS"
  build_line "Setting CPPFLAGS=$CPPFLAGS"

  export PKG_CONFIG_PATH="$(pkg_path_for python)/lib/pkgconfig"
  build_line "Setting PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
}

do_build() {
  ./configure \
    --prefix=${pkg_prefix} \
    --host=x86_64-unknown-linux-gnu \
    --enable-openssl \
    --enable-zlib \
    --enable-perl \
    --enable-python \
    --enable-tcl
    # --enable-cyrus
    # --enable-charset? (icu-uc not found via pkg-config)
  make
}
