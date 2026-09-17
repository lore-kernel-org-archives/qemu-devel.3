Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE4BC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FPq-0007t4-DN; Thu, 17 Sep 2026 12:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPI-0007gn-DP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:20 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPE-0000eG-1p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:20 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso8351785e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664174; x=1790268974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uudWEXLbswvjJKhKbS+KuHnJ60QOojX0k9GGTZpa5Ws=;
 b=PPZ58xf+A+gXoRhur11N5Zf6p5OwtImrCEiVXR/cy9CCHgwWsIaYDzof6Jz+Aw+VzI
 jXetZmiVSpsBkFzX4x1W/sTRrWVwK29DZuCf5i5/djygwmWYN6oSVZ6R799C1p0z5/8l
 XmPh6ONTsXWm4QGDI2XE+NsispwZIO2j8s+2Ea0HoHSDp9ysPzNNWv1bVFZ+KPUEctg4
 VNlj6ExZtuZi/jBBU16Mss3+Px9T7ws6AXAybK554qHdojd/GgTSjrq8dOrb+f99s8kA
 A7tEqbrTxmeJ2LsE0AuopRUYkUXco6QHEV3Su4pevppjPHNUqP0SKMMfwRg59KQ8hcIT
 paHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664174; x=1790268974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uudWEXLbswvjJKhKbS+KuHnJ60QOojX0k9GGTZpa5Ws=;
 b=EdzUOMVMiGOORA5h9Te5fNW8blM8N2hxs6Xe9qkFZuHjsYE7aOaaGD51GTo91RYk9f
 CPp4QyKVFE3NwrNzKuUBK/esW7D8tOjhQ1oMu5y36fUsmoHnIe67GElIxwIyi3KZEcdY
 miSe/dDUOvLsgdqwI4GkkJR1M9IqngM0qhMR/GsVkOasNsVm8HVJ5RFNAYNvzw7aahAC
 n4nZmRsuoSrio+KxVzDteBN8DI+7ZxRdAZ/hJC19i8Al70GwmlBB0D/CsOLIEMj20Ovi
 i9vMhAfpX+k6Bj/FajJfN7xQ0/TKkbwFU9yQcT89CO8x6p1tG5ik4ePwzzXHoM1tCAFY
 4esA==
X-Gm-Message-State: AFuF++miOhozPP/7Aiku+qwWLabmqBwf6uKjN4u78xDGEQkD8DYt8mts
 zJXGO0+5EFK7GjzhJOXOmGITmjT78SLXuxOJy/t6jBanPB1vstt1fSAcgAgeRDV3fwg=
X-Gm-Gg: AYBFou2NsKD92ns77RM7Ap3loHqZguHKdbe1N8ful91DxvhZnzE4VV+9BHf9tJyzbYd
 OJUMqgXn6APP2fogZ4UaguiyyjA0oKHfGCa1YlMTg36qcxCj50j/+kifwatu8B2dH9fYI93oQ5a
 fVzKZdYr24VuJpvPxKLGqd+1BuFRcmc64nUmM+okQlElO2X51vLwB4qqgn39x1RCZKqrnTF7wbo
 EtKHx65Qig0XIh/X6k56sZG0FGtoUjsuYoznezFniCPqxR9SOcpHvHEjSQtQSD3Kxl/jG/VNvKx
 UXH3SHXTDNRhBkzntLIJ7+qvpgYCmaJxb/MwjLJD+Dwyw0ZRTSgrKpZzEiEc/G5gsDL8nq64Bjw
 Mp+8H7c7b92TQf77UouRT9orGeeYAhDgKIsplR3CnsqR98R+MjEC9QvHLpJwtUeeVTCtkgqqvFV
 5bwPEkR2vXl5AbIMpgKM+r0SIorauQhS99aW2s+uDE7l5ViRRyt0W0IgsPevcvQroC1SP7xEc=
X-Received: by 2002:a05:600c:630a:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49eb7325340mr93241475e9.17.1789664174582; 
 Thu, 17 Sep 2026 09:56:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf418dcsm17001622f8f.35.2026.09.17.09.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 946D55FA62;
 Thu, 17 Sep 2026 17:56:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 04/17] configure: re-purpose the tcg test compiler configs
 for vdso building
Date: Thu, 17 Sep 2026 17:55:48 +0100
Message-ID: <20260917165602.3405537-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

All the tcg tests are in meson now so there is no reason to put the
config-target.mak files in those directories. We also don't need the
GDB feature tests or to emit prerequsistes.

