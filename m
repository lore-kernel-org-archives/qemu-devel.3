Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB84C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMU8-0007jg-K4; Sat, 26 Sep 2026 03:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRJ-0004DC-Nw
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:18 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRG-0000bZ-56
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:17 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd05d97dso1139813c88.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406192; x=1791010992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hf+quUTqXyfAI8UGcbZlnEghgWyXicj/3euG/Dm4WTk=;
 b=VSqdvU/V6kT8Ac5yu/OTA8FAx9ufxEyDBU6OD8RrVS5r2F/aOFwNR+UPdoQhNaLtTD
 emXgdMeXJoZn51jSKjEfjks1sf1/i2J8KqwLLMEaLF1K71jp2Ga5H7hmvWQWkNGMeyrQ
 Vra5SaYRd8uuTcRxXysb0JuWQnFQkSTcAghMVZNfmHvWjMdDpPelQamunQZ8z7tf/U7J
 1FKDmEyLEsUur6H0qH61W6qXodMQ+zGBflBbG7W8zZL879sqd2H8OjDlmndryefiLEtj
 jqauZRZSagZLSEyIFUhTq0Mi6+SEbGi2F7prL9q8OfWzeipLXsj1jQJIGOZQid3bdm9j
 QAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406192; x=1791010992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hf+quUTqXyfAI8UGcbZlnEghgWyXicj/3euG/Dm4WTk=;
 b=TCkslct8qzMKot9FLBsnnapKduNW/3OBLV0rvbvLdnYrSUbt6a3jYO1KwjmCB6vGpG
 SuprOefpkSsOELTbbrduOigLTIVociVLTNRUr192shKJMaMCiFyqWS7koUn+nxN/oiud
 QJxxcMUIRi9z7xSWKaW80RI+g6u8tlEPTDpU29Db7GDBM9kmS4qSL/O/oUbQ0RI572EW
 OzWzF8OncVGjLcBbe/lgzcjMaOQouWXC9RFbMnRZY1RO0KAu8DedaD0IAOoC4WOjRBNM
 Pdp78a9ffLlTUNoryj+CDULMRuIPM0dlvCT/2XrO5RHlGDCBkos9IRrvB5ixFQET3kAy
 aPlw==
X-Gm-Message-State: AFuF++lMpqi5afWyBDN7+hL6D+AETzFns9TwZ0r3EshH7VZrvMwiHvVL
 F34qHSUZbMOtvz4wIHBoo4h2lVZnSHziLQQEuAtshQR3VP991kc5wfvJEYuaIpiY
X-Gm-Gg: AYBFou2yKNyTeA6drmaYWRPBqMneq9amySruwtZdyQQyP0HpbvUdD6ih734gHZK23d/
 biWPqTEsP1ULLmJyrHQii9zaOfGhbDQtRHRhbTKe+BQU79Zvuu8NcO+EnFK3KQgW/6qWrdsACot
 HhwZldxtNtsikuu+EPOoDEVZoQLQRcGzJgBPSTiq3O1LyssuR4RbiiksCtpeem8tmEMCMnrye+K
 6oI6o1/gxKT7ItJOuoJSls2WCEZCM1EsLtRFXuYyCiWw+X4b+fcZONLfkMpDFYrXPpyTlVFMPw2
 4uoRBmAnITyER0mCnJcaxofI5OTeaPlZvqrJhXTBDVWSWR1Be3sDxSoeW3m+NtQohRoXz9UnzXc
 WduR57TCbBphDouHubabtOmrZGblTFZ1wrTuxTgb3U1B7/nv504lpwn+P6GowhNDuOW/xZfkIuO
 fqBu0dTLQwTly5Isnq7f/ShejzAoOg9EGQnX+44MtSKw462SDKs6Vay3In93bVLvgp2SmZFsbFg
 9//RoVmDtfkFYrUcQBZwZb3ixp7VO5QDMLmGKuMRA==
X-Received: by 2002:a05:7022:418c:b0:13e:7202:5f09 with SMTP id
 a92af1059eb24-146ceb5574emr3689224c88.11.1790406191608; 
 Sat, 26 Sep 2026 00:03:11 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 32/55] tests/unit: cover common-system tl dispatch and calls
Date: Sat, 26 Sep 2026 15:00:31 +0800
Message-ID: <20260926070057.1234-33-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

