class Kf5Kactivities < Formula
  desc "Core components for the KDE's Activities"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kactivities-5.56.0.tar.xz"
  sha256 "e76a4d44ca6e7ce2273d8c3b133fdd12e32367aeffd66098ec46e7b28c491750"

  revision 1
  head "git://anongit.kde.org/kactivities.git"

  depends_on "boost" => :build

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"

  patch :DATA

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

__END__
diff --git a/src/cli/CMakeLists.txt b/src/cli/CMakeLists.txt
index d0e13be..479031b 100644
--- a/src/cli/CMakeLists.txt
+++ b/src/cli/CMakeLists.txt
@@ -30,6 +30,10 @@ target_link_libraries (
    KF5::Activities
    )
 
+ecm_mark_nongui_executable(
+   kactivities-cli
+   )
+
 install (TARGETS
    kactivities-cli
    ${KF5_INSTALL_TARGETS_DEFAULT_ARGS}
