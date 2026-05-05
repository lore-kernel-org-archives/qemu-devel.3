Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC3CFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKD9Q-0001Nd-Oz; Tue, 05 May 2026 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD9A-0001Ki-R9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD95-0007x6-GL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so65788965e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977414; x=1778582214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbF8A1Ujf51MtJ+wzlrq2naggs0k6C0Otrfh2/imI5o=;
 b=DbmLtSwZgmHczc+a0vFLxFDLJj9HfBrjTEW6VmDfzUyUtfwSGtZ/KOutM83h3AmJpB
 KCDIU0voL5InzP2vcXuJInTEoN7kauDtoGdtqClnsU5DjJDnQNMCyjNnJIvSVC8zZU4F
 BF9jh0M9CkSsG9QI5qcSYoMbe68Wgqh2lx/ZM9J+fLyAdLZlcgju4Vl1iqsnbr6j5Sz0
 NIQJlugog/1EWirhJvLuaPuDuYGEyqFEBhvO2e8PAGuqsMmyYVfpIdbRq9yug3dh4VcL
 Z5m4BrLQGUtalhW+1FgXkyTFR/7WYwRT5m2y+5q6JEfqPRrMzNxoCsv9h2dljYtNzQVY
 wytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977414; x=1778582214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbF8A1Ujf51MtJ+wzlrq2naggs0k6C0Otrfh2/imI5o=;
 b=TDwGPbXAWGnCBkA7vwzGqR9A0EnzAe4VZROi9OT4PiXR8FsZXvqzUb28uq/Roh/SVg
 cQYGY30hzr9PWsKWC/qFOSxJVNkIV2gziK52AlBzostC/hb7aU6PBGeAxmiHx4dsV61O
 LR1xv4YERx66NAl8iVElZXuLE0ZEMGbZ6jBtev6gTf+mW6s0PV5f6I9fvGEFvIiIdO3l
 RKcFTIBqVJ+FtzYgDQIJKwsRNu7Py/hrgDii5tm8F2D0lMAp1jK3hnXza9iGWtXDfNzd
 010d5a3RD6zt4bv3RwZZpbT1CNjaeHk2mqiHp26DAl6Kf32bDdSeAF3L0v37woX2XvRU
 WbQQ==
X-Gm-Message-State: AOJu0Yz8hlog5qNauqX5SHsJTxZ/KdM5jj6RgOVd3aeIKtg9sUze70ab
 BgSDowTXCm1Cwz3h4+LI+D62NKZ+C5j73j80965k4vLmpsPtCRRyKpKZ4+NuHeTAu9A=
X-Gm-Gg: AeBDievUuVhCzpbHKG9mPi0Lnh7sraPENLhm5eH614P1T2s1uTP+dlj7tKrgR+9BTOg
 Kl3qvnWSeNnPPa9Wp+w7J86hFZtgRZnE1gAHnfkaeefaBzb7BKo3GNkeasY4+4yRL3YT3VuR0Gp
 nAhqEpaDzdSK3a3HqPHMKTzLwUFILbQCff5ahc/00/B+Et8EmWy4zbEOE4TWphorMq0z7REUKIM
 n+Nkg/no5CWX1t/KHHCKmfHABYlawRaqaoTV5h88qAk4PUNlzqOkiAqDG7KEHSUPV+WsbU68EWg
 GtbJZXnBSu6BxlXxa5+jBXkBWaBUZ23OHTbH6sGypq5objeQXQbAqOs+0nnxbRXfpMDwo6j893w
 xFdl4pjNY2qSsuWvhH3ztY1ovXzf/R9lj+2jVcI878TxGsD4Sonk21uFGeOXbJzKkl5/i8p1s5m
 r3MdpcwM7Sq8Ee+kAozHzsckw4WyIoPBAYxQ==
X-Received: by 2002:a05:600c:1e8b:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48a98676d48mr219377445e9.26.1777977414001; 
 Tue, 05 May 2026 03:36:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48af0d5a613sm141108645e9.2.2026.05.05.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:36:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C40E5FA53;
 Tue, 05 May 2026 11:36:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] gitlab: add initial MacOS 15 on gitlab runner
Date: Tue,  5 May 2026 11:36:48 +0100
Message-ID: <20260505103649.68361-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505103649.68361-1-alex.bennee@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos-14.vars    | 16 ++++++++++++
 .gitlab-ci.d/macos.yml        | 49 +++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/qemu-project.yml |  1 +
 tests/lcitool/refresh         | 11 ++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 .gitlab-ci.d/macos-14.vars
 create mode 100644 .gitlab-ci.d/macos.yml

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
index 00000000000..edb500e937b
--- /dev/null
+++ b/.gitlab-ci.d/macos.yml
@@ -0,0 +1,49 @@
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
+    - python3 ./scripts/probe-gdb-support.py $(which gdb)
+    - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
+  script:
+    - mkdir build
+    - cd build
+    - env
+    - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
+    - $MAKE -j$(sysctl -n hw.ncpu)
+    - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
+
+aarch64-macos-15-build:
+  extends: .macos_job_template
+  image: macos-15-xcode-16
+  variables:
+    NAME: macos-15
+    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    CONFIGURE_ARGS:
+        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-i386=i686-elf-
+        --cross-prefix-x86_64=x86_64-elf-
+        --disable-plugins
+    TEST_TARGETS: check-unit check-tcg
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 4d914c4897b..9cbb5fe787f 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -19,3 +19,4 @@ include:
   - local: '/.gitlab-ci.d/custom-runners.yml'
   - local: '/.gitlab-ci.d/cirrus.yml'
   - local: '/.gitlab-ci.d/windows.yml'
+  - local: '/.gitlab-ci.d/macos.yml'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fa4a16e3583..4289cc381a6 100755
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
@@ -312,6 +318,11 @@ try:
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
-- 
2.47.3