test-tcg-op calls bswap32_tl, revbit32_tl, trunc, and ext from a
common build and checks the i32 or i64 callee, including the 32-bit
flag drop. dup_const_tl is checked for MO_8, MO_16, and MO_32.
Per-target tests cover both fixed widths.

The call test checks the tl alias and C type for a common build and
for both per-target widths. tcg_gen_callN zero-extends an I32 temp
into an i64 slot, sign-extends it into an s64 slot, and truncates an
i64 return back to I32.

Both tests link through tcg_core_deps. That list starts empty and,
with TCG enabled, holds the tcg_core objects already built into
libsystem, pagevary, and stubs for disas and the qemu ld/st helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/meson.build               |   2 +-
 meson.build                         |  16 ++
 tcg/meson.build                     |   9 +-
 tests/unit/meson.build              |  20 ++
 tests/unit/test-helper-tl.c         |  20 ++
 tests/unit/test-helper-tl.h         |  25 +++
 tests/unit/test-helper-tl32.c       |  27 +++
 tests/unit/test-helper-tl64.c       |  27 +++
 tests/unit/test-tcg-call-tl-stubs.c |  45 +++++
 tests/unit/test-tcg-call-tl.c       | 280 ++++++++++++++++++++++++++++
 tests/unit/test-tcg-op-dispatch.h   | 203 ++++++++++++++++++++
 tests/unit/test-tcg-op-tl32.c       |  24 +++
 tests/unit/test-tcg-op-tl64.c       |  24 +++
 tests/unit/test-tcg-op.c            |  66 +++++++
 14 files changed, 784 insertions(+), 4 deletions(-)
 create mode 100644 tests/unit/test-helper-tl.c
 create mode 100644 tests/unit/test-helper-tl.h
 create mode 100644 tests/unit/test-helper-tl32.c
 create mode 100644 tests/unit/test-helper-tl64.c
 create mode 100644 tests/unit/test-tcg-call-tl-stubs.c
 create mode 100644 tests/unit/test-tcg-call-tl.c
 create mode 100644 tests/unit/test-tcg-op-dispatch.h
 create mode 100644 tests/unit/test-tcg-op-tl32.c
 create mode 100644 tests/unit/test-tcg-op-tl64.c
 create mode 100644 tests/unit/test-tcg-op.c

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 002aa8f4588..21da63c252f 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -3,11 +3,11 @@ if not have_tcg
 endif
 
 tcg_ss = ss.source_set()
