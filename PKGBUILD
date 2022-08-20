# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=zlib
pkgver=1.2.12
pkgrel=1
pkgdesc='A Massively Spiffy Yet Delicately Unobtrusive Compression Library'
arch=('x86_64')
license=('custom')
url="https://www.zlib.net/"
depends=(musl)
options=()
source=("https://zlib.net/zlib-${pkgver}.tar.gz")
sha256sums=('SKIP')

prepare() {
	cd "${srcdir}/zlib-$pkgver"
	grep -A 24 '^  Copyright' zlib.h > LICENSE
}

build() {
	cd "${srcdir}/zlib-$pkgver"
        LDSHARED="cc -shared -Wl,-soname,libz.so.1,--version-script,zlib.map" \
	    ./configure --prefix=/usr
	make
}

check() {
	cd "${srcdir}/zlib-$pkgver"
	make test
}

package_zlib() {
	cd "${srcdir}/zlib-$pkgver"
	make install DESTDIR="${pkgdir}"
	install -D -m644 LICENSE "${pkgdir}/usr/share/licenses/zlib/LICENSE"
}
