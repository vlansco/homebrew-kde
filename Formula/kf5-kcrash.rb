class Kf5Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kcrash-5.56.0.tar.xz"
  sha256 "581e8215212a584886e8d4b6d5c1aac277590bcb343697d8b3653e1c22f6b1e0"

  revision 1
  head "git://anongit.kde.org/kcrash.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