+tcg_core.add(files('tcg-runtime.c'))
 
 tcg_ss.add(files(
   'cpu-exec.c',
   'cpu-exec-common.c',
-  'tcg-runtime.c',
   'tcg-runtime-gvec.c',
   'tb-maint.c',
   'tcg-all.c',
diff --git a/meson.build b/meson.build
index 9485f4e97be..d5639a2d676 100644
--- a/meson.build
+++ b/meson.build
@@ -3731,6 +3731,8 @@ stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
 util_ss = ss.source_set()
+tcg_core = ss.source_set()
+tcg_core_deps = []
 
 # accel modules
 qtest_module_ss = ss.source_set()
@@ -4139,6 +4141,20 @@ libsystem = static_library('system',
                            dependencies: system_ss.all_dependencies(),
                            build_by_default: false)
 
+if have_tcg
+  # tcg_core is compiled into libsystem. Reuse those objects.
+  # page-vary-common.c is in common_all, not tcg_core.
+  tcg_core_deps = files('tests/unit/test-tcg-call-tl-stubs.c') + [
+    declare_dependency(
+      objects: libsystem.extract_objects(tcg_core.all_sources()),
+      compile_args: [
+        '-DCOMPILING_SYSTEM_VS_USER',
+        '-DCONFIG_SOFTMMU',
+      ]),
+  ]
+  tcg_core_deps += pagevary
+endif
+
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
 # configuration will be in build.ninja, but are never built by default.
diff --git a/tcg/meson.build b/tcg/meson.build
index 706a6eb260e..dced8eb781c 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -4,15 +4,17 @@ endif
 
 tcg_ss = ss.source_set()
 
-tcg_ss.add(files(
+tcg_core.add(files(
   'optimize.c',
   'region.c',
   'tcg.c',
   'tcg-common.c',
   'tcg-op.c',
+  'tcg-op-vec.c',
+))
+tcg_ss.add(files(
   'tcg-op-ldst.c',
   'tcg-op-gvec.c',
-  'tcg-op-vec.c',
 ))
 
 if get_option('tcg_interpreter')
@@ -24,8 +26,9 @@ endif
 
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
 if host_os == 'linux'
-  tcg_ss.add(files('perf.c'))
+  tcg_core.add(files('perf.c'))
 endif
 
+tcg_ss.add_all(tcg_core)
 user_ss.add_all(tcg_ss)
 system_ss.add_all(tcg_ss)
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index dc139889c1d..552f96e37dd 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -43,6 +43,13 @@ tests = {
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
   'check-qom-proplist': [qom],
+  'test-tcg-op': [qom] + tcg_core_deps,
+  'test-tcg-op-tl32': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config32.h"'])],
+  'test-tcg-op-tl64': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config64.h"'])],
   'test-tcg-op-mem': [qom],
   'test-tcg-op-mem-tl32': [declare_dependency(compile_args: [
     '-DCOMPILING_PER_TARGET',
@@ -53,6 +60,13 @@ tests = {
   'test-tcg-op-mem-va32-tl64': [declare_dependency(compile_args: [
     '-DCOMPILING_PER_TARGET',
     '-DCONFIG_TARGET="test-tcg-op-mem-config64.h"'])],
+  'test-helper-tl': [],
+  'test-helper-tl32': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config32.h"'])],
+  'test-helper-tl64': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config64.h"'])],
   'test-target-info': [qom, declare_dependency(
     objects: target_info_def_objects.values(),
     compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
@@ -67,6 +81,12 @@ tests = {
   'test-envlist': [],
 }
 
+if have_tcg
+  tests += {
+    'test-tcg-call-tl': tcg_core_deps,
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-helper-tl.c b/tests/unit/test-helper-tl.c
new file mode 100644
index 00000000000..47719ccd95f
--- /dev/null
+++ b/tests/unit/test-helper-tl.c
@@ -0,0 +1,20 @@
+/*
+ * Common-system tl helper slot stays an i64 C type.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/helper-head.h.inc"
+
+#define HELPER_TL_EXPECT_TYPECODE dh_typecode_i64
+#define HELPER_TL_EXPECT_CTYPE uint64_t
+#include "test-helper-tl.h"
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/helper-tl/alias", test_helper_tl_alias);
+    g_test_add_func("/tcg/helper-tl/slot", test_helper_tl_slot);
+    return g_test_run();
+}
diff --git a/tests/unit/test-helper-tl.h b/tests/unit/test-helper-tl.h
new file mode 100644
index 00000000000..3ab660217f4
--- /dev/null
+++ b/tests/unit/test-helper-tl.h
@@ -0,0 +1,25 @@
+/*
+ * Shared checks for the tl helper slot.
+ *
+ * The including file defines HELPER_TL_EXPECT_TYPECODE and
+ * HELPER_TL_EXPECT_CTYPE after including exec/helper-head.h.inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+static void test_helper_tl_alias(void)
+{
+#define HELPER_TL_ALIAS_PROBE_tl 1
+#define HELPER_TL_ALIAS_PROBE_i32 0
+#define HELPER_TL_ALIAS_PROBE_i64 0
+    g_assert_cmpint(glue(HELPER_TL_ALIAS_PROBE_, dh_alias(tl)), ==, 1);
+}
+
+static void test_helper_tl_slot(void)
+{
+    g_assert_cmpint(dh_typecode(tl), ==, HELPER_TL_EXPECT_TYPECODE);
+    g_assert_cmpint(dh_typemask(tl, 0), ==, HELPER_TL_EXPECT_TYPECODE);
+    g_assert_cmpint(dh_callflag(tl), ==, 0);
+    g_assert_true(__builtin_types_compatible_p(dh_ctype(tl),
+                                               HELPER_TL_EXPECT_CTYPE));
+}
diff --git a/tests/unit/test-helper-tl32.c b/tests/unit/test-helper-tl32.c
new file mode 100644
index 00000000000..1e99c22d6a9
--- /dev/null
+++ b/tests/unit/test-helper-tl32.c
@@ -0,0 +1,27 @@
+/*
+ * Per-target tl helper slot with TARGET_LONG_BITS == 32.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/helper-head.h.inc"
+
+#define HELPER_TL_EXPECT_TYPECODE dh_typecode_i32
+#define HELPER_TL_EXPECT_CTYPE uint32_t
+#include "test-helper-tl.h"
+
+static void test_helper_tl32_ctype(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 32);
+    g_assert_true(__builtin_types_compatible_p(dh_ctype(tl), target_ulong));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/helper-tl/tl32-alias", test_helper_tl_alias);
+    g_test_add_func("/tcg/helper-tl/tl32-slot", test_helper_tl_slot);
+    g_test_add_func("/tcg/helper-tl/tl32-ctype", test_helper_tl32_ctype);
+    return g_test_run();
+}
diff --git a/tests/unit/test-helper-tl64.c b/tests/unit/test-helper-tl64.c
new file mode 100644
index 00000000000..499a84bbf62
--- /dev/null
+++ b/tests/unit/test-helper-tl64.c
@@ -0,0 +1,27 @@
+/*
+ * Per-target tl helper slot with TARGET_LONG_BITS == 64.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/helper-head.h.inc"
+
+#define HELPER_TL_EXPECT_TYPECODE dh_typecode_i64
+#define HELPER_TL_EXPECT_CTYPE uint64_t
+#include "test-helper-tl.h"
+
+static void test_helper_tl64_ctype(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 64);
+    g_assert_true(__builtin_types_compatible_p(dh_ctype(tl), target_ulong));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/helper-tl/tl64-alias", test_helper_tl_alias);
+    g_test_add_func("/tcg/helper-tl/tl64-slot", test_helper_tl_slot);
+    g_test_add_func("/tcg/helper-tl/tl64-ctype", test_helper_tl64_ctype);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-call-tl-stubs.c b/tests/unit/test-tcg-call-tl-stubs.c
new file mode 100644
index 00000000000..ec1414b88ba
--- /dev/null
+++ b/tests/unit/test-tcg-call-tl-stubs.c
@@ -0,0 +1,45 @@
+/*
+ * Stubs for symbols referenced by extracted tcg_core objects.
+ * The call-slot test does not execute these paths.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/helper-info.h"
+
+void disas(FILE *out, const void *code, size_t size);
+void helper_ldub_mmu(void);
+void helper_lduw_mmu(void);
+void helper_ldul_mmu(void);
+void helper_ldq_mmu(void);
+void helper_ld16_mmu(void);
+void helper_ldsb_mmu(void);
+void helper_ldsw_mmu(void);
+void helper_ldsl_mmu(void);
+void helper_stb_mmu(void);
+void helper_stw_mmu(void);
+void helper_stl_mmu(void);
+void helper_stq_mmu(void);
+void helper_st16_mmu(void);
+
+void disas(FILE *out, const void *code, size_t size)
+{
+    (void)out;
+    (void)code;
+    (void)size;
+}
+
+void helper_ldub_mmu(void) {}
+void helper_lduw_mmu(void) {}
+void helper_ldul_mmu(void) {}
+void helper_ldq_mmu(void) {}
+void helper_ld16_mmu(void) {}
+void helper_ldsb_mmu(void) {}
+void helper_ldsw_mmu(void) {}
+void helper_ldsl_mmu(void) {}
+void helper_stb_mmu(void) {}
+void helper_stw_mmu(void) {}
+void helper_stl_mmu(void) {}
+void helper_stq_mmu(void) {}
+void helper_st16_mmu(void) {}
diff --git a/tests/unit/test-tcg-call-tl.c b/tests/unit/test-tcg-call-tl.c
new file mode 100644
index 00000000000..fc39bbaabae
--- /dev/null
+++ b/tests/unit/test-tcg-call-tl.c
@@ -0,0 +1,280 @@
+/*
+ * Execute tcg_gen_callN when an I32 temp meets an i64 or s64 slot.
+ *
+ * The common-system tl helper uses a fixed i64 C slot. tcg_gen_callN
+ * zero-extends an I32 argument into that slot, sign-extends an I32
+ * argument into an s64 slot, and truncates an i64 or s64 return back
+ * to an I32 temp. A matching width leaves the call op alone.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg-op-common.h"
+
+static TCGContext *ctx;
+
+static void dummy_helper(void)
+{
+}
+
+static void reset_ctx(void)
+{
+    if (!ctx) {
+        ctx = g_new0(TCGContext, 1);
+        tcg_ctx = ctx;
+    }
+    tcg_func_start(ctx);
+}
+
+static TCGTemp *new_temp(TCGType type)
+{
+    if (type == TCG_TYPE_I32) {
+        return tcgv_i32_temp(tcg_temp_new_i32());
+    }
+    return tcgv_i64_temp(tcg_temp_new_i64());
+}
+
+static void prep_info(TCGHelperInfo *info, unsigned typemask)
+{
+    if (!info->func) {
+        info->func = dummy_helper;
+        info->typemask = typemask;
+        info->flags = TCG_CALL_NO_SIDE_EFFECTS;
+    }
+}
+
+static int collect_ops(TCGOpcode *out, int max)
+{
+    TCGOp *op;
+    int n = 0;
+
+    QTAILQ_FOREACH(op, &ctx->ops, link) {
+        g_assert_cmpint(n, <, max);
+        out[n++] = op->opc;
+    }
+    return n;
+}
+
+static void assert_ops(const TCGOpcode *exp, int nexp)
+{
+    TCGOpcode got[8];
+    int n = collect_ops(got, ARRAY_SIZE(got));
+    int i;
+
+    g_assert_cmpint(n, ==, nexp);
+    for (i = 0; i < n; i++) {
+        g_assert_cmpint(got[i], ==, exp[i]);
+    }
+}
+
+static void assert_call_shape(int nr_out, int nr_in)
+{
+    TCGOp *op;
+    int calls = 0;
+
+    QTAILQ_FOREACH(op, &ctx->ops, link) {
+        if (op->opc == INDEX_op_call) {
+            g_assert_cmpint(TCGOP_CALLO(op), ==, nr_out);
+            g_assert_cmpint(TCGOP_CALLI(op), ==, nr_in);
+            calls++;
+        }
+    }
+    g_assert_cmpint(calls, ==, 1);
+}
+
+static void emit_call1(TCGHelperInfo *info, bool has_ret,
+                       TCGType ret_type, TCGType arg_type)
+{
+    TCGTemp *ret = NULL;
+    TCGTemp *arg;
+
+    reset_ctx();
+    if (has_ret) {
+        ret = new_temp(ret_type);
+    }
+    arg = new_temp(arg_type);
+    tcg_gen_call1(dummy_helper, info, ret, arg);
+}
+
+static void emit_call2(TCGHelperInfo *info, TCGType arg0, TCGType arg1)
+{
+    TCGTemp *a0, *a1;
+
+    reset_ctx();
+    a0 = new_temp(arg0);
+    a1 = new_temp(arg1);
+    tcg_gen_call2(dummy_helper, info, NULL, a0, a1);
+}
+
+static void test_i32_arg_i64_ret(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_extu_i32_i64,
+        INDEX_op_call,
+        INDEX_op_extrl_i64_i32,
+    };
+
+    prep_info(&info, dh_typemask(i64, 0) | dh_typemask(i64, 1));
+    emit_call1(&info, true, TCG_TYPE_I32, TCG_TYPE_I32);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(1, 1);
+}
+
+static void test_i32_arg_s64_ret(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_ext_i32_i64,
+        INDEX_op_call,
+        INDEX_op_extrl_i64_i32,
+    };
+
+    prep_info(&info, dh_typemask(s64, 0) | dh_typemask(s64, 1));
+    emit_call1(&info, true, TCG_TYPE_I32, TCG_TYPE_I32);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(1, 1);
+}
+
+static void test_i64_arg_i64_ret(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = { INDEX_op_call };
+
+    prep_info(&info, dh_typemask(i64, 0) | dh_typemask(i64, 1));
+    emit_call1(&info, true, TCG_TYPE_I64, TCG_TYPE_I64);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(1, 1);
+}
+
+static void test_i64_arg_i32_ret(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_call,
+        INDEX_op_extrl_i64_i32,
+    };
+
+    prep_info(&info, dh_typemask(i64, 0) | dh_typemask(i64, 1));
+    emit_call1(&info, true, TCG_TYPE_I32, TCG_TYPE_I64);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(1, 1);
+}
+
+static void test_void_i32_arg_i64(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_extu_i32_i64,
+        INDEX_op_call,
+    };
+
+    prep_info(&info, dh_typemask(void, 0) | dh_typemask(i64, 1));
+    emit_call1(&info, false, 0, TCG_TYPE_I32);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(0, 1);
+}
+
+/*
+ * An i32 or s32 slot keeps the host ABI kind. tcg_gen_callN must not
+ * also apply the i64-slot extend, and must not truncate the return.
+ */
+static void test_i32_slot(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[2];
+    int n = 0;
+
+    prep_info(&info, dh_typemask(i32, 0) | dh_typemask(i32, 1));
+    emit_call1(&info, true, TCG_TYPE_I32, TCG_TYPE_I32);
+    if (info.in[0].kind == TCG_CALL_ARG_EXTEND_U) {
+        exp[n++] = INDEX_op_extu_i32_i64;
+    } else if (info.in[0].kind == TCG_CALL_ARG_EXTEND_S) {
+        exp[n++] = INDEX_op_ext_i32_i64;
+    } else {
+        g_assert_cmpint(info.in[0].kind, ==, TCG_CALL_ARG_NORMAL);
+    }
+    exp[n++] = INDEX_op_call;
+    assert_ops(exp, n);
+    assert_call_shape(1, 1);
+}
+
+static void test_s32_slot(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[2];
+    int n = 0;
+
+    prep_info(&info, dh_typemask(s32, 0) | dh_typemask(s32, 1));
+    emit_call1(&info, true, TCG_TYPE_I32, TCG_TYPE_I32);
+    if (info.in[0].kind == TCG_CALL_ARG_EXTEND_U) {
+        exp[n++] = INDEX_op_extu_i32_i64;
+    } else if (info.in[0].kind == TCG_CALL_ARG_EXTEND_S) {
+        exp[n++] = INDEX_op_ext_i32_i64;
+    } else {
+        g_assert_cmpint(info.in[0].kind, ==, TCG_CALL_ARG_NORMAL);
+    }
+    exp[n++] = INDEX_op_call;
+    assert_ops(exp, n);
+    assert_call_shape(1, 1);
+}
+
+static void test_i32_arg_ptr_slot(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = { INDEX_op_call };
+
+    prep_info(&info, dh_typemask(ptr, 0) | dh_typemask(ptr, 1));
+    emit_call1(&info, true, TCG_TYPE_PTR, TCG_TYPE_I32);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(1, 1);
+}
+
+static void test_two_args_i32_then_i64(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_extu_i32_i64,
+        INDEX_op_call,
+    };
+
+    prep_info(&info, dh_typemask(void, 0) | dh_typemask(i64, 1) |
+              dh_typemask(i64, 2));
+    emit_call2(&info, TCG_TYPE_I32, TCG_TYPE_I64);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(0, 2);
+}
+
+static void test_two_args_i64_then_s64(void)
+{
+    static TCGHelperInfo info;
+    TCGOpcode exp[] = {
+        INDEX_op_ext_i32_i64,
+        INDEX_op_call,
+    };
+
+    prep_info(&info, dh_typemask(void, 0) | dh_typemask(i64, 1) |
+              dh_typemask(s64, 2));
+    emit_call2(&info, TCG_TYPE_I64, TCG_TYPE_I32);
+    assert_ops(exp, ARRAY_SIZE(exp));
+    assert_call_shape(0, 2);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/call-tl/i32-arg-i64-ret", test_i32_arg_i64_ret);
+    g_test_add_func("/tcg/call-tl/i32-arg-s64-ret", test_i32_arg_s64_ret);
+    g_test_add_func("/tcg/call-tl/i64-arg-i64-ret", test_i64_arg_i64_ret);
+    g_test_add_func("/tcg/call-tl/i64-arg-i32-ret", test_i64_arg_i32_ret);
+    g_test_add_func("/tcg/call-tl/void-i32-arg-i64", test_void_i32_arg_i64);
+    g_test_add_func("/tcg/call-tl/i32-slot", test_i32_slot);
+    g_test_add_func("/tcg/call-tl/s32-slot", test_s32_slot);
+    g_test_add_func("/tcg/call-tl/i32-arg-ptr-slot", test_i32_arg_ptr_slot);
+    g_test_add_func("/tcg/call-tl/two-args-i32-then-i64",
+                    test_two_args_i32_then_i64);
+    g_test_add_func("/tcg/call-tl/two-args-i64-then-s64",
+                    test_two_args_i64_then_s64);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op-dispatch.h b/tests/unit/test-tcg-op-dispatch.h
new file mode 100644
index 00000000000..991126b3743
--- /dev/null
+++ b/tests/unit/test-tcg-op-dispatch.h
@@ -0,0 +1,203 @@
+/*
+ * Intercept tcg_gen_* callees so tcg-op-tl.h dispatch can be called
+ * without a TCG context.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TEST_TCG_OP_DISPATCH_H
+#define TEST_TCG_OP_DISPATCH_H
+
+#include "tcg/tcg.h"
+
+static struct {
+    int bswap32_i32;
+    int bswap32_i64;
+    int bswap32_i64_flags;
+    int revbit32_i32;
+    int revbit32_i64;
+    int revbit32_i64_flags;
+    int mov_i32;
+    int mov_i64;
+    int extrl_i64_i32;
+    int extu_i32_i64;
+    int ext_i32_i64;
+} tcg_op_test_saw;
+
+#define tcg_gen_bswap32_i32 tcg_op_test_record_bswap32_i32
+#define tcg_gen_bswap32_i64 tcg_op_test_record_bswap32_i64
+#define tcg_gen_revbit32_i32 tcg_op_test_record_revbit32_i32
+#define tcg_gen_revbit32_i64 tcg_op_test_record_revbit32_i64
+#define tcg_gen_mov_i32 tcg_op_test_record_mov_i32
+#define tcg_gen_mov_i64 tcg_op_test_record_mov_i64
+#define tcg_gen_extrl_i64_i32 tcg_op_test_record_extrl_i64_i32
+#define tcg_gen_extu_i32_i64 tcg_op_test_record_extu_i32_i64
+#define tcg_gen_ext_i32_i64 tcg_op_test_record_ext_i32_i64
+
+#include "tcg/tcg-op.h"
+
+void tcg_op_test_record_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    tcg_op_test_saw.bswap32_i32++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+{
+    tcg_op_test_saw.bswap32_i64++;
+    tcg_op_test_saw.bswap32_i64_flags = flags;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    tcg_op_test_saw.revbit32_i32++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+{
+    tcg_op_test_saw.revbit32_i64++;
+    tcg_op_test_saw.revbit32_i64_flags = flags;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    tcg_op_test_saw.mov_i32++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    tcg_op_test_saw.mov_i64++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
+{
+    tcg_op_test_saw.extrl_i64_i32++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
+{
+    tcg_op_test_saw.extu_i32_i64++;
+    (void)ret;
+    (void)arg;
+}
+
+void tcg_op_test_record_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
+{
+    tcg_op_test_saw.ext_i32_i64++;
+    (void)ret;
+    (void)arg;
+}
+
+static void tcg_op_test_saw_reset(void)
+{
+    memset(&tcg_op_test_saw, 0, sizeof(tcg_op_test_saw));
+}
+
+G_GNUC_UNUSED
+static void tcg_op_test_expect_i32(void)
+{
+    g_assert_false(tl_is_64());
+
+    tcg_op_test_saw_reset();
+    tcg_gen_bswap32_tl((TCGv)NULL, (TCGv)NULL, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.bswap32_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.bswap32_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_revbit32_tl((TCGv)NULL, (TCGv)NULL, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.revbit32_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.revbit32_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_trunc_tl_i32(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.extrl_i64_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_trunc_i64_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.extrl_i64_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_extu_i32_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.extu_i32_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_ext_i32_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.ext_i32_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_extu_tl_i64(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.extu_i32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_ext_tl_i64(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.ext_i32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 0);
+}
+
+G_GNUC_UNUSED
+static void tcg_op_test_expect_i64(void)
+{
+    g_assert_true(tl_is_64());
+
+    tcg_op_test_saw_reset();
+    tcg_gen_bswap32_tl((TCGv)NULL, (TCGv)NULL, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.bswap32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.bswap32_i64_flags, ==, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.bswap32_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_revbit32_tl((TCGv)NULL, (TCGv)NULL, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.revbit32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.revbit32_i64_flags, ==, 0x15);
+    g_assert_cmpint(tcg_op_test_saw.revbit32_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_trunc_tl_i32(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.extrl_i64_i32, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_trunc_i64_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.extrl_i64_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_extu_i32_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.extu_i32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_ext_i32_tl((TCGv)NULL, NULL);
+    g_assert_cmpint(tcg_op_test_saw.ext_i32_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.mov_i32, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_extu_tl_i64(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.extu_i32_i64, ==, 0);
+
+    tcg_op_test_saw_reset();
+    tcg_gen_ext_tl_i64(NULL, (TCGv)NULL);
+    g_assert_cmpint(tcg_op_test_saw.mov_i64, ==, 1);
+    g_assert_cmpint(tcg_op_test_saw.ext_i32_i64, ==, 0);
+}
+
+#endif /* TEST_TCG_OP_DISPATCH_H */
diff --git a/tests/unit/test-tcg-op-tl32.c b/tests/unit/test-tcg-op-tl32.c
new file mode 100644
index 00000000000..5d7cf05c5ea
--- /dev/null
+++ b/tests/unit/test-tcg-op-tl32.c
@@ -0,0 +1,24 @@
+/*
+ * tcg-op.h with TARGET_LONG_BITS == 32.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "test-tcg-op-dispatch.h"
+
+static void test_tl32(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 32);
+    g_assert_false(tl_is_64());
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv_i32));
+    tcg_op_test_expect_i32();
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op/tl32-dispatch", test_tl32);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op-tl64.c b/tests/unit/test-tcg-op-tl64.c
new file mode 100644
index 00000000000..0d9a7e2d0fc
--- /dev/null
+++ b/tests/unit/test-tcg-op-tl64.c
@@ -0,0 +1,24 @@
+/*
+ * tcg-op.h with TARGET_LONG_BITS == 64.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "test-tcg-op-dispatch.h"
+
+static void test_tl64(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 64);
+    g_assert_true(tl_is_64());
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv_i64));
+    tcg_op_test_expect_i64();
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op/tl64-dispatch", test_tl64);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op.c b/tests/unit/test-tcg-op.c
new file mode 100644
index 00000000000..92041349b47
--- /dev/null
+++ b/tests/unit/test-tcg-op.c
@@ -0,0 +1,66 @@
+/*
+ * Compile and call tcg-op.h with no TARGET_LONG_BITS.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-def.h"
+#include "test-tcg-op-dispatch.h"
+
+static const TargetInfo tl32_info = {
+    .target_name = "tl32",
+    .long_bits = 32,
+};
+
+static const TargetInfo tl64_info = {
+    .target_name = "tl64",
+    .long_bits = 64,
+};
+
+static void test_common_tl_types(void)
+{
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcg_constant_tl(0)), TCGv));
+}
+
+static void test_dispatch_both_widths(void)
+{
+    target_info_select(&tl32_info);
+    tcg_op_test_expect_i32();
+
+    target_info_select(&tl64_info);
+    tcg_op_test_expect_i64();
+}
+
+static void test_dup_const_tl_width(void)
+{
+    target_info_select(&tl32_info);
+    g_assert_false(tl_is_64());
+    g_assert_cmpint(tcg_type_tl(), ==, TCG_TYPE_I32);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_8, 0xab), ==, 0xababababu);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_16, 0xabcd), ==, 0xabcdabcdu);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_32, 0x01020304), ==,
+                     0x01020304u);
+
+    target_info_select(&tl64_info);
+    g_assert_true(tl_is_64());
+    g_assert_cmpint(tcg_type_tl(), ==, TCG_TYPE_I64);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_8, 0xab), ==,
+                     0xababababababababull);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_16, 0xabcd), ==,
+                     0xabcdabcdabcdabcdull);
+    g_assert_cmpuint((uint64_t)dup_const_tl(MO_32, 0x01020304), ==,
+                     0x0102030401020304ull);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op/common-tl-types", test_common_tl_types);
+    g_test_add_func("/tcg/op/dispatch-both-widths", test_dispatch_both_widths);
+    g_test_add_func("/tcg/op/dup-const-tl-width", test_dup_const_tl_width);
+    return g_test_run();
+}
-- 
2.52.0.windows.1


