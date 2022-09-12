# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=llvm-libs
_realpkgname=llvm-project
pkgver=15.0.0
_binutilsver=2.39
pkgrel=1
pkgdesc='LLVM runtime libraries for c++ and more.'
arch=('x86_64')
url='htps://llvm.org'
license=('custom:Apache 2.0 with LLVM Exception')
depends=(musl llvm-libs)
makedepends=(
    llvm
    cmake
    ninja
    git
)
options=()

source=(
    "https://github.com/llvm/llvm-project/releases/download/llvmorg-${pkgver}/llvm-project-${pkgver}.src.tar.xz"
)

sha256sums=(
    'SKIP'
)

FLIST_llvm_libs=(
    "usr/lib/libc++.so*"
    "usr/lib/libc++abi.so*"
    "usr/lib/libc++.a"
    "usr/lib/libc++abi.a"
    "usr/lib/libc++experimental.a"
    "usr/lib/libunwind.so.*"
    "usr/lib/libunwind.so"
    "usr/lib/libunwind.a"
    "usr/include/*cxxabi*"
    "usr/include/c++"
    "usr/include/*unwind*"
)

_fetchpkg() {
    PKGBASE="$srcdir/pkgs/$1" && shift
    mkdir -p $PKGBASE
    for FILEPATH in $@; do
        (cd "${srcdir}/PKGDIR" && find $FILEPATH | cpio -pdvmu $PKGBASE) || true
        (cd "${srcdir}/PKGDIR" && find $FILEPATH -delete) || true
    done
}

build() {
    cd $_realpkgname-$pkgver.src
    sed -i \
        -e 's@strtoull_l@strtoull@g' \
        -e '/strtoull/s@, _LIBCPP_GET_C_LOCALE@@' \
        -e 's@strtoll_l@strtoll@g' \
        -e '/strtoll/s@, _LIBCPP_GET_C_LOCALE@@' \
        libcxx/include/locale
    sed -i "/dlfcn.h/s@\$@\n#include <sys/types.h>@" \
        compiler-rt/lib/fuzzer/FuzzerInterceptors.cpp
    install -d ../build
    cd ../build || return 1

    # https://os-wiki.ewe.moe/llvm
    export CMARGS=(
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=/usr
        -DLLVM_DEFAULT_TARGET_TRIPLE="$CHOST"
        -DLLVM_HOST_TRIPLE="$CHOST"
        -DCLANG_DEFAULT_CXX_STDLIB='libc++'
        -DCLANG_DEFAULT_RTLIB='compiler-rt'
        -DLLVM_INSTALL_UTILS=ON
        -DLLVM_ENABLE_LIBCXX=ON
        -DLLVM_ENABLE_FFI=ON
        -DLLVM_INSTALL_BINUTILS_SYMLINKS=ON
        -DLLVM_BUILD_LLVM_DYLIB=ON
        -DLLVM_LINK_LLVM_DYLIB=ON
        -DLLVM_INCLUDE_BENCHMARKS=OFF
        -DLLVM_TARGETS_TO_BUILD=Native
        -DLIBCXX_HAS_MUSL_LIBC=ON
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXX_INCLUDE_TESTS=OFF
        -DLIBCXX_INCLUDE_BENCHMARKS=OFF
        -DLIBCXXABI_USE_LLVM_UNWINDER=ON
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBUNWIND_USE_COMPILER_RT=ON
        -DCOMPILER_RT_BUILD_SANITIZERS=OFF
        -DCOMPILER_RT_BUILD_XRAY=OFF
        -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
        -DLLVM_LIBGCC_EXPLICIT_OPT_IN=ON
    )

    cmake "${CMARGS[@]}" \
        -DLLVM_ENABLE_RUNTIMES="libunwind;libcxxabi;libcxx" \
        ../$_realpkgname-$pkgver.src/runtimes
    cmake --build . --target cxx cxxabi unwind
    export DESTDIR="${srcdir}/PKGDIR"
    cmake --build . --target install-cxx install-cxxabi install-unwind

    _fetchpkg llvm-libs "${FLIST_llvm_libs[@]}"
}

package() {
    mv "$srcdir/pkgs/llvm-libs/usr" "${pkgdir}/usr"
    install $srcdir/$_realpkgname-$pkgver.src/libunwind/include/libunwind.h \
	${pkgdir}/usr/include/
    install $srcdir/$_realpkgname-$pkgver.src/libunwind/include/unwind.h \
	${pkgdir}/usr/include/
    install $srcdir/$_realpkgname-$pkgver.src/libunwind/include/__libunwind_config.h \
	${pkgdir}/usr/include/
    find ${pkgdir}/usr/lib -name *.a -delete || true
}
