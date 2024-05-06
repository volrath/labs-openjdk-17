set -e

# Find latest jvmci-* tag in current branch.
#JVMCI_VERSION=$(git log --decorate | grep -E 'tag: jvmci-\d+\.\d+-b\d+' | sed 's/.*(\(tag: .*\))/\1/g' | tr ',' '\n' | grep 'tag:' | sed 's/.*tag: \(jvmci-[^,)]*\).*/\1/g' | sort -nr | head -1)
JVMCI_VERSION=jvmci-22.1-b06

# Configure and build
sh configure --with-conf-name=labsjdk \
    --disable-warnings-as-errors \
    --with-version-opt=$JVMCI_VERSION \
    --with-version-pre= \
    '--with-extra-cflags=-Wno-deprecated-non-prototype -Wno-deprecated-declarations -Wno-unused-but-set-parameter -Wno-bitwise-instead-of-logical -Wno-null-pointer-subtraction' \
    '--with-extra-cxxflags=-Wno-bitwise-instead-of-logical -Wno-deprecated-declarations' \
    '--with-vendor-name=GraalVM Community' \
    --with-vendor-url=https://www.graalvm.org/ \
    --with-vendor-bug-url=https://github.com/oracle/graal/issues \
    --with-vendor-vm-bug-url=https://github.com/oracle/graal/issues
make CONF_NAME=labsjdk graal-builder-image

sh xcodebuild.sh
