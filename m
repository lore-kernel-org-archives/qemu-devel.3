Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ3-0002gW-E5; Tue, 26 May 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-0002Za-MN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-000667-6T
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5267588f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793370; x=1780398170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAUcD8Vr/ldRAA0L5XKtFP/XYzSRgSobF/KmT3GxMWI=;
 b=dMvsjCg/o1XXlQiDkNrobSsUANx/6zlLGA4wtghPkbNlfpYibadzT46AlA/A+ZpPU7
 ewyp46KcvMP6B5SjoWwKj5fuij64Hoik90z43itwEo03dm/bKzhQLsczEYqhtfZ0zVkO
 TtQgB5F/db+RZKtNbHGSyfmmZHxw3Ld5UDxnNSsuJVQ1BHx9DRxnU1d6uaZBWaDGE5ob
 E4vBCuYTm4qv7C4gWpd8kHHQNHkAgPwmM4PhVwAO2CFJo+Zx/6M1qkeNtBFwRp0Owd6n
 lLWPz/+YMX1f/LYLiVgkqm3BmFDPcIBV9S2pnjFaKsSfC4ArjdRidV2+k3XqGoYmWLhO
 swmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793370; x=1780398170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAUcD8Vr/ldRAA0L5XKtFP/XYzSRgSobF/KmT3GxMWI=;
 b=p3bnxatiVWbhqmMFf0reLVtloFI2YCUNDwlsrE9OIs8KswvCAij7U86H6BcJYni85x
 Lse98/yziqovJi1E2vklqLeRMEvhiG7oKZDkd6Fc25tJMlwgE7EY/G3AU34aQuO4tnXR
 K71bHgxSj2TvJkqFupmu6I7D/7oO0sXD8F4u7vn8oK14QhaA0EnGMt2OyrFYRYDe9QOU
 0/pdTI4h5BOf0V97Mq0p3gxRgnONrUoGcWTA6BRfJnNNMDKNAjsO5CH8btzEpA+3bv0s
 678rUEWktEcZqYPyr7cQKyb/teouE2t+CujW7YTeA7iGDNgrF5W4vKX3TrBYy5VyRm5Y
 HvYg==
X-Gm-Message-State: AOJu0YzZKo6mUXVbZ2WOdXIGokDNz3Ax1J2ppZijHLfhtUeIaGHq30E6
 tck2FrgKrlbMmKzarXzgjesI/CGGzP1Y55ZWiMoQh8AMeXp83qWtaQbz+nm7vIH8trI=
X-Gm-Gg: Acq92OGmCttmhELdinMJcIaKtx1GnI8QGF3PX71MhNuzf5LeV3vIkEKdDTCAZsyjbi5
 km++eNLKvcGT4qpvfucqQ5Z92SBrgSGBxXiswb2gRuH21sxFBo/ldrq6XVh59IE5GacXp5G9L6b
 2VHB1Bki3jWzztNAZEWpjcwFds2X/VvAHtCOs1GF6i8s/6rauVaJxppSqHJ0KPyJIrIzBGKoAkq
 jjq2GLUW1u591SuVK5VqBjSbW8oRzL6Rj8fEuQ4RwaethjxOoIgz8SBlOLoBNRCBWrvpKZZ88dp
 7jUA17NYNWNYsA07LKMeoFVCA/I+x+cnWGi1UaJ/uCULtzzqkwAvkQO8QHGLIh+ZXSY4ssC29P9
 3l+Q4GvKVPoCu3uXG665cgtnibJEQYeiYZMoMO/FEZBlSrEMsTOnD2BDBI6z99xPFXJYF/L55u1
 s5Xcd3ds79FHjMYlof1qA6joA=
X-Received: by 2002:a5d:456a:0:b0:45e:8547:f21e with SMTP id
 ffacd0b85a97d-45eb38bf97dmr19821962f8f.36.1779793370243; 
 Tue, 26 May 2026 04:02:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4903bsm32113651f8f.21.2026.05.26.04.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C8F060399;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 06/14] gitlab: add initial MacOS 15 on gitlab runner
