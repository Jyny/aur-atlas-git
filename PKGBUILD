# Maintainer: Jerry Y. Chen <chen@jyny.dev>

pkgname=atlas-git
pkgdesc="A modern tool for managing database schemas"
pkgver=0.26.0
pkgrel=1
binary=atlas
arch=("x86_64")
makedepends=("go")

license=("Apache-2.0")
provides=('atlas')
conflicts=('atlas')
url="https://github.com/ariga/${binary}"
source=(
  "${binary}-${pkgver}.tar.gz::https://github.com/ariga/${binary}/archive/v${pkgver}.tar.gz"
)

sha256sums=('00790c217a0b09a2bd857f3d277b289707c85cda7a73f88efbe794e697344fbd')
b2sums=('1308838cfc46005bd88fe1bf4e8c433e2ef3b0d4e93280e3f99a3501f2f946b7a6c3f02582b3ad57e6358320250e589e8e30ebbbc56350c5f7791f13d5b39d6a')

prepare() {
  cd "${srcdir}/${binary}-${pkgver}"
}

build() {
  export GOPATH="${srcdir}/.go"
  export CGO_CFLAGS="${CFLAGS}"
  export CGO_CPPFLAGS="${CPPFLAGS}"
  export CGO_CXXFLAGS="${CXXFLAGS}"
  export CGO_LDFLAGS="${LDFLAGS}"
  export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw -x -v"

  cd "${srcdir}/${binary}-${pkgver}/cmd/${binary}"
  go build -ldflags "-X 'ariga.io/atlas/cmd/atlas/internal/cmdapi.version=v${pkgver}'" .

  go clean -x -modcache
}

package() {
  install -Dm755 "${srcdir}/${binary}-${pkgver}/cmd/${binary}/${binary}" "${pkgdir}/usr/bin/${binary}"
}