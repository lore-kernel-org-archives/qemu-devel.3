Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF8606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I64rlGZR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgtZ-0007qg-4J; Tue, 27 Oct 2026 09:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xLgtX-0007qO-HV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:07:15 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xLgtU-0005Vu-6J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:07:14 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso2391728e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793106430; x=1793711230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w8y8FcrivNxmXSl5ogfZ9P+6PPoIlTcQ8+g6aIw9qqM=;
 b=I64rlGZRBRmmrHm5pDdDCHs06b0qfEyF8LNCSE2vcDMIK13J2PS8yQLDXXqTjqKI5x
 EARTSqdBsdpqPmWvIS88aV5Cs5o4dMi5ApfPCDmwRJrneKm1TS+fe0d5wOhqG1UsH1QA
 TbxoBm5/KIVttD98gB3vmSeYF2keVM9v7ToUeTT57gN2vhD08LMQ7VTh+vIcYtfoByQA
 ThyeujCh622xfF+tUlellWFBKmJjayTvLP9fCpivaF193skT4xWAZfVYClHfqW+Hj1ly
 8doqk8zvu10dnp0OgIATNc/tXAsHJXdX5Oi8HhCQBBtBy6UVDFpxslT4Qk9yGWpAWc5w
 PFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106430; x=1793711230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w8y8FcrivNxmXSl5ogfZ9P+6PPoIlTcQ8+g6aIw9qqM=;
 b=o/0o2NXvYSfS1MtJ3Ovo/5wkPUE2KMX2wkxdrglTIukpcAJlYdzmUT/p9RQaEVQLZO
 ijANs29TVIjdaKl2BBqagyuw45PQ9HSVR3s18zR07/ILUyx31AusiZ1KUchG9lErr1e8
 MKOHumqkaGTxObuyc6PnMspopcjUde/Rlb5cVyqIIGP1ppUeyolXj5HD79QZy+E4RlRp
 TBU/GDjniS+Xv1bNV+YCW6PWGFk+SBrLnB7rZZW8jLFTrbl0QfH78TVpjmSmsAqSeR+r
 XxRzbyOUgg5RRSkqoCDw2NmLadbkYNZrqhnmaxWmeZyTXihUFDyFmbM0yx6/ZC7mMs84
 s4Ng==
X-Gm-Message-State: AFq9FYL8eeOhEZERdgqIOzYXwZVR8vygyT2gs15liy8mAcSy2lbSqG6P
 w91nLzaioQOxPH3/kh64FXKULH8SXytzXQLrU9qC1ECELOpQ2lA25vjAl5LZmTjlCtmarA==
X-Gm-Gg: AYBFou3r3PQ7X3sVqPKNrFFoJ/KrkuYDMDiUKf846wz9ZH+mTA1soHUt7IuPLAOctDe
 Mq5oAJ4gjXTiDQDHlHIrrayaUUJo3AcZHr3nX8G74g9u9i5MRfx2r/M3p/p+B3tz41h/s5dvjaA
 c4UNqxAuRAn6olr4E6vs3NKCIPl+PMFci1optRcC62oDgPr4jagkEdDyimLf0uMkeoN2Hj2fRyE
 2mhynpPQ2RdlJClUx/4aZoFqX9BVJpwPMqeJBh0TFZoMzyrxhYeMSC9GcEvxvUab8cM+R/xd73/
 gI7PBo8h/Cc6r5s5LTVunZPOBZLgmtrrZ6+wErzSA8IytMZn4bZbQHv34zsn4zTB/h0pyhVxg8x
 d3fYMsVOlM/UPTqyO3Vr6lhA0dpBN/qoTCI5SbjnApjEouV667MXTGfU0P7UiijH2m0bAE7RlYa
 KaOwe9d5wC0NrNUYRHBUcgTOtm19UNTP8rflXCrj7eGIATA6yTvXssk5V4V58dAnwyN91nL/hy5
 kdj1WoUUBO6wMMF9msQumeroQ0yUJ7xUcgFQtVX/0+sMNQmiRCoIqHTFcZ5ZXhaPqObmSvTx39D
 R3n28wqQYUjQI2Snl6ePce7nme04qf+/VhLO9s4NiFAdiQAqwQ==