The vdso re-build blob does use the compiler definitions though so
we can emit the details for that and tweak the vdso makefiles to point
at the right place. Note some of the vdso makefiles build both 32 and
64 bit versions from the same compiler.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                            | 69 +++++++++++-----------------
 linux-user/aarch64/Makefile.vdso     |  2 +-
 linux-user/arm/Makefile.vdso         |  2 +-
 linux-user/hppa/Makefile.vdso        |  2 +-
 linux-user/i386/Makefile.vdso        |  2 +-
 linux-user/loongarch64/Makefile.vdso |  2 +-
 linux-user/ppc/Makefile.vdso         |  2 +-
 linux-user/riscv/Makefile.vdso       |  2 +-
 linux-user/s390x/Makefile.vdso       |  2 +-
 linux-user/sh4/Makefile.vdso         |  2 +-
 linux-user/x86_64/Makefile.vdso      |  2 +-
 11 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/configure b/configure
index 04e312a111a..667fc7ca19b 100755
--- a/configure
+++ b/configure
@@ -1732,65 +1732,48 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-tcg_tests_with_compilers=
+# Export the compiler details needed for rebuilding the vdso blobs
 for target in $target_list; do
-  arch=${target%%-*}
 
+  # Skip anything that is not a linux-user target
   case $target in
+    *-linux-user)
+      ;;
+    *)
+      continue
+      ;;
+  esac
+
+  arch=${target%%-*}
+
+  case $arch in
     xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build system tests
+      # the toolchain can only build system tests due to missing headers
+      continue
+      ;;
+    aarch64_be-linux-user)
+      # there is no BE user space
       continue
       ;;
-    *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
-      qemu="qemu-system-$arch"
+    aarch64|arm|hppa|i386|loongarch64|ppc64|riscv64|s390x|sh4|x86_64)
+      # arches which need a vdso, some 64 bit arches build both
       ;;
-    *-linux-user|*-bsd-user)
-      qemu="qemu-$arch"
+    *)
+      continue
       ;;
   esac
 
-  if probe_target_compiler $target || test -n "$container_image"; then
-      test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+  # note container_image is set by a successful call to probe_target_compiler
+  if probe_target_compiler "$target" || test -n "$container_image"; then
+      mkdir -p "linux-user/$arch"
+      config_target_mak=linux-user/$arch/config-target.mak
       echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
       echo "TARGET_NAME=$arch" >> "$config_target_mak"
       echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
-      echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
-      echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
-
-      # will GDB work with these binaries?
-      if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "GDB=$gdb_bin" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
-          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
-      else
-          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
-          echo "GDB_HAS_MTE=y" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
-          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
-          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
-      fi
-
-      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
+      write_target_makefile "update-linux-vdso" >> "$config_target_mak"
   fi
 done
 
-if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
-fi
-
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index c33a679c0f2..82ed2011087 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/aarch64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/aarch64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/aarch64
 VPATH += $(SUBDIR)
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index ede489e2363..16ae8d7aaae 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/arm-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/arm/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/arm
 VPATH += $(SUBDIR)
diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
index f4537ae7169..78642c42661 100644
--- a/linux-user/hppa/Makefile.vdso
+++ b/linux-user/hppa/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/hppa-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/hppa/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/hppa
 VPATH += $(SUBDIR)
diff --git a/linux-user/i386/Makefile.vdso b/linux-user/i386/Makefile.vdso
index 95bc616f6d6..ca2e37fa6b6 100644
--- a/linux-user/i386/Makefile.vdso
+++ b/linux-user/i386/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/i386-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/i386/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/i386
 VPATH += $(SUBDIR)
diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
index 1d760b1e47e..ceb61101209 100644
--- a/linux-user/loongarch64/Makefile.vdso
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/loongarch64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/loongarch64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/loongarch64
 VPATH += $(SUBDIR)
diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
index e2b8facbb50..6b9be843817 100644
--- a/linux-user/ppc/Makefile.vdso
+++ b/linux-user/ppc/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/ppc64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/ppc64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/ppc
 VPATH += $(SUBDIR)
diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
index 2c257dbfda5..2eefdb70cf9 100644
--- a/linux-user/riscv/Makefile.vdso
+++ b/linux-user/riscv/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/riscv64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/riscv
 VPATH += $(SUBDIR)
diff --git a/linux-user/s390x/Makefile.vdso b/linux-user/s390x/Makefile.vdso
index e82bf9e29ff..51f7c50a2de 100644
--- a/linux-user/s390x/Makefile.vdso
+++ b/linux-user/s390x/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/s390x-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/s390x/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/s390x
 VPATH += $(SUBDIR)
diff --git a/linux-user/sh4/Makefile.vdso b/linux-user/sh4/Makefile.vdso
index 272c5d262de..ed2cc11b825 100644
--- a/linux-user/sh4/Makefile.vdso
+++ b/linux-user/sh4/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/sh4/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/sh4
 VPATH += $(SUBDIR)
diff --git a/linux-user/x86_64/Makefile.vdso b/linux-user/x86_64/Makefile.vdso
index 26552b66dba..56fe87af72b 100644
--- a/linux-user/x86_64/Makefile.vdso
+++ b/linux-user/x86_64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/x86_64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/x86_64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/x86_64
 VPATH += $(SUBDIR)
-- 
2.47.3


