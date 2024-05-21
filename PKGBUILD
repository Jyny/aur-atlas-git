# Maintainer: Jerry Y. Chen <chen@jyny.dev>

pkgname=atlas-git
pkgdesc="A modern tool for managing database schemas"
pkgver=0.23.0
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

sha256sums=('2b3a984fe7687f319b203c0a95ded8f54e060aa958e6bee4609d13b239c0dbc3')
b2sums=('d84d44bcd195ce99e6d700dafac6e8da933707d02fbb957b04f79ef7dd588bb1fcdb44e3d93e792d63cdf86a592f9307c19753e9ae800e981b42d27017e19891')

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