Date: Tue, 26 May 2026 12:02:34 +0100
Message-ID: <20260526110243.470002-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The gitlab runners are currently in beta but available to projects on
the Premium and Ultimate plans (which QEMU is via the Open Source
program).

We install some compilers via brew so we can run some of the check-tcg
softmmu test cases.

We disable rust as the version is too old.

We disable plugins because we haven't taught the test harness about
.dynlib vs .so yet.

There is a discrepancy between the vars and version of MacOS because
lcitool needs teaching about other versions (although I don't think it
matters as brew is shared across versions).

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - call tcg run directly to work around makefile issues
  - drop debug lines
---
 tests/lcitool/refresh         | 11 ++++++++
 .gitlab-ci.d/macos-14.vars    | 16 ++++++++++++
 .gitlab-ci.d/macos.yml        | 47 +++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/qemu-project.yml |  1 +
 4 files changed, 75 insertions(+)
 create mode 100644 .gitlab-ci.d/macos-14.vars
 create mode 100644 .gitlab-ci.d/macos.yml

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 4be6a9261ee..96ee861cbf7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -87,6 +87,12 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
+def generate_vars(target, trailer=None):
+    filename = Path(src_dir, ".gitlab-ci.d", target + ".vars")
+    cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
+    generate(filename, cmd, trailer)
+
+
 def generate_pkglist(vm, target, project="qemu"):
     filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
     cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
@@ -302,6 +308,11 @@ try:
     #
     generate_cirrus("freebsd-14")
 
+    #
+    # GitLab packages lists
+    #
+    generate_vars("macos-14")
+
     #
     # VM packages lists
     #
diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
new file mode 100644
index 00000000000..def77cfdea5
--- /dev/null
+++ b/.gitlab-ci.d/macos-14.vars
@@ -0,0 +1,16 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables macos-14 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+CCACHE='/opt/homebrew/bin/ccache'
+CPAN_PKGS=''
+CROSS_PKGS=''
+MAKE='/opt/homebrew/bin/gmake'
+NINJA='/opt/homebrew/bin/ninja'
+PACKAGING_COMMAND='brew'
+PIP3='/opt/homebrew/bin/pip3'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
+PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
+PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
new file mode 100644
index 00000000000..c93bf12a294
--- /dev/null
+++ b/.gitlab-ci.d/macos.yml
@@ -0,0 +1,47 @@
+.macos_job_template:
+  extends: .base_job_template
+  stage: build
+  tags:
+    - saas-macos-large-m2pro
+  needs: []
+  timeout: 80m
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    expire_in: 7 days
+    paths:
+      - build/meson-logs/
+      - build/tests/tcg/
+    reports:
+      junit: build/meson-logs/*.junit.xml
+    when: always
+  before_script:
+    - set -o allexport
+    - source .gitlab-ci.d/macos-14.vars
+    - set +o allexport
+    - export PATH="$PATH_EXTRA:$PATH"
+    - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
+    - brew update
+    - brew install $PKGS
+    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
+  script:
+    - mkdir build
+    - cd build
+    - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
+    - $MAKE -j$(sysctl -n hw.ncpu)
+    - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
+
+aarch64-macos-15-build:
+  extends: .macos_job_template
+  image: macos-15-xcode-16
+  variables:
+    NAME: macos-15
+    PATH_EXTRA: /opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    CONFIGURE_ARGS:
+        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-i386=i686-elf-
+        --cross-prefix-x86_64=x86_64-elf-
+        --disable-plugins
+    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 4d914c4897b..9cbb5fe787f 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -19,3 +19,4 @@ include:
   - local: '/.gitlab-ci.d/custom-runners.yml'
   - local: '/.gitlab-ci.d/cirrus.yml'
   - local: '/.gitlab-ci.d/windows.yml'
+  - local: '/.gitlab-ci.d/macos.yml'
-- 
2.47.3


