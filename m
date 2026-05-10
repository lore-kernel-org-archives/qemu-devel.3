Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D85CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx6-0005BS-MG; Sun, 10 May 2026 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx0-000598-1V
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:35 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwy-00045P-4f
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:33 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48270ea6dd1so168873b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445630; x=1779050430; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hFVHCN58pY4Te0rUYFWkIZamhOgAdl/wBYf7gt8R5Bs=;
 b=WibnxKfk06+boWBTskBPz1jXz5ajuYy7I8p3WCZ/A5x0HiX30ptKBJ4LIA5BnMUiZL
 3sEr8+I3sLFNCWH4Y9in8vPmMr/tTunKJIFniTTacUCM5RDux/Q7aFlygbqep8hSuCbB
 C2Tjjnmxx0b4nlfccEUF1Kc1JPPsHXPqPQ4wo+MlUCX0v9xU+H6B0rJZ7NJE24itDwcX
 lyHy69Mfp1R9osrKQEjAEg/D9pMWxSiFHsH+jet0OKuY5rQ+8ArJaUwjNfWBoLxsq3EH
 YhdlSSBP/qeZmIWjXzBT22u8cim2flDMVYWNf+6SmugqBDNr6EjN9gnToHD/KbI45pVM
 xFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445630; x=1779050430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hFVHCN58pY4Te0rUYFWkIZamhOgAdl/wBYf7gt8R5Bs=;
 b=DHmJTbyAgiNV82ufb0yKveUq+dl7YxNs8MLk51Ke9ivgZMDoaxhvrcM8YApxG7sOaQ
 byRu6IKXbaVtWTGXsMRMgNQe/Vj4Dt4wchyfiurpbBlaikY4asoz2Buv4wkxZo/x4OQx
 gqw7Df4DHG3gXbglKZuXfuhJTBmKmnXE7E5D9e/h33S5ZpQqMCFH9PThBZfIv0iurLDZ
 Nib6tq+QqsjmrAc6ealWAn1EbkgMBRUwtwnXnoObQ7if31FxY9/Gg27CqOd8RCvLCzSS
 94bzM7YEsdpFDW1o0Sh8Vdv2CmmjVx7CuBdauHiFXVf4zvAn8b6UxTfHNOkhcwTBkQ7C
 6hEA==
X-Gm-Message-State: AOJu0YySXGZ0Xj6fNOaHy1zE8kyCLgWv7Kd5An7kL3RW1Iwi9K8UcDTR
 156zcsUqT9HYZrH79BskrwuCMIqxSLy2rnWVxRbldgfN8bx3choAY9W2
X-Gm-Gg: Acq92OHyS1/8yL5o6tDeb//fUNyNZD8duMSwSWzvnjNgTgVFHzot2oV8nYhTEbsNkvi
 7LaJFHNRzO2uypijMa6D7NZ/f2UDRQdXXsvm/qZA/RwMo/O6rRPCcaOFT8gbFNtfRTaEnSkJWm5
 1zrQUKBpFdgNkaCJ6mVNSUGy0gUY8Jt5i2bf6uZDKK6numexdtrZkkoKr+ugdCy+S9EI/RRdiEK
 RXuY38fmsDYdtmZikuahS5Mk6bh58qDYrkHIOKTwWtO3VLFUyGaRFd2iRI5emazxQwJqwmh7HJ/
 9Aouf51BjZvcxuotHIGqyqu3WbWW9ATB311OayU7RTz4k+Qu8emFRYKc7GfpPEp/7Kcu903opVe
 75PrMwCS+oyq5yrqxKbB8sdRr8XDSyN+qjFZ5eYgS5+aflRSeSSLrM73b4tgKDS5MC7pRYAq5Bd
 R66/sK4yJj/V8ir+cbub7UfmCwfNJPsJ6SDHneWy4O/GFlXW4dkWlXp7wJ1VWszVbcvAfVdXbfA
 uFMvr8nSNdJpPyzMwBOqtGCHHNV8TEFAZg3Fk0M4o8=
X-Received: by 2002:a05:6808:3448:b0:47c:3733:255a with SMTP id
 5614622812f47-4804223f6admr12024545b6e.16.1778445629956; 
 Sun, 10 May 2026 13:40:29 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:54 -0600
Subject: [PATCH v5 24/32] tests/tcg/mips: add Octeon instruction smoke test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-24-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon integer, comparison, population count, and multiplier instruction
paths.

Run the test with -cpu Octeon68XX and share the source between the
mips64 and mips64el target directories.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split the smoke test out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 MAINTAINERS                                   |   2 +
 tests/tcg/mips/Makefile.target                |  11 ++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 145 ++++++++++++++++++++++++++
 tests/tcg/mips64/Makefile.target              |  20 ++++
 tests/tcg/mips64el/Makefile.target            |   8 ++
 5 files changed, 186 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..9501aaf36c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -311,6 +311,8 @@ F: target/mips/
 F: disas/*mips.c
 F: docs/system/cpu-models-mips.rst.inc
 F: tests/tcg/mips/
+F: tests/tcg/mips64/
+F: tests/tcg/mips64el/
 
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 5d17c1706e..d9dc16f8ec 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -8,6 +8,17 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 # Set search path for all sources
 VPATH 		+= $(MIPS_SRC)
 
+ifneq ($(findstring 64,$(TARGET_NAME)),)
+VPATH += $(MIPS_SRC)/user/isa/octeon
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+octeon-insns: CFLAGS+=-mabi=64
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
+endif
+
 # hello-mips is 32 bit only
 ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 0000000000..e9db93d1b6
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,145 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+int main(void)
+{
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..042855844a
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..dbc5f8dc5f
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target

-- 
2.54.0


