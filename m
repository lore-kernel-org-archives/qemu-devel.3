Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ACFFD8FF5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgUO-0008H9-8A; Thu, 26 Feb 2026 13:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU9-0008EN-0a
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:20 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU5-0003Xo-3d
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:16 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so185637966b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772131990; x=1772736790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yboa4Ib5iNaVNTq21S5NaeZDhTNkVA/TIAAajIB1sXY=;
 b=kx+6xSlmw7fRFboHpfiJbJq9RZ1XOf48X+XXr1s2Q/aPUcVY7CdHiWoP6mNd16+x+W
 a8XHj2BoN54KhRNNaPG3jb125Bm5/3zbgYXq1ObPTYJT3saO4kTuZ6s+uzSTFACrAIBC
 rb0jghTyB+QfAoZTLLI67kqjP/dZn/PEzKXhVdJGkxNhuyrPL3WhJKfbXUjU0j/hQp7q
 OP8C6i5IddDSm/31wAsWhzrGIUJ5vffHJK//MSoe32ta2GUQZ1hkDtOiLQgr6185/vA6
 Vy/ury0xtc/313/CDLlECrBdeWuTDInq/EI3yvU5DAJgxLEXcChlLx5UrkGdJWle4/Jj
 8N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131990; x=1772736790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yboa4Ib5iNaVNTq21S5NaeZDhTNkVA/TIAAajIB1sXY=;
 b=b4TlLyBOzeAY23A4Z38ztR5aRO6NR6Gl66K2/C3XEl9weLcn31HKbki4YCqZIhGlYV
 XAV2hU0DhQrsdTlFDJu0gIz+saOUU7lVgtngqY+QIuHFfka95kVDTaAuaOul8fpdyQRN
 8nDbnVha5f1Zw93u/DF4XeH84sDWTccSc4KEfy6rMTatEWGvZw+F76lv01LYnJGeiY8b
 1iDj8v8sKgYfXOkISHDQh12Xb6mEFXVc3M/nz5IVxpnOdWsyhYvnSd/qJFWg/L30eKMO
 bloYvvKHdYzZIPU1QOUpwpVtDpFM75gU+mYINEVYu5D8JfJ49P6VsV7ipuhuI0IrMuV9
 nAVA==
X-Gm-Message-State: AOJu0Yzx3yo5mc+5qpOjgtnsAVkSKdGzgCLBr0CUVsuuBgmxS3RrrlBn
 8cxKIi5R9cn/oeNl8Oi8XFe7MGVqQQfhQdzAW8laF+9KTN1HUY4rzrrRcuG9PBmSpm0=
X-Gm-Gg: ATEYQzwQ9PpZJXGurBj5HRACT4S2X4rocOTgkM1erHy/98OpHGvGjSi/4ZkFGi+oz8o
 sJLPn1SdwVRcDVRVxV5jgamPGgLcC+2uBDa0iJ5lcC7HcjPbzsuD0tMeavIroJ+/ouz7fWw3AAn
 +qSDFCrC4VR3hBsq5563UsurDQiSMJE26t67m2ro6g9e2jghGHyiefis3ia9+jBB2vWZ5KNw7bS
 ociUVG1r2tybODim3RMU7DfzMLjEfngZd5wTX+lcWBFsEvME54Phtgw0CZC9n7DUM+zc7yBFZCm
 FPuL2eEadZae5RV+N9G9S5U95Wuh/+m4TDlVfMxFkKfCNe7eb7RIHv7Sewsb5EoV3JAp6uze0Cw
 VfGViiV2TYo9YYHCgUoJIOldQyihVapfqsLNp1813W37g1TZML1y4CGB4uWc4lA7UJKhnFgsg3i
 PptxWF4Tpl7jvWuQhs2wTnZCQ=
