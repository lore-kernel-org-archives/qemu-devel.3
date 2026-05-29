Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A42CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxB-00022e-6M; Fri, 29 May 2026 01:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwe-0001qw-0I
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwb-00025M-MY
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so89613115e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033180; x=1780637980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxWg4868hUFys70o/3FFM0O1JMxBcqCuDhTDREtBU3U=;
 b=SbNK52+btpDxQT59Cl7U6GuTffj+3omB4yS+LSOhJu5k2YZAes2cCjiPUuhexzcQVq
 prX/SaZvStK/F8rYJ0i3yxYrW8kM3eJWx2oYc7P+yzbAJ0VrMCWbEO1Z/9hXU1hd8LZx
 MVtFSRW8MPiZljcacbMtHElUiQczxsQRkGxViJSVnBdBZM8c7dIMSHz+7bFwxNYB7dP0
 zPUmSJA4FIKzp7yOu5aQH73BU+6zb4Z9XWTM3pkEsfu+trd4iOxiBZvegngcQCqDbvGm
 zThXz6aF7Ea1yJ92TAf+Rmq8O1mdrvBeOA5u2bsvgQepJ0rv92bawBKf2dwPbCiWJOYO
 JmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033180; x=1780637980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QxWg4868hUFys70o/3FFM0O1JMxBcqCuDhTDREtBU3U=;
 b=AMSxxHq7b8/dY+JuoCjZBoZlbtKQa9J/84VwNirQa4x4rmZBLU6TfDxd3gQRD5cbpj
 WNOFv5tJIKhA1XQ6KyHdHrQZBQ1bARE1l364FrDc8+NVlhjBefr9tgdb84ITXUWBhMoq
 ueMwJzcrU5U0CqJr0QK8MSlEhsIS0PBPLoyEy4leLiLHsM/EEDD99n01nF9+Se8vQQ82
 gdeEDgJ2yPdJICe5UnPQ36KguBLANAqAkDweLQRwOb0N4FPXbYI8qS1IK7WtmnueexHQ
 n4yPK4jfThl/GxQxMUKGbFXi48LEhE6jIVe75Ugo7GDbEys/fcI/Ar5q/beapuf2Bbqo
 qh4Q==
X-Gm-Message-State: AOJu0YyGrN8V688ecCtSnvbJaHf/1ylf58UuyPucPYj6Vq6WEpWAu0B9
 FvABRfOcJrVAJNtu9z1u+0IG/ADn1NKfRoKwHwJ3UETvCpeQPT4/cHyEusKgNe85yQJLwuHwFEN
 8bMs4
X-Gm-Gg: Acq92OE5GgyvWn9zjjZVhDWszNIUnzIdCCiokUAb1qk3xWi4Y8tYc/M+WrhhC0oFX5G
 6ePuSsBVJsP3pixJ9UoqP8Qs+DNKZTyHJjc5IN6fNKM7h6mspG/x7n73r1P99sJmppKPoJ9KkkX
 1BbllRSXNkwq3JkGR1uJQFmhQLi1BN1mH3a7l+G07q/O6nxcoWyHbPqaOcw068NunA+h2hdjWIt
 /IQJDaIToXEOxUrcvcm38sksZGtI3ydGI4edu3Xf/G4Q2GUKauSi5g0PnKWJqgBguaQkxdlazfO
 zQrkWtccKYh4la/UsaJd4+aCUsvJDCiZtumOyPTCjNf8B0H6SGaxRB+RDRAyNvcPbOqLKuGmjC2
 RFJM+Muztuy/eXyRkY6gwLkBvKgMPARW59+eWy/jzmp+xg4e4knchlZsCaKiY/6diQj1a6qS9hP
 SaCulJ4TI+gdl1O+ZeJKiSAHSLz82QSS/lsAXZIpVfeIsR
X-Received: by 2002:a05:600c:8b24:b0:490:58ef:ce9b with SMTP id
 5b1f17b1804b1-4909c0cfe7dmr21856305e9.16.1780033179924; 
 Thu, 28 May 2026 22:39:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm1080845f8f.9.2026.05.28.22.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D7776036E;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/13] gitlab: add initial MacOS 15 on gitlab runner
Date: Fri, 29 May 2026 06:39:24 +0100
Message-ID: <20260529053931.283970-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Message-ID: <20260526110243.470002-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