X-Received: by 2002:a05:6512:3b21:b0:5b8:f048:473d with SMTP id
 2adb3069b0e04-5bfb716dd83mr3119476e87.7.1793106429587; 
 Tue, 27 Oct 2026 06:07:09 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a75a79sm2226308e87.39.2026.10.27.06.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:07:08 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user/x86_64: fix modify_ldt ABI and lm handling
Date: Tue, 27 Oct 2026 16:06:13 +0300
Message-ID: <20261027130613.113038-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux uses a 16-byte user_desc on x86_64, with a 32-bit base_addr.
QEMU expects 24 bytes instead and rejects valid modify_ldt writes.

Use a 32-bit base_addr and swap it accordingly. Ignore lm when
building LDT entries, matching Linux. Add a shared i386/x86_64
regression test for the ABI size and descriptor contents.

Based on the diagnosis and proposed fix by naehrwert in issue #4691.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4691
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 linux-user/syscall.c               | 10 +----
 linux-user/x86_64/target_syscall.h |  4 +-
 tests/tcg/i386/meson.build         |  1 +
 tests/tcg/i386/modify-ldt.c        | 72 ++++++++++++++++++++++++++++++
 tests/tcg/x86_64/meson.build       |  1 +
 5 files changed, 78 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/i386/modify-ldt.c

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691..a5d827b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6237,7 +6237,7 @@ static abi_long write_ldt(CPUX86State *env,
     struct target_modify_ldt_ldt_s ldt_info;
     struct target_modify_ldt_ldt_s *target_ldt_info;
     int seg_32bit, contents, read_exec_only, limit_in_pages;
-    int seg_not_present, useable, lm;
+    int seg_not_present, useable;
     uint32_t *lp, entry_1, entry_2;
 
     if (bytecount != sizeof(ldt_info))
@@ -6245,7 +6245,7 @@ static abi_long write_ldt(CPUX86State *env,
     if (!lock_user_struct(VERIFY_READ, target_ldt_info, ptr, 1))
         return -TARGET_EFAULT;
     ldt_info.entry_number = tswap32(target_ldt_info->entry_number);
-    ldt_info.base_addr = tswapal(target_ldt_info->base_addr);
+    ldt_info.base_addr = tswap32(target_ldt_info->base_addr);
     ldt_info.limit = tswap32(target_ldt_info->limit);
     ldt_info.flags = tswap32(target_ldt_info->flags);
     unlock_user_struct(target_ldt_info, ptr, 0);
@@ -6258,11 +6258,6 @@ static abi_long write_ldt(CPUX86State *env,
     limit_in_pages = (ldt_info.flags >> 4) & 1;
     seg_not_present = (ldt_info.flags >> 5) & 1;
     useable = (ldt_info.flags >> 6) & 1;
-#ifdef TARGET_ABI32
-    lm = 0;
-#else
-    lm = (ldt_info.flags >> 7) & 1;
-#endif
     if (contents == 3) {
         if (oldmode)
             return -TARGET_EINVAL;
@@ -6309,7 +6304,6 @@ static abi_long write_ldt(CPUX86State *env,
         ((seg_not_present ^ 1) << 15) |
         (seg_32bit << 22) |
         (limit_in_pages << 23) |
-        (lm << 21) |
         0x7000;
     if (!oldmode)
         entry_2 |= (useable << 20);
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index 68f55f8..06f3af5 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -17,7 +17,7 @@
 #if 0 // Redefine this
 struct target_modify_ldt_ldt_s {
 	unsigned int  entry_number;
-        abi_ulong     base_addr;
+        abi_uint      base_addr;
 	unsigned int  limit;
 	unsigned int  seg_32bit:1;
 	unsigned int  contents:2;
@@ -30,7 +30,7 @@ struct target_modify_ldt_ldt_s {
 #else
 struct target_modify_ldt_ldt_s {
 	unsigned int  entry_number;
-        abi_ulong     base_addr;
+        abi_uint      base_addr;
 	unsigned int  limit;
         unsigned int flags;
 };
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index e7c3095..b68b219 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -8,6 +8,7 @@ tests += {
   'hello-i386.c': {
     'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
   },
+  'modify-ldt.c': {},
   'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
   'test-i386-adcox.c': {'cflags': ['-O2']},
   'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
diff --git a/tests/tcg/i386/modify-ldt.c b/tests/tcg/i386/modify-ldt.c
new file mode 100644
index 0000000..4bfa4ea
--- /dev/null
+++ b/tests/tcg/i386/modify-ldt.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#define _GNU_SOURCE
+#include <asm/ldt.h>
+#include <assert.h>
+#include <errno.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+static void check_entry(const struct user_desc *desc, int func,
+                        uint64_t expected)
+{
+    uint64_t entries[2];
+
+    assert(syscall(SYS_modify_ldt, func, desc, sizeof(*desc)) == 0);
+    assert(syscall(SYS_modify_ldt, 0, entries, sizeof(entries)) ==
+           sizeof(entries));
+    /* Linux sets the accessed bit when installing a descriptor. */
+    assert((entries[desc->entry_number] & ~(UINT64_C(1) << 40)) == expected);
+}
+
+int main(void)
+{
+    struct user_desc desc = {
+        .entry_number = 1,
+        .base_addr = 0x89abcdef,
+        .limit = 0x54321,
+        .seg_32bit = 1,
+        .limit_in_pages = 1,
+        .useable = 1,
+    };
+    const unsigned int invalid_sizes[] = {0, 15, 17, 24};
+
+    _Static_assert(sizeof(desc) == 16, "modify_ldt user_desc must be 16 bytes");
+    for (unsigned int i = 0;
+         i < sizeof(invalid_sizes) / sizeof(invalid_sizes[0]); i++) {
+        long ret = syscall(SYS_modify_ldt, 0x11, &desc, invalid_sizes[i]);
+
+        /* Linux returns int-sized errors; libc may have translated them. */
+        assert((int)ret == -EINVAL || (ret == -1 && errno == EINVAL));
+    }
+    for (int func = 1; func <= 0x11; func += 0x10) {
+        for (int contents = MODIFY_LDT_CONTENTS_DATA;
+             contents <= MODIFY_LDT_CONTENTS_CODE; contents += 2) {
+            uint64_t expected = UINT64_C(0x89c5f2abcdef4321);
+
+            desc.contents = contents;
+            if (contents == MODIFY_LDT_CONTENTS_CODE) {
+                expected |= UINT64_C(1) << 43;
+            }
+            if (func == 0x11) {
+                expected |= UINT64_C(1) << 52;
+            }
+            check_entry(&desc, func, expected);
+#ifdef __x86_64__
+            desc.lm = 1;
+            check_entry(&desc, func, expected);
+            desc.lm = 0;
+#endif
+        }
+    }
+    desc = (struct user_desc) {
+        .entry_number = 1,
+        .read_exec_only = 1,
+        .seg_not_present = 1,
+    };
+#ifdef __x86_64__
+    desc.lm = 1;
+#endif
+    check_entry(&desc, 0x11, 0);
+    return 0;
+}
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index ad4d1f5..56f4e8a 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -25,6 +25,7 @@ test_mmx_h = custom_target('test_mmx_h',
                            output: 'test-mmx.h')
 
 tests += {
+  '../i386/modify-ldt.c': {},
   '../i386/test-i386-ssse3.c': {},
   '../i386/test-3dnow.c': {
     'cflags': ['-I', meson.current_build_dir(),
-- 
2.55.0