X-Received: by 2002:a17:907:da17:b0:b87:6b9c:6386 with SMTP id
 a640c23a62f3a-b935bb25ae5mr260933866b.56.1772131989452; 
 Thu, 26 Feb 2026 10:53:09 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d26dsm739784a12.16.2026.02.26.10.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:53:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 050265F8D5;
 Thu, 26 Feb 2026 18:53:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 6/7] tests/vm: build openbsd from lcitool data (!567)
Date: Thu, 26 Feb 2026 18:53:01 +0000
Message-ID: <20260226185303.1920021-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226185303.1920021-1-alex.bennee@linaro.org>
References: <20260226185303.1920021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For now only use the minimal decadency set until all the OpenBSD
mappings can be divined.

Currently depends on: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/567

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260213154859.1551283-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/refresh           |  5 ++--
 tests/vm/generated/openbsd.json | 27 +++++++++++++++++++++
 tests/vm/openbsd                | 42 ++-------------------------------
 3 files changed, 32 insertions(+), 42 deletions(-)
 create mode 100644 tests/vm/generated/openbsd.json

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index c74345e03d0..3e4b026035b 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -87,9 +87,9 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
-def generate_pkglist(vm, target):
+def generate_pkglist(vm, target, project="qemu"):
     filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
-    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
+    cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
     generate(filename, cmd, None)
 
 
@@ -316,6 +316,7 @@ try:
     # VM packages lists
     #
     generate_pkglist("freebsd", "freebsd-14")
+    generate_pkglist("openbsd", "openbsd-78", project="qemu-minimal")
 
     #
     # Ansible package lists
diff --git a/tests/vm/generated/openbsd.json b/tests/vm/generated/openbsd.json
new file mode 100644
index 00000000000..0886afd0d3d
--- /dev/null
+++ b/tests/vm/generated/openbsd.json
@@ -0,0 +1,27 @@
+{
+  "ccache": "/usr/local/bin/ccache",
+  "cpan_pkgs": [],
+  "cross_pkgs": [],
+  "make": "/usr/local/bin/gmake",
+  "ninja": "/usr/local/bin/ninja",
+  "packaging_command": "pkg_add",
+  "pip3": "/usr/local/bin/pip3",
+  "pkgs": [
+    "bash",
+    "bison",
+    "bzip2",
+    "ccache",
+    "dtc",
+    "git",
+    "glib2",
+    "gmake",
+    "gsed",
+    "libffi",
+    "meson",
+    "ninja",
+    "pkgconf",
+    "python3"
+  ],
+  "pypi_pkgs": [],
+  "python": "/usr/local/bin/python3"
+}
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 9aabfeec963..4f8eeb28e24 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -24,45 +24,6 @@ class OpenBSDVM(basevm.BaseVM):
     link = "https://cdn.openbsd.org/pub/OpenBSD/7.8/amd64/install78.iso"
     csum = "a228d0a1ef558b4d9ec84c698f0d3ffd13cd38c64149487cba0f1ad873be07b2"
     size = "20G"
-    pkgs = [
-        # tools
-        "dtc",
-        "git",
-        "pkgconf",
-        "bzip2", "xz",
-        "ninja",
-
-        # gnu tools
-        "bash",
-        "gmake",
-        "gsed",
-        "gettext-tools",
-
-        # libs: usb
-        "libusb1--",
-
-        # libs: crypto
-        "gnutls",
-
-        # libs: images
-        "jpeg",
-        "png",
-
-        # libs: ui
-        "capstone",
-        "sdl2",
-        "gtk+3",
-        "libxkbcommon",
-
-        # libs: migration
-        "zstd",
-
-        # libs: networking
-        "libslirp",
-
-        # Python stuff
-        "py3-setuptools",
-    ]
 
     BUILD_SCRIPT = """
         set -e;
@@ -198,8 +159,9 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait("login:")
         self.wait_ssh()
 
+        pkgs = self.get_qemu_packages_from_lcitool_json()
         self.print_step("Installing packages")
-        self.ssh_root_check("pkg_add %s\n" % " ".join(self.pkgs))
+        self.ssh_root_check("pkg_add %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
-- 
2.47.3


